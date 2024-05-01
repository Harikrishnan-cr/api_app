import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:samastha/core/app_constants.dart';
import 'package:samastha/core/isparent_loged_in_details.dart';
import 'package:samastha/helper/date_converter.dart';
import 'package:samastha/modules/student/bloc/leave_controller.dart';
import 'package:samastha/modules/student/models/approved_leave_model.dart';
import 'package:samastha/modules/student/models/leave_request_model.dart';
import 'package:samastha/modules/student/screens/leave_of_absence/request_leave.dart';
import 'package:samastha/modules/student/screens/leave_of_absence/reschedule_screen.dart';
import 'package:samastha/theme/color_resources.dart';
import 'package:samastha/theme/dimensions.dart';
import 'package:samastha/theme/t_style.dart';
import 'package:samastha/utils/error_reload.dart';
import 'package:samastha/widgets/app_bars_custom.dart';
import 'package:samastha/widgets/custom_form_elements.dart';
import 'package:samastha/widgets/default_loading_widget.dart';

class LeaveRequestsListScreen extends StatefulWidget {
  const LeaveRequestsListScreen({super.key});
  static const String path = '/leave-requests-list-screen';

  @override
  State<LeaveRequestsListScreen> createState() =>
      _LeaveRequestsListScreenState();
}

class _LeaveRequestsListScreenState extends State<LeaveRequestsListScreen> {
  _PageMode _pageMode = _PageMode.leaveRequest;
  LeaveController bloc = LeaveController();
  late Future leaveRequestListFuture;
  late Future approvedRequestListFuture;

  _initData({required _PageMode? mode}) {
    switch (mode) {
      case _PageMode.leaveRequest:
        leaveRequestListFuture = bloc.fetchLeaveRequest();
        return;
      case _PageMode.approvedLeave:
        approvedRequestListFuture = bloc.fetchApprovedLeaveRequest();
        return;
      default:
        leaveRequestListFuture = bloc.fetchLeaveRequest();
        approvedRequestListFuture = bloc.fetchApprovedLeaveRequest();
        return;
    }
  }

  _initDataParent({required _PageMode? mode}) {
    switch (mode) {
      case _PageMode.leaveRequest:
        leaveRequestListFuture = bloc.fetchLeaveRequestfromParent();
        return;
      case _PageMode.approvedLeave:
        approvedRequestListFuture = bloc.fetchApprovedLeaveRequestfromParent();
        return;
      default:
        leaveRequestListFuture = bloc.fetchLeaveRequestfromParent();
        approvedRequestListFuture = bloc.fetchApprovedLeaveRequestfromParent();
        return;
    }
  }

  @override
  void initState() {
    if (IsParentLogedInDetails.isParentLogedIn()) {
      _initDataParent(mode: null);

      return;
    }
    _initData(mode: null);
    super.initState();
  }

  Widget _buildModeSwitcher() {
    const grey = 0xffEBEBEB;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              if (IsParentLogedInDetails.isParentLogedIn()) {
                setState(() {
                  _initDataParent(mode: _PageMode.leaveRequest);
                  _pageMode = _PageMode.leaveRequest;
                });

                return;
              }
              setState(() {
                _initData(mode: _PageMode.leaveRequest);
                _pageMode = _PageMode.leaveRequest;
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
                color: _pageMode == _PageMode.leaveRequest
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
                  'Leave Requests',
                  textAlign: TextAlign.center,
                  style: _pageMode == _PageMode.leaveRequest
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
              if (IsParentLogedInDetails.isParentLogedIn()) {
                setState(() {
                  _initDataParent(mode: _PageMode.approvedLeave);
                  _pageMode = _PageMode.approvedLeave;
                });

                return;
              }
              setState(() {
                _pageMode = _PageMode.approvedLeave;
                _initData(mode: _PageMode.approvedLeave);
              });
            },
            child: Container(
              height: 44,
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color: _pageMode == _PageMode.approvedLeave
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
                      'Approved Leave',
                      textAlign: TextAlign.center,
                      style: _pageMode == _PageMode.approvedLeave
                          ? titleSmall.darkBG
                          : titleSmall.copyWith(
                              color: ColorResources.darkBG.withOpacity(.5)),
                    ),
                  ),
                  const Visibility(
                    visible: false,
                    child: Positioned(
                      right: 30,
                      child: CircleAvatar(
                        radius: 3,
                        backgroundColor: ColorResources.RED,
                      ),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: pagePadding.copyWith(bottom: 10),
        child: SubmitButton(
          'Create leave request',
          onTap: (loader) {
            if (IsParentLogedInDetails.isParentLogedIn()) {
              Navigator.pushNamed(context, RequestLeaveForm.path)
                  .then((value) => setState(() {
                        _initDataParent(mode: null);
                      }));
              return;
            }
            Navigator.pushNamed(context, RequestLeaveForm.path)
                .then((value) => setState(() {
                      _initData(mode: null);
                    }));
          },
        ),
      ),
      appBar: const SimpleAppBar(title: 'Leave Requests'),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            _buildModeSwitcher(),
            FutureBuilder(
                future: Future.wait(
                    [leaveRequestListFuture, approvedRequestListFuture]),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return errorReload(snapshot.error.toString(), onTap: () {
                      if (IsParentLogedInDetails.isParentLogedIn()) {
                        _initDataParent(mode: null);
                        return;
                      }

                      _initData(mode: null);
                    });
                  }

                  switch (snapshot.connectionState) {
                    case ConnectionState.done:
                      List<LeaveRequestModel> leaveRequestList =
                          snapshot.data?[0] ?? [];
                      List<ApprovedLeaveRequestModel> approvedLeaveList =
                          snapshot.data?[1] ?? [];

                      print('leaveRequestList ${leaveRequestList.length}');
                      print('approvedLeaveList ${approvedLeaveList.length}');

                      return bodyBuilder(leaveRequestList, approvedLeaveList);
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

  Widget bodyBuilder(List<LeaveRequestModel> leaveRequestList,
      List<ApprovedLeaveRequestModel> approvedLeaveList) {
    bool isLeaveRequest = _pageMode == _PageMode.leaveRequest;
    final listWidget = ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: pagePadding.copyWith(bottom: 0),
        itemCount:
            isLeaveRequest ? leaveRequestList.length : approvedLeaveList.length,
        itemBuilder: (context, index) {
          return isLeaveRequest
              ? item(true, leaveRequestModel: leaveRequestList[index])
              : item(false,
                  approvedLeaveRequestModel: approvedLeaveList[index]);
        });

    return isLeaveRequest
        ? leaveRequestList.isEmpty
            ? const Center(
                child: Padding(
                padding: EdgeInsets.only(top: 300.0),
                child: Text('No leave requests'),
              ))
            : listWidget
        : approvedLeaveList.isEmpty
            ? const Center(
                child: Padding(
                padding: EdgeInsets.only(top: 300.0),
                child: Text('No approved leave'),
              ))
            : listWidget;
  }

  Container item(bool isLeaveRequest,
      {LeaveRequestModel? leaveRequestModel,
      ApprovedLeaveRequestModel? approvedLeaveRequestModel}) {
    return Container(
      width: double.infinity,
      decoration: defaultDecoration,
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            toBeginningOfSentenceCase((isLeaveRequest
                    ? leaveRequestModel?.leaveType!.replaceAll('_', ' ')
                    : approvedLeaveRequestModel?.leaveType?.leaveName!
                        .replaceAll('_', ' '))) ??
                '',
            style: titleSmall.darkBG,
          ),
          const Gap(8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                isLeaveRequest
                    ? '${leaveRequestModel?.leaveStartDate == null ? '' : DateConverter.estimatedDate(leaveRequestModel!.leaveStartDate!)} - ${leaveRequestModel?.leaveEndDate == null ? '' : DateConverter.estimatedDate(leaveRequestModel!.leaveEndDate!)}'
                    : '${approvedLeaveRequestModel?.leaveStartDate == null ? '' : DateConverter.estimatedDate(approvedLeaveRequestModel!.leaveStartDate!)} - ${approvedLeaveRequestModel?.leaveEndDate == null ? '' : DateConverter.estimatedDate(approvedLeaveRequestModel!.leaveEndDate!)}',
                style: titleSmall.darkBG,
              ),
              //todo - check this data type and uncomment(issue)
              // Text(
              //   (isLeaveRequest
              //           ? leaveRequestModel?.noOfDays
              //           : approvedLeaveRequestModel?.noOfDays) ??
              //       '',
              //   style: titleSmall.darkBG,
              // )
            ],
          ),
          const Gap(8),
          Text(
            isLeaveRequest ? 'Pending Approval' : 'Approved',
            style: isLeaveRequest ? labelMedium.secondary : labelMedium.primary,
          ),
          const Gap(8),
          Text(
            (isLeaveRequest
                    ? leaveRequestModel?.description
                    : approvedLeaveRequestModel?.description) ??
                '',
            style: bodyMedium.grey1,
          ),
          if (!isLeaveRequest) ...[
            const Gap(8),
            SizedBox(
              height: 49,
              child: CustomOutlineButton(
                'Reschedule this class',
                onTap: (loader) {
                  Navigator.pushNamed(context, RescheduleScreen.path,
                      arguments: {
                        "studentId": AppConstants.studentID,
                        "leaveId": approvedLeaveRequestModel?.id,
                        "leaveDate": approvedLeaveRequestModel?.leaveStartDate
                      }).then((value) => setState(() {
                        if (IsParentLogedInDetails.isParentLogedIn()) {
                          _initDataParent(mode: null);
                          return;
                        }
                        _initData(mode: null);
                      }));
                },
              ),
            ),
          ],
        ],
      ),
    );
  }
}

enum _PageMode { leaveRequest, approvedLeave }
