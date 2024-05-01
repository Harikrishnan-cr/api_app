import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:gap/gap.dart';
import 'package:samastha/gen/assets.gen.dart';
import 'package:samastha/modules/student/bloc/quiz_controller.dart';
import 'package:samastha/modules/student/models/quizz_instruction_model.dart';
import 'package:samastha/modules/student/screens/tests_assignments/quiz_question_screen.dart';
import 'package:samastha/theme/dimensions.dart';
import 'package:samastha/theme/t_style.dart';
import 'package:samastha/widgets/app_bars_custom.dart';
import 'package:samastha/widgets/custom_form_elements.dart';
import 'package:samastha/widgets/default_loading_widget.dart';

class QuizWelcomeScreen extends StatefulWidget {
  const QuizWelcomeScreen(
      {super.key,
      required this.quizzName,
      required this.quizzId,
      required this.studentId});
  static const String path = '/quiz-welcome-screen';
  final String quizzName;
  final int quizzId;
  final int studentId;

  @override
  State<QuizWelcomeScreen> createState() => _QuizWelcomeScreenState();
}

class _QuizWelcomeScreenState extends State<QuizWelcomeScreen> {
  QuizzController bloc = QuizzController();

  late Future quizInstructionsFuture;

  @override
  void initState() {
    quizInstructionsFuture =
        bloc.fetchQuizzeInstructions(widget.quizzId, widget.studentId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(title: widget.quizzName),
      bottomNavigationBar: Padding(
        padding: pagePadding.copyWith(bottom: 10),
        child: SubmitButton(
          'Start Exam',
          onTap: (loader) {
            Navigator.pushNamed(context, QuizQuestionScreen.path, arguments: {
              'quizzId': widget.quizzId,
              'quizzName': widget.quizzName,
              'studentId': widget.studentId
            });
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: pagePadding.copyWith(bottom: 20),
        child: Column(
          children: [
            Assets.image.monthlyExamBanner.image(
              width: double.infinity,
            ),
            const Gap(12),
            FutureBuilder(
                future: quizInstructionsFuture,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  }

                  switch (snapshot.connectionState) {
                    case ConnectionState.done:
                      List<QuizzInstructionsModel> newExamInstructionsList =
                          snapshot.data ?? [];

                      List<String> instructionList = newExamInstructionsList[0].instructions ?? [];

                      print('quiz InstList ${newExamInstructionsList.length}');

                      return instructionList.isEmpty
                          ? const Center(
                              child: Text('Exam Not Found'),
                            )
                          : Container(
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
                                  ListView.builder(
                                      itemCount: instructionList.length,
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 16),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 18.0),
                                                child: Assets.image.blueTick
                                                    .image(),
                                              ),
                                              const Gap(16),
                                              SizedBox(
                                                  width: 247,
                                                  child: Html(
                                                    data:
                                                        instructionList[
                                                                index]
                                                            ,
                                                    shrinkWrap: true,
                                                  )),
                                            ],
                                          ),
                                        );
                                      })
                                ],
                              ),
                            );
                    case ConnectionState.waiting:
                      return const Center(child: LoadingWidget());
                    default:
                      return Container();
                  }
                }),
            const Gap(20),
          ],
        ),
      ),
    );
  }
}
