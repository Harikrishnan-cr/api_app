import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:samastha/core/app_constants.dart';
import 'package:samastha/gen/assets.gen.dart';
import 'package:samastha/theme/dimensions.dart';
import 'package:samastha/theme/t_style.dart';
import 'package:samastha/widgets/app_bars_custom.dart';
import 'package:samastha/widgets/custom_form_elements.dart';

class LiveClassWelcomeScreen extends StatelessWidget {
  const LiveClassWelcomeScreen({super.key});
  static const String path = '/live-class-welcome-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SimpleAppBar(title: 'Live class'),
      body: SingleChildScrollView(
        padding: pagePadding,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Assets.icon.classRoom.image(height: 32),
                      const Gap(12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Class',
                            style: labelMedium.darkBG,
                          ),
                          Text(
                            'Class 2',
                            style: titleLarge.primary,
                          ),
                        ],
                      )
                    ],
                  ),
                  Container(
                    color: const Color(0xff000000),
                    width: 1,
                    height: 40,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Assets.icon.batch.image(height: 32),
                      const Gap(12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Class',
                            style: labelMedium.darkBG,
                          ),
                          Text(
                            'UKSP12',
                            style: titleLarge.primary,
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
            const Gap(12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: defaultDecoration,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Instructions',
                    style: titleLarge.secondary,
                  ),
                  const Gap(17),
                  ...[
                    1,
                    2,
                    3,
                  ]
                      .map((e) => Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: Row(
                              children: [
                                Assets.image.blueTick.image(),
                                const Gap(16),
                                Expanded(
                                  child: Text(
                                    AppConstants.lorem,
                                    style: bodyMedium.grey1,
                                  ),
                                )
                              ],
                            ),
                          ))
                      ,
                ],
              ),
            ),
            const Gap(20),
            SubmitButton(
              'Join Class',
              onTap: (loader) {
                
              },
            ),
          ],
        ),
      ),
    );
  }
}
