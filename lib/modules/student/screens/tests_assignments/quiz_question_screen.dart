import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:samastha/helper/date_converter.dart';
import 'package:samastha/modules/student/bloc/quiz_controller.dart';
import 'package:samastha/modules/student/models/quizz_questions_model.dart';
import 'package:samastha/modules/student/screens/tests_assignments/exam_marksheet.dart';
import 'package:samastha/modules/student/screens/tests_assignments/quiz_solutions_screen.dart';
import 'package:samastha/theme/color_resources.dart';
import 'package:samastha/theme/dimensions.dart';
import 'package:samastha/theme/t_style.dart';
import 'package:samastha/utils/error_reload.dart';
import 'package:samastha/widgets/app_bars_custom.dart';
import 'package:samastha/widgets/custom_form_elements.dart';
import 'package:samastha/widgets/custom_snackbar.dart';
import 'package:samastha/widgets/default_loading_widget.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';

class QuizQuestionScreen extends StatefulWidget {
  const QuizQuestionScreen(
      {super.key,
      required this.quizId,
      required this.studentId,
      required this.quizName});
  static const String path = '/quiz-question';
  final int quizId;
  final int studentId;
  final String quizName;
  @override
  State<QuizQuestionScreen> createState() => _QuizQuestionScreenState();
}

class _QuizQuestionScreenState extends State<QuizQuestionScreen> {
  QuizzQuestionsData? quizModel;
  QuizQuestionModel? currentQuestion;
  late Future quizQuestionsFuture;
  double? timeTaken;
  QuizzController bloc = QuizzController();
  CountdownController timeController = CountdownController();

  @override
  void initState() {
    quizQuestionsFuture = bloc.fetchQuizzQuestions(widget.quizId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(title: widget.quizName),
      body: FutureBuilder(
        future: quizQuestionsFuture,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return errorReload(snapshot.error.toString(), onTap: () {
              setState(() {
                quizQuestionsFuture = bloc.fetchQuizzQuestions(widget.quizId);
              });
            });
          }

          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const LoadingWidget();

            case ConnectionState.done:
            case ConnectionState.active:
              quizModel ??= snapshot.data;
              currentQuestion ??= quizModel?.quizQuestions!.first;

              return quizModel == null
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
                              Countdown(
                                // controller: timeController,
                                seconds: Duration(
                                        minutes: quizModel!
                                                .quizPool!.durationInMin ??
                                            10)
                                    .inSeconds,
                                build: (BuildContext context, double time) {
                                  timeTaken = (Duration(
                                              minutes: quizModel!
                                                  .quizPool!.durationInMin!)
                                          .inSeconds -
                                      time);

                                  return Text(
                                    '${formatHHMMSS(time.toInt())} Sec',
                                    style: titleMedium.red,
                                  );
                                },
                                interval: const Duration(seconds: 1),
                                onFinished: () {
                                  //submit result
                                  submit();
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
                              children: quizModel!.quizQuestions!
                                  .map(
                                    (e) => InkWell(
                                      onTap: () {
                                        setState(() {
                                          print('e ${e.id}');
                                          currentQuestion = e;
                                        });
                                      },
                                      child: Opacity(
                                        opacity: currentQuestion == null
                                            ? 1
                                            : (quizModel!.quizQuestions!.indexOf(
                                                                currentQuestion!) -
                                                            quizModel!
                                                                .quizQuestions!
                                                                .indexOf(e))
                                                        .abs() >
                                                    2
                                                ? 0.3
                                                : 1.0,
                                        // Adjust the fading threshold as needed
                                        child: CircleAvatar(
                                          backgroundColor: currentQuestion == e
                                              ? ColorResources.textFiledBorder
                                              : Colors.transparent,
                                          radius: 15,
                                          child: Text(
                                            (quizModel!.quizQuestions!
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
                                    '${quizModel!.quizQuestions!.indexOf(currentQuestion!) + 1}. ',
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
                        if (currentQuestion!.options != null)
                          ...currentQuestion!.options!
                              .map(
                                (e) => GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      currentQuestion?.selectedAnswer =
                                          e; //chekc
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 11, horizontal: 11),
                                    margin: const EdgeInsets.only(bottom: 16),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
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
                                          backgroundColor:
                                              e == currentQuestion?.answerType
                                                  ? Colors.white
                                                  : const Color(0xffEBEBEB),
                                          child: Text(
                                            String.fromCharCode(
                                              'A'.codeUnitAt(0) +
                                                  currentQuestion!.options!
                                                      .indexOf(e),
                                            ),
                                            style:
                                                e == currentQuestion?.answerType
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
                              ,
                        const Gap(40),
                        CustomOutlineButton(
                          currentQuestion?.answerType == null
                              ? 'Skip Question'
                              : 'View Solution',
                          onTap: (loader) {
                            if (currentQuestion?.answerType == null) {
                              //skip question
                              if (currentQuestion !=
                                  quizModel!.quizQuestions!.last) {
                                skipToNext();
                              } else {
                                SnackBarCustom.success(
                                    'No questions left to skip');
                              }
                            } else {
                              bloc
                                  .fetchQuizzSolutions(currentQuestion!.id!)
                                  .then((solutions) {
                                return Navigator.pushNamed(
                                  context,
                                  QuizSolutionsScreen.path,
                                  arguments: solutions,
                                );
                              });
                            }
                          },
                        ),
                        const Gap(12),
                        CustomOutlineButton(
                          currentQuestion == quizModel?.quizQuestions?.last
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
        },
      ),
    );
  }

  Color getColorByAnswer(Option e, QuizQuestionModel question) {
    return e == currentQuestion?.selectedAnswer
        ? ColorResources.primary
        : Colors.white;
  }

  skipToNext() {
    //assign selected answer if tapped
    quizModel!.quizQuestions![
        quizModel!.quizQuestions!.indexOf(currentQuestion!)] = currentQuestion!;
    print('next pressed1 ${currentQuestion?.id}');

    //change to new
    currentQuestion = quizModel!.quizQuestions![
        quizModel!.quizQuestions!.indexOf(currentQuestion!) + 1];
    print('next pressed2');

    setState(() {});
    print('next pressed3 ${currentQuestion?.id}');

  }

  nextButton() {
    quizModel!.quizQuestions![
        quizModel!.quizQuestions!.indexOf(currentQuestion!)] = currentQuestion!;
    if (currentQuestion != quizModel!.quizQuestions!.last) {
      skipToNext();
    } else {
      //submit api
      submit();
    }
  }

  submit() async {
    quizModel!.examId = widget.quizId;
    quizModel!.studentId = widget.studentId;
    quizModel?.status = 'completed';
    quizModel?.timeTaken = timeTaken!.toInt();
    final QuizzResultJsonModel? result =
        await bloc.submitQuiz(quizModel!, widget.quizId);
    if (result != null) {
      print('exam result : $result');
      bloc.quizMarks(quizModel?.examId).then((value) => 
      Navigator.popAndPushNamed(context, ExamMarkSheetScreen.path, arguments: value));
    }
  }
}
