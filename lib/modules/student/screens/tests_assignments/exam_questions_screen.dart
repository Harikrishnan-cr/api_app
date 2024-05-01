import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:samastha/helper/date_converter.dart';
import 'package:samastha/modules/student/bloc/exam_controller.dart';
import 'package:samastha/modules/student/models/exam_questions_model.dart';
import 'package:samastha/modules/student/screens/tests_assignments/exam_marksheet.dart';
import 'package:samastha/modules/student/screens/tests_assignments/exam_solution_screen.dart';
import 'package:samastha/theme/color_resources.dart';
import 'package:samastha/theme/dimensions.dart';
import 'package:samastha/theme/t_style.dart';
import 'package:samastha/utils/count_down_timer.dart';
import 'package:samastha/utils/error_reload.dart';
import 'package:samastha/widgets/app_bars_custom.dart';
import 'package:samastha/widgets/custom_form_elements.dart';
import 'package:samastha/widgets/custom_snackbar.dart';
import 'package:samastha/widgets/default_loading_widget.dart';

class ExamQuestionScreen extends StatefulWidget {
  const ExamQuestionScreen(
      {super.key,
      required this.examId,
      required this.examName,
      required this.studentId});
  static const String path = '/exam-question';
  final int examId;
  final int studentId;
  final String examName;
  @override
  State<ExamQuestionScreen> createState() => _ExamQuestionScreenState();
}

class _ExamQuestionScreenState extends State<ExamQuestionScreen> {
  ExamQuestionsData? examModel;
  ExamQuestion? currentQuestion;
  late Future examQuestionsFuture;
  int? timeTaken;
  ExamController bloc = ExamController();
  // CountdownController timeController = CountdownController();
  final CountdownTimer _countdownTimer = CountdownTimer();
  Stream<int>? timerStream;

  @override
  void initState() {
    examQuestionsFuture = bloc.fetchExamQuestions(widget.examId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(title: widget.examName),
      body: FutureBuilder(
          future: examQuestionsFuture,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return errorReload(snapshot.error.toString(), onTap: () {
                setState(() {
                  examQuestionsFuture = bloc.fetchExamQuestions(widget.examId);
                });
              });
            }

            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return const LoadingWidget();

              case ConnectionState.done:
              case ConnectionState.active:
                examModel ??= snapshot.data;
                currentQuestion ??= examModel?.examQuestions!.first;
                // timeController.start();
                print('examModel!.examPool!.durationInMin ${examModel!.examPool!.durationInMin}');
                timerStream ??= _countdownTimer.countdownStream(
                    Duration(minutes: examModel!.examPool!.durationInMin ?? 10)
                        .inSeconds);

                return examModel == null
                    ? const Text("Something went wrong!")
                    : ListView(
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
                                StreamBuilder<int>(
                                  stream: timerStream,
                                  builder: (BuildContext context,
                                      AsyncSnapshot<int> snapshot) {
                                    if (snapshot.hasData) {
                                      var timeString =
                                          formatHHMMSS(snapshot.data!.toInt());
                                      timeTaken = snapshot.data!.toInt();
                                      if (timeString == "00") {
                                        debugPrint('countdown finish');
                                        _countdownTimer.stopTimer();
                                        submit();
                                      }
                                      return Text(
                                        '$timeString Sec',
                                        style: titleMedium.red,
                                      );
                                    } else {
                                      return Text(
                                        '00 Sec',
                                        style: titleMedium.red,
                                      );
                                    }
                                  },
                                ),
                                // Countdown(
                                //   // controller: timeController,
                                //   seconds: Duration(
                                //           minutes: examModel!
                                //                   .examPool!.durationInMin ??
                                //               10)
                                //       .inSeconds,
                                //   build: (BuildContext context, double time) {
                                //     timeTaken = (Duration(
                                //                 minutes: examModel!
                                //                     .examPool!.durationInMin!)
                                //             .inSeconds -
                                //         time);

                                //     return Text(
                                //       '${formatHHMMSS(time.toInt())} Sec',
                                //       style: titleMedium.red,
                                //     );
                                //   },
                                //   interval: const Duration(seconds: 1),
                                //   onFinished: () {
                                //     //submit result
                                //     debugPrint('timer complete');
                                //     // submit();
                                //   },
                                // ),
                              ],
                            ),
                          ),
                          const Gap(12),
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 11),
                            decoration: defaultDecoration,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
              
                              child:Row(
                                children: examModel!.examQuestions!
                                    .map(
                                      (e) => InkWell(
                                        onTap: () {
                                          setState(() {
                                            currentQuestion = e;
                                          });
                                        },
                                        child: Opacity(
                                          opacity: currentQuestion == null
                                              ? 1
                                              : (examModel!.examQuestions!.indexOf(
                                                                  currentQuestion!) -
                                                              examModel!
                                                                  .examQuestions!
                                                                  .indexOf(e))
                                                          .abs() >
                                                      2
                                                  ? 0.3
                                                  : 1.0,
                                          // Adjust the fading threshold as needed
                                          child: CircleAvatar(
                                            backgroundColor: currentQuestion ==
                                                    e
                                                ? ColorResources.textFiledBorder
                                                : Colors.transparent,
                                            radius: 15,
                                            child: Text(
                                              (examModel!.examQuestions!
                                                          .indexOf(e) +
                                                      1)
                                                  .toString(),
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
                          if (currentQuestion != null)
                            Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 11, horizontal: 11),
                                decoration: defaultDecoration,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${examModel!.examQuestions!.indexOf(currentQuestion!) + 1}. ',
                                      style: titleMedium.darkBG,
                                    ),
                                    const Gap(5),
                                    Expanded(
                                      child: Text(
                                        currentQuestion?.question ?? '',
                                        style: titleMedium.darkBG,
                                      ),
                                    )
                                  ],
                                )),
                          const Gap(12),


                          Builder(
                            builder: (context) {
                              if(currentQuestion?.examType == "objective") {
                                return Column(
                                  children: [
                                    if (currentQuestion!.options != null)
                                    ...currentQuestion!.options!.map(
                                      (e) => GestureDetector(
                                        onTap: currentQuestion!.isViewSolution ? null : () {
                                          setState(() {
                                            currentQuestion?.selectedAnswer =
                                                e; //chekc
                                          });
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 11, horizontal: 11),
                                          margin:
                                              const EdgeInsets.only(bottom: 16),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              color: getColorByAnswer(
                                                  e, currentQuestion!),
                                              boxShadow: const [
                                                BoxShadow(
                                                  blurRadius: 30,
                                                  offset: Offset(0, 10),
                                                  spreadRadius: 0,
                                                  color: Color(0xffF0F0F0),
                                                )
                                              ]),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              CircleAvatar(
                                                backgroundColor: e ==
                                                        currentQuestion
                                                            ?.answerType
                                                    ? Colors.white
                                                    : const Color(0xffEBEBEB),
                                                child: Text(
                                                  String.fromCharCode(
                                                    'A'.codeUnitAt(0) +
                                                        currentQuestion!
                                                            .options!
                                                            .indexOf(e),
                                                  ),
                                                  style: e ==
                                                          currentQuestion
                                                              ?.answerType
                                                      ? bodyMedium.primary
                                                      : bodyMedium.darkBG,
                                                ),
                                              ),
                                              const Gap(10),
                                              Expanded(
                                                child: Text(
                                                  e.optionName ?? "",
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                );
                              } else {
                                return TextFieldCustom(
                                  controller: TextEditingController(
                                      text: currentQuestion?.subjectiveAnswer),
                                  onChanged: (text) {
                                    currentQuestion?.subjectiveAnswer = text;
                                  },
                                );
                              }
                            },
                          ),

                          const Gap(40),
                          CustomOutlineButton(
                            currentQuestion?.answerType == null
                                ? 'Skip Question'
                                : 'View Solution',
                            onTap: (loader) {
                              if (currentQuestion?.answerType == null) {
                                //skip question
                                if (currentQuestion !=
                                    examModel!.examQuestions!.last) {
                                  skipToNext();
                                } else {
                                  SnackBarCustom.success(
                                      'No questions left to skip');
                                }
                              } else {
                                setState(() {
                                  currentQuestion?.isViewSolution = true;
                                });
                                _countdownTimer.pauseTimer();
                                Navigator.pushNamed(
                                  context,
                                  ExamSolutionScreen.path,
                                  arguments: currentQuestion!.id!,
                                ).then((value) {
                                  _countdownTimer.resumeTimer();
                                });
                              }
                            },
                          ),
                          const Gap(12),
                          CustomOutlineButton(
                            currentQuestion == examModel?.examQuestions?.last
                                ? 'Submit'
                                : 'Next',
                            onTap: (loader) {
                              nextButton();
                            },
                            textColor: Colors.white,
                            bgColor: ColorResources.secondary,
                          ),
                        ],
                      );
              default:
                return Container();
            }
          }),
    );
  }

  Color getColorByAnswer(Option e, ExamQuestion question) {
    return e == currentQuestion?.selectedAnswer
        ? ColorResources.primary
        : Colors.white;
  }

  skipToNext() {
    //assign selected answer if tapped
    examModel!.examQuestions![
        examModel!.examQuestions!.indexOf(currentQuestion!)] = currentQuestion!;
    //change to new
    currentQuestion = examModel!.examQuestions![
        examModel!.examQuestions!.indexOf(currentQuestion!) + 1];
    setState(() {});
  }

  nextButton() {
    print('current ans ${currentQuestion?.selectedAnswer?.optionName}');
    examModel!.examQuestions![
        examModel!.examQuestions!.indexOf(currentQuestion!)] = currentQuestion!;
    if (currentQuestion != examModel!.examQuestions!.last) {
      skipToNext();
    } else {
      //submit api
      submit();
    }
  }

  submit() async {
    examModel!.examId = widget.examId;
    examModel!.studentId = widget.studentId;
    examModel?.status = 'completed';
    examModel?.timeTaken = timeTaken!.toInt();
    examModel!.examQuestions
        ?.removeWhere((element) => element.selectedAnswer?.id == null);
    final ExamsResultModel? submitResult =
        await bloc.submitExam(examModel!, widget.examId);
    if (submitResult != null) {
      bloc.examMarks(widget.examId).then((result) => Navigator.popAndPushNamed(
          context, ExamMarkSheetScreen.path,
          arguments: result));
    }
  }
}
