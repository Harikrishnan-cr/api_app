import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:gap/gap.dart';
import 'package:samastha/core/app_constants.dart';
import 'package:samastha/gen/assets.gen.dart';
import 'package:samastha/modules/student/bloc/exam_controller.dart';
import 'package:samastha/modules/student/models/exam_instruction_model.dart';
import 'package:samastha/modules/student/screens/tests_assignments/exam_questions_screen.dart';
import 'package:samastha/theme/dimensions.dart';
import 'package:samastha/theme/t_style.dart';
import 'package:samastha/widgets/app_bars_custom.dart';
import 'package:samastha/widgets/custom_form_elements.dart';
import 'package:samastha/widgets/default_loading_widget.dart';

class ExamWelcomeScreen extends StatefulWidget {
  const ExamWelcomeScreen(
      {super.key, required this.examId, required this.examName});
  static const String path = '/exam-welcome-screen';
  final int examId;
  final String examName;

  @override
  State<ExamWelcomeScreen> createState() => _ExamWelcomeScreenState();
}

class _ExamWelcomeScreenState extends State<ExamWelcomeScreen> {
  ExamController bloc = ExamController();
  late Future examInstructionFuture;

  @override
  void initState() {
    examInstructionFuture =
        bloc.fetchExamInstructions(widget.examId, AppConstants.studentID);
    super.initState();
  }

  // List<String> extractParagraphs(String content) {
  //   List<String> paragraphs = [];
  //   RegExp regex = RegExp(r'<p>(.*?)<\/p>');

  //   Iterable<Match> matches = regex.allMatches(content);
  //   for (Match match in matches) {
  //     paragraphs.add(match.group(1)!);
  //   }

  //   return paragraphs;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(title: widget.examName),
      bottomNavigationBar: Padding(
        padding: pagePadding.copyWith(bottom: 10),
        child: SubmitButton(
          'Start Exam',
          onTap: (loader) {
            Navigator.pushNamed(context, ExamQuestionScreen.path, arguments: {
              'examId': widget.examId,
              'examName': widget.examName,
              'studentId': AppConstants.studentID //todo sourav
            });
            // arguments: {'studentId': widget.studentId, 'examId': examId});
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
                future: examInstructionFuture,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  }

                  switch (snapshot.connectionState) {
                    case ConnectionState.done:
                      List<ExamInstructionsModel> newExamInstructionsList =
                          snapshot.data ?? [];

                      List<String> instructionList = newExamInstructionsList[0].instructions ?? [];
                      // try {
                      //   List<String> paragraphs = extractParagraphs(
                      //       newExamInstructionsList[0].instructions![0]);
                      //   print('paragraphs $paragraphs');
                      // } catch (e) {
                      //   print('error $e');
                      // }

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
