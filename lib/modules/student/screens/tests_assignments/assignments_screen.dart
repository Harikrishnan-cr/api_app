import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:gap/gap.dart';
import 'package:samastha/core/app_constants.dart';
import 'package:samastha/gen/assets.gen.dart';
import 'package:samastha/helper/date_converter.dart';
import 'package:samastha/modules/student/bloc/assignment_controller.dart';
import 'package:samastha/modules/student/models/assignment_model.dart';
import 'package:samastha/modules/student/screens/tests_assignments/assignment_details_screen.dart';
import 'package:samastha/modules/student/screens/tests_assignments/assignmnet_marksheet_screen.dart';
import 'package:samastha/theme/color_resources.dart';
import 'package:samastha/theme/dimensions.dart';
import 'package:samastha/theme/t_style.dart';
import 'package:samastha/utils/error_reload.dart';
import 'package:samastha/utils/signed_image_viewer.dart';
import 'package:samastha/widgets/app_bars_custom.dart';
import 'package:samastha/widgets/default_loading_widget.dart';

class AssignmentsScreen extends StatefulWidget {
  const AssignmentsScreen({super.key, this.isKids});
  static const String path = 'assignments-list';

  final bool? isKids;

  @override
  State<AssignmentsScreen> createState() => _AssignmentsScreenState();
}

class _AssignmentsScreenState extends State<AssignmentsScreen> {
  _PageMode? _pageMode;
  AssignmentController bloc = AssignmentController();

  late Future assignedAssignmentsFuture;
  late Future completedAssignmentsFuture;

  _initData() {
    if (_pageMode == _PageMode.assigned) {
      assignedAssignmentsFuture = bloc.fetchAssignments(AppConstants.studentID);
    } else if (_pageMode == _PageMode.completed) {
      completedAssignmentsFuture =
          bloc.fetchAssignments(AppConstants.studentID, type: 'completed');
    } else {
      completedAssignmentsFuture =
          bloc.fetchAssignments(AppConstants.studentID, type: 'completed');
      assignedAssignmentsFuture = bloc.fetchAssignments(AppConstants.studentID);
    }
    // completedAssignmentsFuture =
    //     bloc.fetchAssignments(AppConstants.studentID, type: 'completed');
    // assignedAssignmentsFuture = bloc.fetchAssignments(AppConstants.studentID);

    // var abc = await bloc.fetchAssignments(AppConstants.studentID, type: 'completed');
    // print('abc lengt $abc');
    // print('list length ${await completedAssignmentsFuture}');
    // print('list length ${await completedAssignmentsFuture}');
  }

  @override
  void initState() {
    _initData();
    _pageMode = _PageMode.assigned;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SimpleAppBar(title: 'Assignments'),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            _buildModeSwitcher(),
            FutureBuilder(
                future: Future.wait(
                    [assignedAssignmentsFuture, completedAssignmentsFuture]),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return errorReload(snapshot.error.toString(),
                        onTap: () => _initData());
                  }

                  switch (snapshot.connectionState) {
                    case ConnectionState.done:
                      List<AssignmentModel> assignmentList =
                          snapshot.data?[0] ?? [];
                      List<AssignmentModel> completedAssignmentList =
                          snapshot.data?[1] ?? [];

                      log('lengt assignmentList ${assignmentList.length}');
                      log('lengt completedAssignmentList ${completedAssignmentList.length}');

                      return bodyBuilder(
                          assignmentList, completedAssignmentList);
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

  Widget bodyBuilder(List<AssignmentModel> assignmentList,
      List<AssignmentModel> completedAssignmentList) {
    bool isAssigned = _pageMode == _PageMode.assigned;

    var listWidget = SingleChildScrollView(
      padding: pagePadding,
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(vertical: 5),
        itemCount:
            isAssigned ? assignmentList.length : completedAssignmentList.length,
        itemBuilder: (context, index) {
          return isAssigned
              ? item(true, assignmentModel: assignmentList[index])
              : item(false,
                  completedAssignmentModel: completedAssignmentList[index]);
        },
      ),
    );
    // return listWidget;
    return isAssigned
        ? assignmentList.isEmpty
            ? const Center(
                child: Padding(
                padding: EdgeInsets.only(top: 300.0),
                child: Text('No assignments'),
              ))
            : listWidget
        : completedAssignmentList.isEmpty
            ? const Center(
                child: Padding(
                padding: EdgeInsets.only(top: 300.0),
                child: Text('No completed assignments'),
              ))
            : listWidget;
  }

  Widget item(bool isAssigned,
      {AssignmentModel? assignmentModel,
      AssignmentModel? completedAssignmentModel}) {
    return GestureDetector(
      onTap: () {
        if (isAssigned) {
          // var id = ModalRoute.of(context)!.settings.arguments! as int;
          AppConstants.tempSelected =
              assignmentModel?.id; //handle this to argument pass
          Navigator.pushNamed(context, AssignmentDetailsScreen.path);
        } else {
          log('assingment mark is ${completedAssignmentModel?.submission?.mark}');
          Navigator.pushNamed(context, AssignmentMarkSheetScreen.path,
              arguments: completedAssignmentModel);
        }
      },
      child: Container(
        width: double.infinity,
        decoration: defaultDecoration,
        margin: const EdgeInsets.only(bottom: 20),
        padding: const EdgeInsets.only(right: 16, top: 10, bottom: 10, left: 8),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: (completedAssignmentModel?.photoUrl != null ||
                      assignmentModel?.photoUrl != null)
                  ? ImageViewer(
                      path: isAssigned
                          ? assignmentModel?.photoUrl
                          : completedAssignmentModel?.photoUrl,
                      height: 72,
                      width: 72,
                    )
                  : Assets.image.videoBg.image(
                      height: 72,
                      fit: BoxFit.fitHeight,
                      width: 72,
                    ),
            ),
            const Gap(12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    (isAssigned
                            ? assignmentModel?.title
                            : completedAssignmentModel?.title) ??
                        '',
                    style: labelMedium.secondary,
                  ),

                  // Html(
                  //   data: (isAssigned
                  //           ? assignmentModel?.description
                  //           : completedAssignmentModel?.description),
                  //   shrinkWrap: true,
                  // ),
                  Html(
                    data: (isAssigned
                            ? assignmentModel?.description
                            : completedAssignmentModel?.description) ??
                        '',
                  ),
                  // Text(
                  //   (isAssigned
                  //           ? assignmentModel?.description
                  //           : completedAssignmentModel?.description) ??
                  //       '',
                  //   style: bodyMedium.grey1,
                  //   maxLines: 2,
                  //   overflow: TextOverflow.ellipsis,
                  // ),
                  Row(
                    mainAxisAlignment: !isAssigned
                        ? MainAxisAlignment.start
                        : MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        !isAssigned ? 'Date ' : (assignmentModel?.status ?? ''),
                        style: labelMedium.copyWith(
                            color: !isAssigned
                                ? ColorResources.darkBG
                                : _colorAsPerStatus(
                                    assignmentModel?.status ?? '')),
                      ),
                      Text(
                        // (isAssigned
                        //         ? assignmentModel?.submissionDate
                        //         : completedAssignmentModel?.submissionDate) ??
                        DateConverter.dateWithMonth((isAssigned
                                ? assignmentModel?.submissionDate
                                : completedAssignmentModel?.submissionDate) ??
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
                _pageMode = _PageMode.assigned;
                _initData();
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
                color: _pageMode == _PageMode.assigned
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
                  'Assigned',
                  textAlign: TextAlign.center,
                  style: _pageMode == _PageMode.assigned
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
                _pageMode = _PageMode.completed;
                _initData();
              });
            },
            child: Container(
              height: 44,
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color: _pageMode == _PageMode.completed
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
                      style: _pageMode == _PageMode.completed
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

  _colorAsPerStatus(String s) {
    switch (s) {
      case 'completed':
        return ColorResources.primary;
      case 'late':
        return ColorResources.warningYellow;
      case 'rejected':
        return ColorResources.RED;
      default:
        return ColorResources.primary;
    }
  }
}

enum _PageMode { assigned, completed }
