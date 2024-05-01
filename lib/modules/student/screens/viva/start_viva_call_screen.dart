import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:samastha/core/app_constants.dart';
import 'package:samastha/gen/assets.gen.dart';
import 'package:samastha/modules/student/screens/viva/completed_viva_screen.dart';
import 'package:samastha/theme/dimensions.dart';
import 'package:samastha/theme/t_style.dart';
import 'package:samastha/widgets/app_bars_custom.dart';
import 'package:samastha/widgets/custom_form_elements.dart';

class StartVivaCallScreen extends StatelessWidget {
  const StartVivaCallScreen({super.key});
  static const String path = '/start-viva-call';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SimpleAppBar(title: 'VIVA Call'),
      bottomNavigationBar: Padding(
        padding: pagePadding.copyWith(
            bottom: MediaQuery.paddingOf(context).bottom + 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomOutlineButton(
              'Attend on web app',
              onTap: (loader) {},
            ),
            const Gap(8),
            SubmitButton(
              'Start Test',
              onTap: (loader) {
                Navigator.pushNamed(context, CompletedVivaScreen.path);
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: pagePadding.copyWith(bottom: 20),
        child: Column(
          children: [
            Assets.image.vivaCall.image(height: 142),
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
          ],
        ),
      ),
    );
  }
}
