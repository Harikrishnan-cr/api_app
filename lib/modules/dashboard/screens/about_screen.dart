import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:samastha/core/app_constants.dart';
import 'package:samastha/theme/dimensions.dart';
import 'package:samastha/theme/t_style.dart';
import 'package:samastha/widgets/app_bars_custom.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});
  static const String path = '/about';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SimpleAppBar(title: 'About'),
      body: SingleChildScrollView(
          padding: pagePadding,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: defaultDecoration,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'About Samastha e learning',
                  style: titleLarge.darkBG,
                ),
                const Gap(13),
                Text(
                  AppConstants.lorem,
                  style: bodyMedium.darkBG,
                )
              ],
            ),
          )),
    );
  }
}
