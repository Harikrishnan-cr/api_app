import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:samastha/core/app_constants.dart';
import 'package:samastha/gen/assets.gen.dart';
import 'package:samastha/helper/date_converter.dart';
import 'package:samastha/modules/student/bloc/exam_controller.dart';
import 'package:samastha/modules/student/models/student_exams_model.dart';
import 'package:samastha/modules/student/screens/tests_assignments/exam_marksheet.dart';
import 'package:samastha/modules/student/screens/tests_assignments/exam_welcome_screen.dart';
import 'package:samastha/theme/color_resources.dart';
import 'package:samastha/theme/dimensions.dart';
import 'package:samastha/theme/t_style.dart';
import 'package:samastha/utils/error_reload.dart';
import 'package:samastha/utils/signed_image_viewer.dart';
import 'package:samastha/widgets/app_bars_custom.dart';
import 'package:samastha/widgets/custom_snackbar.dart';
import 'package:samastha/widgets/default_loading_widget.dart';

class ExamsListScreen extends StatefulWidget {
  const ExamsListScreen({super.key});

  static const String path = 'exams-list';

  @override
  State<ExamsListScreen> createState() => _ExamsListScreenState();
}

class _ExamsListScreenState extends State<ExamsListScreen> {
  _PageMode _pageMode = _PageMode.newExams;

  ExamController bloc = ExamController();

  late Future newExamstListFuture;
  late Future completedExamFuture;

  _initData({required _PageMode? mode}) {
    switch (mode) {
      case _PageMode.completedExams:
        completedExamFuture =
            bloc.fetchExams(AppConstants.studentID, type: 'completed');
        return;
      case _PageMode.newExams:
        newExamstListFuture = bloc.fetchExams(AppConstants.studentID);
        return;
      default:
        newExamstListFuture = bloc.fetchExams(AppConstants.studentID);
        completedExamFuture =
            bloc.fetchExams(AppConstants.studentID, type: 'completed');
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
      appBar: const SimpleAppBar(title: 'Exams'),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            _buildModeSwitcher(),
            FutureBuilder(
                future: Future.wait([newExamstListFuture, completedExamFuture]),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return errorReload(snapshot.error.toString(),
                        onTap: () => _initData(mode: null));
                  }

                  switch (snapshot.connectionState) {
                    case ConnectionState.done:
                      List<ExamsModel> newExamstList = snapshot.data?[0] ?? [];
                      List<ExamsModel> completedExamsList =
                          snapshot.data?[1] ?? [];

                      print('examstList ${newExamstList.length}');
                      print('completedExamsList ${completedExamsList.length}');

                      return bodyBuilder(newExamstList, completedExamsList);
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
      List<ExamsModel> newExamstList, List<ExamsModel> completedExamsList) {
    bool isNewExams = _pageMode == _PageMode.newExams;
    final listWidget = ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: pagePadding,
        itemCount:
            isNewExams ? newExamstList.length : completedExamsList.length,
        itemBuilder: (context, index) {
          return isNewExams
              ? item(true, newExamModel: newExamstList[index])
              : item(false, completedExamModel: completedExamsList[index]);
        });

    return isNewExams
        ? newExamstList.isEmpty
            ? const Center(
                child: Padding(
                padding: EdgeInsets.only(top: 300.0),
                child: Text('No new exams'),
              ))
            : listWidget
        : completedExamsList.isEmpty
            ? const Center(
                child: Padding(
                padding: EdgeInsets.only(top: 300.0),
                child: Text('No completed exams'),
              ))
            : listWidget;
  }

  Widget item(bool isNewExams,
      {ExamsModel? newExamModel, ExamsModel? completedExamModel}) {
    print('newExamModel?.image ${newExamModel?.image}');
    return GestureDetector(
      onTap: () {
        if (_pageMode == _PageMode.newExams) {
          if (AppConstants.loggedUser?.role == 'parent') {
            SnackBarCustom.success('Try login as student to attend the exam');
            return;
          }
          Navigator.pushNamed(context, ExamWelcomeScreen.path, arguments: {
            'examId': newExamModel?.id ?? 0,
            'examName': newExamModel?.name ?? ''
          });
        } else {
          print('widget.examId 2 ${completedExamModel?.id}');
          bloc.examMarks(completedExamModel?.id).then((value) =>
              Navigator.pushNamed(context, ExamMarkSheetScreen.path,
                  arguments: value));
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
              child: (completedExamModel?.photoUrl != null ||
                      newExamModel?.photoUrl != null)
                  ? ImageViewer(
                      path: isNewExams
                          ? newExamModel?.photoUrl
                          : completedExamModel?.photoUrl,
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
                    (isNewExams
                            ? newExamModel?.name
                            : completedExamModel?.name) ??
                        '',
                    style: titleSmall.darkBG,
                  ),
                  Text(
                    (isNewExams
                            ? newExamModel?.description
                            : completedExamModel?.description) ??
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
                        (isNewExams
                                ? newExamModel?.status
                                : completedExamModel?.status) ??
                            '',
                        style: labelMedium.darkBG,
                      ),
                      const Gap(10),
                      Text(
                        DateConverter.dateWithMonth((isNewExams
                                ? newExamModel?.completedDate
                                : completedExamModel?.completedDate) ??
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
                _pageMode = _PageMode.newExams;
                _initData(mode: _PageMode.newExams);
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
                color: _pageMode == _PageMode.newExams
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
                  style: _pageMode == _PageMode.newExams
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
                _pageMode = _PageMode.completedExams;
                _initData(mode: _PageMode.completedExams);
              });
            },
            child: Container(
              height: 44,
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color: _pageMode == _PageMode.completedExams
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
                      style: _pageMode == _PageMode.completedExams
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

enum _PageMode { newExams, completedExams }
