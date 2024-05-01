import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:gap/gap.dart';
import 'package:samastha/core/app_constants.dart';
import 'package:samastha/gen/assets.gen.dart';
import 'package:samastha/modules/student/bloc/mcq_controller.dart';
import 'package:samastha/modules/student/models/mcq_instructions.dart';
import 'package:samastha/modules/student/screens/mcq/quiz_screen.dart';
import 'package:samastha/theme/dimensions.dart';
import 'package:samastha/theme/t_style.dart';
import 'package:samastha/utils/error_reload.dart';
import 'package:samastha/widgets/app_bars_custom.dart';
import 'package:samastha/widgets/custom_form_elements.dart';
import 'package:samastha/widgets/default_loading_widget.dart';

class MCQWelcomeScreen extends StatefulWidget {
  const MCQWelcomeScreen({super.key, required this.studentId});
  static const String path = '/mcq-welcome';

  final int studentId;

  @override
  State<MCQWelcomeScreen> createState() => _MCQWelcomeScreenState();
}

class _MCQWelcomeScreenState extends State<MCQWelcomeScreen> {
  MCQController bloc = MCQController();

  // late Future<McqInstructionModel> future;
  late Future<List<String>> future;

  @override
  void initState() {
    future = bloc.fetchInstructions(widget.studentId);
    super.initState();
  }

  // int? examId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SimpleAppBar(
        title: 'MCQ Test',
      ),
      bottomNavigationBar: Padding(
        padding: pagePadding.copyWith(
            bottom: MediaQuery.paddingOf(context).bottom + 10),
        child: SubmitButton(
          'Start Test',
          onTap: (loader) {
            if (AppConstants.temExamIdMCQ != null) {
              Navigator.pushNamed(context, MCQQuizScreen.path, arguments: {
                'studentId': widget.studentId,
                'examId': AppConstants.temExamIdMCQ!
              });
            }
          },
        ),
      ),
      body: FutureBuilder<List<String>>(
          future: future,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return errorReload(snapshot.error.toString(), onTap: () {
                setState(() {
                  future = bloc.fetchInstructions(widget.studentId);
                });
              });
            }

            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return const LoadingWidget();
              case ConnectionState.active:
              case ConnectionState.done:
                // examId = snapshot.data?.id;
                List<String> list = snapshot.data ?? [];
                return SingleChildScrollView(
                  padding: pagePadding.copyWith(bottom: 20),
                  child: Column(
                    children: [
                      Assets.image.mcqtest
                          .image(height: 142, width: double.infinity),
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
                            // Html(
                            //   data: snapshot.data?.instructions ?? '',
                            //   shrinkWrap: true,

                            //   // style: bodyMedium.grey1,
                            // ),
                            // ...[
                            //   1,
                            //   2,
                            //   3,
                            // ]
                                ...list.map((e) => Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 16),
                                      child: Row(
                                        children: [
                                          Assets.image.blueTick.image(),
                                          const Gap(16),
                                          Expanded(
                                            child: Text(
                                              e,
                                              style: bodyMedium.grey1,
                                            ),
                                          )
                                        ],
                                      ),
                                    ))
                                .toList(),
                          ],
                        ),
                      ),
                      const Gap(20),
                    ],
                  ),
                );

              default:
                return Container();
            }
          }),
    );
  }
}
