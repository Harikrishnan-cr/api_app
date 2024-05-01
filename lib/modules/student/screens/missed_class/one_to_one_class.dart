import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:samastha/core/app_constants.dart';
import 'package:samastha/gen/assets.gen.dart';
import 'package:samastha/modules/student/bloc/missed_class/missed_class_controller.dart';
import 'package:samastha/modules/student/screens/missed_class/one_to_one_schedule_screen.dart';
import 'package:samastha/theme/dimensions.dart';
import 'package:samastha/theme/t_style.dart';
import 'package:samastha/widgets/app_bars_custom.dart';
import 'package:samastha/widgets/custom_form_elements.dart';
import 'package:samastha/widgets/default_loading_widget.dart';

class OneToOneClassWelcomeScreen extends StatelessWidget {
  const OneToOneClassWelcomeScreen(
      {super.key, required this.missedClassId, required this.subjectId});
  static const String path = '/one-to-one-welcome-screen';
  final int missedClassId;
  final int subjectId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SimpleAppBar(title: 'One to One Class'),
      bottomNavigationBar: Padding(
        padding: pagePadding.copyWith(
            bottom: MediaQuery.paddingOf(context).bottom + 4),
        child: SubmitButton(
          'Book',
          onTap: (_) {
            Navigator.pushNamed(context, OneToOneScheduleScreen.path,
                arguments: {
                  "studentId": subjectId,
                  "missedClassId": missedClassId
                });
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: pagePadding.copyWith(bottom: 20),
        child: Column(
          children: [
            Assets.image.one2oneclassbanner.image(
              width: double.infinity,
            ),
            const Gap(12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: defaultDecoration,
              child: FutureBuilder(
                  future: MissedClassController().fetchInstructions(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      List<String>? instructions = snapshot.data ?? [];

                      // var document = html_parser
                      //     .parse(instructions[0].instructions?[0].content);

                      // List<String> listItems =
                      //     document.querySelectorAll('li').map((element) {
                      //   return element.text;
                      // }).toList();

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Instructions',
                            style: titleLarge.copyWith(
                                color: const Color(0xff10A089)),
                          ),
                          const Gap(17),
                          if (instructions.isNotEmpty)
                            ...instructions.map((e) => Padding(
                                  padding: const EdgeInsets.only(bottom: 20),
                                  child: Row(
                                    children: [
                                      Assets.image.blueTick.image(),
                                      const Gap(16),
                                      Expanded(
                                        child: Text(
                                          e,
                                          // style: bodyMedium.grey1,
                                        ),
                                      )
                                    ],
                                  ),
                                )),
                        ],
                      );
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const LoadingWidget();
                    } else {
                      return const SizedBox();
                    }
                  }),
            ),
            const Gap(20),
          ],
        ),
      ),
    );
  }
}
