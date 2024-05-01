import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:samastha/core/app_constants.dart';
import 'package:samastha/gen/assets.gen.dart';
import 'package:samastha/helper/date_converter.dart';
import 'package:samastha/modules/student/bloc/quiz_controller.dart';
import 'package:samastha/modules/student/models/quizz_model.dart';
import 'package:samastha/modules/student/screens/tests_assignments/exam_marksheet.dart';
import 'package:samastha/modules/student/screens/tests_assignments/quizes_welcome_screen.dart';
import 'package:samastha/theme/color_resources.dart';
import 'package:samastha/theme/dimensions.dart';
import 'package:samastha/theme/t_style.dart';
import 'package:samastha/utils/error_reload.dart';
import 'package:samastha/utils/signed_image_viewer.dart';
import 'package:samastha/widgets/app_bars_custom.dart';
import 'package:samastha/widgets/custom_snackbar.dart';
import 'package:samastha/widgets/default_loading_widget.dart';

class QuizzesListScreen extends StatefulWidget {
  const QuizzesListScreen({super.key, required this.studentId});
  static const String path = 'quizzes-list';
  final int studentId;

  @override
  State<QuizzesListScreen> createState() => _QuizzesListScreenState();
}

class _QuizzesListScreenState extends State<QuizzesListScreen> {
  _PageMode _pageMode = _PageMode.newQuizz;

  QuizzController bloc = QuizzController();

  late Future newQuizFuture;
  late Future completedQuizFuture;

  _initData({required _PageMode? mode}) {
    switch (mode) {
      case _PageMode.completedQuizz:
        completedQuizFuture =
            bloc.fetchQuizzes(widget.studentId, type: 'completed');
        return;
      case _PageMode.newQuizz:
        newQuizFuture = bloc.fetchQuizzes(widget.studentId);
        return;
      default:
        newQuizFuture = bloc.fetchQuizzes(widget.studentId);
        completedQuizFuture =
            bloc.fetchQuizzes(widget.studentId, type: 'completed');
        return;
    }
  }

  @override
  void initState() {
    _initData(mode: null);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SimpleAppBar(title: 'Quizzes'),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            _buildModeSwitcher(),
            FutureBuilder(
                future: Future.wait([newQuizFuture, completedQuizFuture]),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return errorReload(snapshot.error.toString(),
                        onTap: () => _initData(mode: null));
                  }

                  switch (snapshot.connectionState) {
                    case ConnectionState.done:
                      List<QuizzModel> newQuizztList = snapshot.data?[0] ?? [];
                      List<QuizzModel> completedQuizzList =
                          snapshot.data?[1] ?? [];

                      print('examstList ${newQuizztList.length}');
                      print('completedExamsList ${completedQuizzList.length}');

                      return bodyBuilder(newQuizztList, completedQuizzList);
                    case ConnectionState.waiting:
                      return const Center(child: LoadingWidget());
                    default:
                      return Container();
                  }
                }),
          ],
        ),
      )),
    );
  }

  Widget bodyBuilder(
      List<QuizzModel> newQuizztList, List<QuizzModel> completedQuizzList) {
    bool isNewQuiz = _pageMode == _PageMode.newQuizz;
    final listWidget = ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: pagePadding,
        itemCount: isNewQuiz ? newQuizztList.length : completedQuizzList.length,
        itemBuilder: (context, index) {
          return isNewQuiz
              ? item(true, newQuizModel: newQuizztList[index])
              : item(false, completedQuizModel: completedQuizzList[index]);
        });

    return isNewQuiz
        ? newQuizztList.isEmpty
            ? const Center(
                child: Padding(
                padding: EdgeInsets.only(top: 300.0),
                child: Text('No new Quizz'),
              ))
            : listWidget
        : completedQuizzList.isEmpty
            ? const Center(
                child: Padding(
                padding: EdgeInsets.only(top: 300.0),
                child: Text('No completed Quizz'),
              ))
            : listWidget;
  }

  Widget item(bool isNewQuizz,
      {QuizzModel? newQuizModel, QuizzModel? completedQuizModel}) {
    return GestureDetector(
      onTap: () {
        if (_pageMode == _PageMode.newQuizz) {
          if (AppConstants.loggedUser?.role == 'parent') {
            SnackBarCustom.success('Try login as student to attend the exam');
            return;
          }
          Navigator.pushNamed(context, QuizWelcomeScreen.path, arguments: {
            'quizzName': newQuizModel?.name ?? '',
            'quizzId': newQuizModel?.id ?? 0,
            'studentId': widget.studentId,
          });
        } else {
          bloc.quizMarks(completedQuizModel?.id).then((markModel) =>
              Navigator.pushNamed(context, ExamMarkSheetScreen.path,
                  arguments: markModel));
        }
      },
      child: Container(
        width: double.infinity,
        decoration: defaultDecoration,
        margin: const EdgeInsets.only(bottom: 20),
        padding: const EdgeInsets.only(right: 16),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: (completedQuizModel?.photoUrl != null ||
                      newQuizModel?.photoUrl != null)
                  ? ImageViewer(
                      path: isNewQuizz
                          ? newQuizModel?.photoUrl
                          : completedQuizModel?.photoUrl,
                      height: 101,
                      width: 101,
                    )
                  : Assets.image.videoBg.image(
                      height: 101,
                      fit: BoxFit.fitHeight,
                      width: 101,
                    ),
            ),
            const Gap(12),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    (isNewQuizz
                            ? newQuizModel?.name
                            : completedQuizModel?.name) ??
                        '',
                    style: titleSmall.darkBG,
                  ),
                  Text(
                    (isNewQuizz
                            ? newQuizModel?.description
                            : completedQuizModel?.description) ??
                        '',
                    style: bodyMedium.grey1,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Gap(10),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        (isNewQuizz
                                ? newQuizModel?.status
                                : completedQuizModel?.status) ??
                            '',
                        style: labelMedium.darkBG,
                      ),
                      const Gap(10),
                      Text(
                        DateConverter.dateWithMonth((isNewQuizz
                                ? newQuizModel?.completedDate
                                : completedQuizModel?.completedDate) ??
                            DateTime.now()),
                        style: labelMedium.primary,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModeSwitcher() {
    const grey = 0xffEBEBEB;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              setState(() {
                _pageMode = _PageMode.newQuizz;
                _initData(mode: _PageMode.newQuizz);
              });
            },
            child: Container(
              // width: double.infinity,
              height: 44,
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color: _pageMode == _PageMode.newQuizz
                    ? ColorResources.WHITE
                    : const Color(grey),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                  topRight: Radius.circular(0), // Adjusted
                  bottomRight: Radius.circular(0), // Adjusted
                ),
              ),
              child: Center(
                child: Text(
                  'New',
                  textAlign: TextAlign.center,
                  style: _pageMode == _PageMode.newQuizz
                      ? titleSmall.darkBG
                      : titleSmall.copyWith(
                          color: ColorResources.darkBG.withOpacity(.5),
                        ),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () {
              setState(() {
                _pageMode = _PageMode.completedQuizz;
                _initData(mode: _PageMode.completedQuizz);
              });
            },
            child: Container(
              height: 44,
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color: _pageMode == _PageMode.completedQuizz
                    ? ColorResources.WHITE
                    : const Color(grey),
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                  topLeft: Radius.circular(0), // Adjusted
                  bottomLeft: Radius.circular(0), // Adjusted
                ),
              ),
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  Center(
                    child: Text(
                      'Completed',
                      textAlign: TextAlign.center,
                      style: _pageMode == _PageMode.completedQuizz
                          ? titleSmall.darkBG
                          : titleSmall.copyWith(
                              color: ColorResources.darkBG.withOpacity(.5)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

enum _PageMode { newQuizz, completedQuizz }
