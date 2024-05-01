import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:samastha/gen/assets.gen.dart';
import 'package:samastha/modules/student/models/mark_sheet_model.dart';
import 'package:samastha/theme/color_resources.dart';
import 'package:samastha/theme/t_style.dart';
import 'package:samastha/widgets/custom_form_elements.dart';
import 'package:screenshot/screenshot.dart';
import 'package:social_share/social_share.dart';

class MarkSheetScreen extends StatelessWidget {
  const MarkSheetScreen({super.key, required this.markSheetModel});
  final MarkSheetModel markSheetModel;
  static final ScreenshotController _screenshotController =
      ScreenshotController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Assets.image.marksheetBg.image(),
            ),
            SizedBox(
              height: double.infinity,
              child: SingleChildScrollView(
                padding: pagePadding,
                child: Column(
                  // shrinkWrap: true,
                  children: [
                    Screenshot(
                      controller: _screenshotController,
                      child: Container(
                        color: ColorResources.WHITE,
                        child: Column(
                          children: [
                            const Gap(20),
                            Assets.image.marksheetTest.image(height: 229),
                            const Gap(30),
                            Text(
                              'Successfully\nCompleted your Exam',
                              textAlign: TextAlign.center,
                              style: titleLarge.primary,
                            ),
                            const Gap(30),
                            Text(
                              'Your score',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.openSans(
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xff001319),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '50',
                                  style: GoogleFonts.openSans(
                                    fontSize: 53,
                                    fontWeight: FontWeight.w700,
                                    color: ColorResources.secondary,
                                  ),
                                ),
                                Text(
                                  '/150',
                                  style: GoogleFonts.openSans(
                                    fontSize: 53,
                                    fontWeight: FontWeight.w700,
                                    color: ColorResources.primary,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              width: 272,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 19, vertical: 13),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: ColorResources.WHITE,
                                  boxShadow: [
                                    BoxShadow(
                                        blurRadius: 12,
                                        color: const Color(0xff000000)
                                            .withOpacity(.1),
                                        offset: const Offset(0, 4),
                                        spreadRadius: 0)
                                  ]),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    // mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Assets.svgs.correctAnswer.svg(),
                                      const Gap(12),
                                      Text(
                                        'Correct Answers',
                                        style: labelMedium.darkBG,
                                      ),
                                      const Spacer(),
                                      Text(
                                        '15',
                                        style: labelMedium.darkBG,
                                      )
                                    ],
                                  ),
                                  const Gap(12),
                                  Row(
                                    // mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Assets.svgs.wrongAnswer.svg(),
                                      const Gap(12),
                                      Text(
                                        'Wrong Answers',
                                        style: labelMedium.darkBG,
                                      ),
                                      const Spacer(),
                                      Text(
                                        '15',
                                        style: labelMedium.darkBG,
                                      ),
                                      const Gap(25),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              'Mabrook',
                              style: GoogleFonts.orelegaOne(
                                fontSize: 28,
                                fontWeight: FontWeight.normal,
                                color: const Color(0xff0BAA56),
                              ),
                            ),
                            Text(
                              'You have qualified for viva\nKindly attend viva',
                              style: labelMedium.darkBG,
                              textAlign: TextAlign.center,
                            ),
                            const Gap(18),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        try {
                          var data = await _screenshotController.capture();
                          if (data == null) {
                            return;
                          }
                          final tempDir = await getTemporaryDirectory();
                          final assetPath = '${tempDir.path}/temp.png';
                          File file = await File(assetPath).create();
                          await file.writeAsBytes(data);
                          SocialShare.shareOptions('', imagePath: file.path);
                        } catch (e) {
                          debugPrint('share error : $e');
                        }
                      },
                      child: Container(
                        width: 110,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          // color: Colors.white,
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 12),
                        child: Row(
                          children: [
                            Text(
                              'Share now',
                              style: labelMedium.copyWith(
                                  color: const Color(0xff001319)),
                            ),
                            const Spacer(),
                            Assets.image.share.image(
                                height: 20, color: ColorResources.primary)
                          ],
                        ),
                      ),
                    ),
                    // const Gap(18),
                    CupertinoButton(
                      child: Text(
                        'View Solution',
                        style: titleSmall.secondary,
                      ),
                      onPressed: () {},
                    ),
                    const Gap(35),
                    SubmitButton(
                      'Go Back',
                      onTap: (loader) {
                        Navigator.pop(context);
                      },
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
