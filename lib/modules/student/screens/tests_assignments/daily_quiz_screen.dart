import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:samastha/core/app_constants.dart';
import 'package:samastha/helper/date_converter.dart';
import 'package:samastha/modules/student/screens/mcq/marksheet_screen.dart';
import 'package:samastha/modules/student/screens/tests_assignments/solution_screen.dart';
import 'package:samastha/theme/color_resources.dart';
import 'package:samastha/theme/dimensions.dart';
import 'package:samastha/theme/t_style.dart';
import 'package:samastha/widgets/app_bars_custom.dart';
import 'package:samastha/widgets/custom_form_elements.dart';
import 'package:timer_count_down/timer_count_down.dart';

class DailyQuizScreen extends StatefulWidget {
  const DailyQuizScreen({super.key});
  static const String path = '/daily-quiz';

  @override
  State<DailyQuizScreen> createState() => _DailyQuizScreenState();
}

class _DailyQuizScreenState extends State<DailyQuizScreen> {
  int currentQuestion = 4;
  int selectedAnswer = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SimpleAppBar(title: 'Quiz 1'),
      body: ListView(
        padding: pagePadding.copyWith(bottom: 20),
        children: [
          const Gap(12),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 11),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 30,
                    offset: Offset(0, 10),
                    spreadRadius: 0,
                    color: Color(0xffF0F0F0),
                  )
                ]),
            child: Column(
              children: [
                Text(
                  'Time Remaining',
                  style: labelSmall.red,
                ),
                const Gap(8),
                Countdown(
                  seconds: const Duration(minutes: 3, seconds: 45).inSeconds,
                  build: (BuildContext context, double time) => Text(
                    // '00:10 Sec',
                    '${formatHHMMSS(time.toInt())} Sec',
                    style: titleMedium.red,
                  ),
                  interval: const Duration(seconds: 1),
                  onFinished: () {
                    print('Timer is done!');
                  },
                )
              ],
            ),
          ),
          const Gap(12),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 11),
            decoration: defaultDecoration,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(100, (index) => index)
                    .toList()
                    .map(
                      (e) => InkWell(
                        onTap: () {
                          setState(() {
                            currentQuestion = e;
                          });
                        },
                        child: Opacity(
                          opacity: (currentQuestion - e).abs() > 2 ? 0.3 : 1.0,
                          // Adjust the fading threshold as needed
                          child: CircleAvatar(
                            backgroundColor: currentQuestion == e
                                ? ColorResources.textFiledBorder
                                : Colors.transparent,
                            radius: 15,
                            child: Text(
                              e.toString(),
                              style: currentQuestion == e
                                  ? labelLarge.white
                                  : labelLarge.secondary,
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
          const Gap(12),
          Container(
              padding: const EdgeInsets.symmetric(vertical: 11, horizontal: 11),
              decoration: defaultDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$currentQuestion .',
                    style: titleMedium.darkBG,
                  ),
                  const Gap(5),
                  Expanded(
                    child: Text(
                      AppConstants.lorem,
                      style: titleMedium.darkBG,
                    ),
                  )
                ],
              )),
          const Gap(12),
          ...[1, 2, 3, 4]
              .map(
                (e) => GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedAnswer = e;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 11, horizontal: 11),
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: e == selectedAnswer
                            ? ColorResources.primary
                            : Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            blurRadius: 30,
                            offset: Offset(0, 10),
                            spreadRadius: 0,
                            color: Color(0xffF0F0F0),
                          )
                        ]),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundColor: e == selectedAnswer
                              ? Colors.white
                              : const Color(0xffEBEBEB),
                          child: Text(
                            'A',
                            style: e == selectedAnswer
                                ? bodyMedium.primary
                                : bodyMedium.darkBG,
                          ),
                        ),
                        const Gap(10),
                        Expanded(
                          child: Text(
                            AppConstants.lorem,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
              ,
          const Gap(40),
          CustomOutlineButton(
            selectedAnswer == 0 ? 'Skip Question' : 'View Solution',
            onTap: (loader) {
              Navigator.pushNamed(context, SolutionScreen.path);
            },
          ),
          const Gap(12),
          CustomOutlineButton(
            'Next',
            onTap: (loader) {
              Navigator.pushNamed(
                  AppConstants.globalNavigatorKey.currentState!.context,
                  MCQMarkSheetScreen.path);
            },
            textColor: Colors.white,
            bgColor: ColorResources.secondary,
          ),
        ],
      ),
    );
  }
}
