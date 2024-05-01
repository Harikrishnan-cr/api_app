import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:samastha/gen/assets.gen.dart';
import 'package:samastha/modules/courses/screens/audio_class_item.dart';
import 'package:samastha/modules/student/bloc/exam_controller.dart';
import 'package:samastha/modules/student/models/mcq_question_paper.dart';
import 'package:samastha/modules/student/screens/tests_assignments/exam_solution_screen.dart';
import 'package:samastha/theme/color_resources.dart';
import 'package:samastha/theme/dimensions.dart';
import 'package:samastha/theme/t_style.dart';
import 'package:samastha/widgets/app_bars_custom.dart';
import 'package:samastha/widgets/custom_form_elements.dart';
import 'package:samastha/widgets/custom_snackbar.dart';
import 'package:samastha/widgets/dotted_border_custom.dart';

class KidsExamScreen extends StatefulWidget {
  const KidsExamScreen({super.key});
  static const String path = '/kids-exam-screen';

  @override
  State<KidsExamScreen> createState() => _KidsExamScreenState();
}

class _KidsExamScreenState extends State<KidsExamScreen> {
  ExamController bloc = ExamController();
  File? worksheetFile;

  static var item1 = {
    "question": "Who is the current President of the United States as of 2022?",
    "id": 1,
    "marks": 100,
    "images": [],
    "isActive": 1,
    "noOfOptions": 3,
    "examType": "objective",
    "answerType": "option", //"image" "audio" "option"
    "optionType": "option", //"image" "audio" "option"
    "examQuestionDisplayId": "EQ0001",
    "options": [
      {
        "id": 1,
        "optionName": "a",
        "optionImages": null,
        "fkExamQuestionId": 1,
        "isCorrect": 1,
        "deletedAt": null,
        "createdAt": "2024-01-01T11:22:23.000000Z",
        "updatedAt": "2024-01-01T11:22:32.000000Z",
        "signedPhotoUrl": null
      },
      {
        "id": 2,
        "optionName": "b",
        "optionImages": null,
        "fkExamQuestionId": 1,
        "isCorrect": 0,
        "deletedAt": null,
        "createdAt": "2024-01-01T11:22:23.000000Z",
        "updatedAt": "2024-01-01T11:22:32.000000Z",
        "signedPhotoUrl": null
      },
      {
        "id": 3,
        "optionName": "c",
        "optionImages": null,
        "fkExamQuestionId": 1,
        "isCorrect": 0,
        "deletedAt": null,
        "createdAt": "2024-01-01T11:22:23.000000Z",
        "updatedAt": "2024-01-01T11:22:32.000000Z",
        "signedPhotoUrl": null
      }
    ],
    "media": []
  };
  static var item2 = {
    "question": "Who is the current President of the United States as of 2022?",
    "id": 1,
    "marks": 100,
    "images": [],
    "isActive": 1,
    "noOfOptions": 3,
    "examType": "subjective",
    "answerType": "image", //"image" "audio" "option"
    "optionType": "image", //"image" "audio" "option"
    "examQuestionDisplayId": "EQ0001",
    "options": [
      {
        "id": 1,
        "optionName": "a",
        "optionImages": null,
        "fkExamQuestionId": 1,
        "isCorrect": 1,
        "deletedAt": null,
        "createdAt": "2024-01-01T11:22:23.000000Z",
        "updatedAt": "2024-01-01T11:22:32.000000Z",
        "signedPhotoUrl": null
      },
      {
        "id": 2,
        "optionName": "b",
        "optionImages": null,
        "fkExamQuestionId": 1,
        "isCorrect": 0,
        "deletedAt": null,
        "createdAt": "2024-01-01T11:22:23.000000Z",
        "updatedAt": "2024-01-01T11:22:32.000000Z",
        "signedPhotoUrl": null
      },
      {
        "id": 3,
        "optionName": "c",
        "optionImages": null,
        "fkExamQuestionId": 1,
        "isCorrect": 0,
        "deletedAt": null,
        "createdAt": "2024-01-01T11:22:23.000000Z",
        "updatedAt": "2024-01-01T11:22:32.000000Z",
        "signedPhotoUrl": null
      }
    ],
    "media": []
  };
  static var item3 = {
    "question": "Who is the current President of the United States as of 2022?",
    "id": 1,
    "marks": 100,
    "images": [],
    "isActive": 1,
    "noOfOptions": 3,
    "examType": "subjective",
    "answerType": "audio", //"image" "audio" "option"
    "optionType": "audio", //"image" "audio" "option"
    "examQuestionDisplayId": "EQ0001",
    "options": [
      {
        "id": 1,
        "optionName": "a",
        "optionImages": null,
        "fkExamQuestionId": 1,
        "isCorrect": 1,
        "deletedAt": null,
        "createdAt": "2024-01-01T11:22:23.000000Z",
        "updatedAt": "2024-01-01T11:22:32.000000Z",
        "signedPhotoUrl": null
      },
      {
        "id": 2,
        "optionName": "b",
        "optionImages": null,
        "fkExamQuestionId": 1,
        "isCorrect": 0,
        "deletedAt": null,
        "createdAt": "2024-01-01T11:22:23.000000Z",
        "updatedAt": "2024-01-01T11:22:32.000000Z",
        "signedPhotoUrl": null
      },
      {
        "id": 3,
        "optionName": "c",
        "optionImages": null,
        "fkExamQuestionId": 1,
        "isCorrect": 0,
        "deletedAt": null,
        "createdAt": "2024-01-01T11:22:23.000000Z",
        "updatedAt": "2024-01-01T11:22:32.000000Z",
        "signedPhotoUrl": null
      }
    ],
    "media": []
  };
  static var item4 = {
    "question": "Who is the current President of the United States as of 2022?",
    "id": 1,
    "marks": 100,
    "images": [],
    "isActive": 1,
    "noOfOptions": 3,
    "examType": "subjective",
    "answerType": "file", //"image" "audio" "option" "file"
    "optionType": "audio", //"image" "audio" "option"
    "examQuestionDisplayId": "EQ0001",
    "options": [
      {
        "id": 1,
        "optionName": "a",
        "optionImages": null,
        "fkExamQuestionId": 1,
        "isCorrect": 1,
        "deletedAt": null,
        "createdAt": "2024-01-01T11:22:23.000000Z",
        "updatedAt": "2024-01-01T11:22:32.000000Z",
        "signedPhotoUrl": null
      },
      {
        "id": 2,
        "optionName": "b",
        "optionImages": null,
        "fkExamQuestionId": 1,
        "isCorrect": 0,
        "deletedAt": null,
        "createdAt": "2024-01-01T11:22:23.000000Z",
        "updatedAt": "2024-01-01T11:22:32.000000Z",
        "signedPhotoUrl": null
      },
      {
        "id": 3,
        "optionName": "c",
        "optionImages": null,
        "fkExamQuestionId": 1,
        "isCorrect": 0,
        "deletedAt": null,
        "createdAt": "2024-01-01T11:22:23.000000Z",
        "updatedAt": "2024-01-01T11:22:32.000000Z",
        "signedPhotoUrl": null
      }
    ],
    "media": []
  };

  List<ExamQuestion>? examQuestions = [
    ExamQuestion.fromJson(item1),
    ExamQuestion.fromJson(item2),
    ExamQuestion.fromJson(item3),
    ExamQuestion.fromJson(item4),
    ExamQuestion.fromJson(item1),
  ];
  ExamQuestion? currentQuestion;

  Color getColorByAnswer(Option e, ExamQuestion question) {
    switch (question.optionType) {
      case "image":
        return e == currentQuestion?.selectedAnswer
            ? const Color(0xff6EDC72)
            : const Color(0xffD3EBF2);
      case "audio":
        return e == currentQuestion?.selectedAnswer
            ? const Color(0xff6EDC72)
            : const Color(0xffE6F8FE);
      default:
        return e == currentQuestion?.selectedAnswer
            ? const Color(0xff6EDC72)
            : const Color(0xffE1DEF2);
    }
  }

  getColorByIndex(int index) {
    switch (index) {
      case 0:
        return const Color(0xffFFAB8E);
      case 1:
        return const Color(0xff92E5FF);
      case 2:
        return const Color(0xff82E7CF);
      case 3:
        return const Color(0xffBE9EF3);
      default:
    }
  }

  Widget getWidgetByAnswerType(ExamQuestion? question) {
    switch (question?.optionType) {
      case "image":
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 17.0, horizontal: 5.0),
          child: Assets.image.kids.rectangle649questionImage
              .image(height: 87, width: 87),
        );
      case "audio":
        return const Padding(
          padding: EdgeInsets.symmetric(vertical: 10.0),
          child: AudioClassItem(
            name: '',
            id: 0,
            url: 'url',
            isPurchased: true,
            isDemo: true,
            isKids: true,
            buttonColor: Color(0xff0BAA56),
          ),
        );
      default:
        return Container();
    }
  }

  Widget getAnswerWidget() {
    switch (currentQuestion?.answerType) {
      case "file":
        return GestureDetector(
          onTap: () async {
            worksheetFile = await bloc.pickFile();
            setState(() {});
          },
          child: DottedBorderCustom(
            dashPattern: const [5, 5],
            color: ColorResources.primary,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      worksheetFile == null
                          ? Assets.svgs.cloudComputing
                              .svg(color: ColorResources.secondary, height: 40)
                          : Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Assets.svgs.boxChecked.svg(height: 26),
                            ),
                      Text(
                        worksheetFile == null
                            ? 'Upload completed answers'
                            : 'Selected',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                          color: ColorResources.darkBG.withOpacity(.5),
                        ),
                      ),
                      Text(
                        'Pdf or jpg',
                        style: labelSmall.s10.darkBG,
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      case "audio":
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              side: const BorderSide(width: 1, color: Color(0xFF1696BB)),
              borderRadius: BorderRadius.circular(83),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Text(
                  'Record voice answer ',
                  style: GoogleFonts.openSans(
                    color: const Color(0xFF1696BB),
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    height: 0,
                  ),
                ),
              ),
              Assets.image.kids.recordMic.image(height: 48, width: 48),
            ],
          ),
        );
      default:
        return TextFieldCustom(
          controller:
              TextEditingController(text: currentQuestion?.subjectiveAnswer),
          hintText: 'Answer',
          onChanged: (text) {
            currentQuestion?.subjectiveAnswer = text;
          },
        );
    }
  }

  @override
  void initState() {
    currentQuestion = examQuestions?[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(title: 'Monthly Exam', leadingWidget: Container()),
      body: ListView(
        padding: pagePadding.copyWith(bottom: 20),
        children: [
          const Gap(12),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 11),
            decoration: defaultDecoration.copyWith(
                color: const Color(0xffD7EBF1),
                borderRadius: BorderRadius.circular(24)),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.only(left: 7.0),
                child: Row(
                  children: examQuestions!
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
                                : (examQuestions!.indexOf(currentQuestion!) -
                                                examQuestions!.indexOf(e))
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
                                (examQuestions!.indexOf(e) + 1).toString(),
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
          ),
          const Gap(12),
          if (currentQuestion != null)
            Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 21, horizontal: 16),
                decoration: defaultDecoration.copyWith(
                  color: const Color(0xffD0EBE5),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${examQuestions!.indexOf(currentQuestion!) + 1}. ',
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
                    ),
                    const Gap(21),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: SizedBox(
                            height: 77,
                            width: 77,
                            child: Assets.image.kids.rectangle649questionImage
                                .image(),
                          ),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: SizedBox(
                            height: 77,
                            width: 77,
                            child: Assets.image.kids.rectangle649questionImage
                                .image(),
                          ),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: SizedBox(
                            height: 77,
                            width: 77,
                            child: Assets.image.kids.rectangle649questionImage
                                .image(),
                          ),
                        ),
                      ],
                    )
                  ],
                )),
          const Gap(12),
          Builder(
            builder: (context) {
              if (currentQuestion?.examType == "objective") {
                return Column(
                  children: [
                    if (currentQuestion!.options != null)
                      ...currentQuestion!.options!.map(
                        (e) => GestureDetector(
                          onTap: currentQuestion!.isViewSolution
                              ? null
                              : () {
                                  setState(() {
                                    currentQuestion?.selectedAnswer = e; //check
                                  });
                                },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 11, horizontal: 11),
                            margin: const EdgeInsets.only(bottom: 16),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: getColorByAnswer(e, currentQuestion!),
                                boxShadow: const [
                                  BoxShadow(
                                    blurRadius: 30,
                                    offset: Offset(0, 10),
                                    spreadRadius: 0,
                                    color: Color(0xffF0F0F0),
                                  )
                                ]),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: getColorByIndex(
                                          currentQuestion!.options!.indexOf(e)),
                                      child: Text(
                                        String.fromCharCode(
                                          'A'.codeUnitAt(0) +
                                              currentQuestion!.options!
                                                  .indexOf(e),
                                        ),
                                        style: e == currentQuestion?.answerType
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
                                getWidgetByAnswerType(currentQuestion)
                              ],
                            ),
                          ),
                        ),
                      ),
                  ],
                );
              } else if (currentQuestion?.examType == "subjective") {
                return Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: getAnswerWidget(),
                );
              } else {
                return const Text('Examtype null');
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
                if (currentQuestion != examQuestions!.last) {
                  // skipToNext();
                } else {
                  SnackBarCustom.success('No questions left to skip');
                }
              } else {
                setState(() {
                  currentQuestion?.isViewSolution = true;
                });
                // _countdownTimer.pauseTimer();
                Navigator.pushNamed(
                  context,
                  ExamSolutionScreen.path,
                  arguments: currentQuestion!.id!,
                ).then((value) {
                  // _countdownTimer.resumeTimer();
                });
              }
            },
          ),
          const Gap(12),
          CustomOutlineButton(
            currentQuestion == examQuestions?.last ? 'Submit' : 'Next',
            onTap: (loader) {
              // nextButton();
            },
            textColor: Colors.white,
            bgColor: ColorResources.secondary,
          ),
        ],
      ),
    );
  }
}
