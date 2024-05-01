import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:samastha/gen/assets.gen.dart';
import 'package:samastha/modules/student/models/assignment_model.dart';
import 'package:samastha/theme/color_resources.dart';
import 'package:samastha/theme/t_style.dart';
import 'package:samastha/widgets/custom_form_elements.dart';

// ignore: must_be_immutable
class AssignmentMarkSheetScreen extends StatelessWidget {
  static const String path = '/assignment-mark-sheet';
  AssignmentMarkSheetScreen({super.key, this.assignmentModel});

  AssignmentModel? assignmentModel;

  @override
  Widget build(BuildContext context) {
    log('is my mark data Explained is ${assignmentModel?.submission?.mark}');
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
              child: Padding(
                padding: pagePadding.copyWith(bottom: 20),
                child: Column(
                  // shrinkWrap: true,
                  children: [
                    const Gap(20),
                    Assets.image.marksheetTest.image(height: 229),
                    const Gap(60),
                    Text(
                      'Mark obtained',
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
                          assignmentModel?.submission?.mark.toString() ?? '50',
                          style: GoogleFonts.openSans(
                            fontSize: 53,
                            fontWeight: FontWeight.w700,
                            color: ColorResources.secondary,
                          ),
                        ),
                        Text(
                          '/${(assignmentModel?.submission?.mark ?? '150')}',
                          style: GoogleFonts.openSans(
                            fontSize: 53,
                            fontWeight: FontWeight.w700,
                            color: ColorResources.primary,
                          ),
                        ),
                      ],
                    ),
                    // Container(

                    //   width: 272,
                    //   padding: const EdgeInsets.symmetric(
                    //       horizontal: 19, vertical: 13),
                    //   decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(12),
                    //       color: ColorResources.WHITE,
                    //       boxShadow: [
                    //         BoxShadow(
                    //             blurRadius: 12,
                    //             color: const Color(0xff000000).withOpacity(.1),
                    //             offset: const Offset(0, 4),
                    //             spreadRadius: 0)
                    //       ]),
                    //   child: Column(
                    //     mainAxisSize: MainAxisSize.min,
                    //     children: [
                    //       Row(
                    //         // mainAxisSize: MainAxisSize.min,
                    //         children: [
                    //           Assets.svgs.correctAnswer.svg(),
                    //           const Gap(12),
                    //           Text(
                    //             'Correct Answers',
                    //             style: labelMedium.darkBG,
                    //           ),
                    //           const Spacer(),
                    //           Text(
                    //             '15',
                    //             style: labelMedium.darkBG,
                    //           )
                    //         ],
                    //       ),
                    //       const Gap(12),
                    //       Row(
                    //         // mainAxisSize: MainAxisSize.min,
                    //         children: [
                    //           Assets.svgs.wrongAnswer.svg(),
                    //           const Gap(12),
                    //           Text(
                    //             'Wrong Answers',
                    //             style: labelMedium.darkBG,
                    //           ),
                    //           const Spacer(),
                    //           Text(
                    //             '15',
                    //             style: labelMedium.darkBG,
                    //           )
                    //         ],
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    const Spacer(),
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
