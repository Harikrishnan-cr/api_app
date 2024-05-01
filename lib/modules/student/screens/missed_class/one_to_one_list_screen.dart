import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:samastha/modules/student/bloc/missed_class/one_to_one_controller.dart';
import 'package:samastha/modules/student/models/missed_class/one_to_one_list_model.dart';
import 'package:samastha/theme/color_resources.dart';
import 'package:samastha/theme/dimensions.dart';
import 'package:samastha/theme/t_style.dart';
import 'package:samastha/utils/error_reload.dart';
import 'package:samastha/widgets/app_bars_custom.dart';
import 'package:samastha/widgets/default_loading_widget.dart';

class OneToOneListScreen extends StatefulWidget {
  const OneToOneListScreen({super.key});

  @override
  State<OneToOneListScreen> createState() => _OneToOneListScreenState();
}

class _OneToOneListScreenState extends State<OneToOneListScreen> {
 _PageMode _pageMode = _PageMode.requestedClass;
  OneToOneController bloc = OneToOneController();
  late Future requestClassListFuture;
  late Future approvedClassListFuture;

  _initData({required _PageMode? mode}) {
    switch (mode) {
      case _PageMode.requestedClass:
        requestClassListFuture = bloc.fetchOneToOneList();
        return;
      case _PageMode.approvedClass:
        approvedClassListFuture = bloc.fetchOneToOneList(isComplete: true);
        return;
      default:
        requestClassListFuture = bloc.fetchOneToOneList();
        approvedClassListFuture = bloc.fetchOneToOneList();
        return;
    }
  }

  @override
  void initState() {
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
              setState(() {
                _initData(mode: _PageMode.requestedClass);
                _pageMode = _PageMode.requestedClass;
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
                color: _pageMode == _PageMode.requestedClass
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
                  'Requested',
                  textAlign: TextAlign.center,
                  style: _pageMode == _PageMode.requestedClass
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
                _pageMode = _PageMode.approvedClass;
                _initData(mode: _PageMode.approvedClass);
              });
            },
            child: Container(
              height: 44,
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color: _pageMode == _PageMode.approvedClass
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
                      'Approved',
                      textAlign: TextAlign.center,
                      style: _pageMode == _PageMode.approvedClass
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
      // bottomNavigationBar: Padding(
      //   padding: pagePadding.copyWith(bottom: 10),
      //   child: SubmitButton(
      //     'Create leave request',
      //     onTap: (loader) {
      //       Navigator.pushNamed(context, RequestLeaveForm.path)
      //           .then((value) => setState(() {
      //                 _initData(mode: null);
      //               }));
      //     },
      //   ),
      // ),
      appBar: const SimpleAppBar(title: 'Leave Requests'),
      body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
                    children: [
            _buildModeSwitcher(),
            FutureBuilder(
                future: Future.wait(
                    [requestClassListFuture, approvedClassListFuture]),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return errorReload(snapshot.error.toString(),
                        onTap: () => _initData(mode: null));
                  }
            
                  switch (snapshot.connectionState) {
                    case ConnectionState.done:
                      List<OneToOneListModel> requestedList =
                          snapshot.data?[0] ?? [];
                      List<OneToOneListModel> approvedList =
                          snapshot.data?[1] ?? [];
        
                      return bodyBuilder(requestedList, approvedList);
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

  Widget bodyBuilder(List<OneToOneListModel> leaveRequestList,
      List<OneToOneListModel> approvedLeaveList) {
    bool isRequestClass = _pageMode == _PageMode.requestedClass;
    final listWidget = ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: pagePadding.copyWith(bottom: 0),
        itemCount: 
            isRequestClass ? leaveRequestList.length : approvedLeaveList.length,
        itemBuilder: (context, index) {
         
          return isRequestClass
              ? item(true, requestModel: leaveRequestList[index])
              : item(false,
                  approvedLeaveModel: approvedLeaveList[index]);
        });

    return isRequestClass
        ? leaveRequestList.isEmpty
            ? const Center(child: Padding(
              padding: EdgeInsets.only(top: 300.0),
              child: Text('No requests'),
            ))
            : listWidget
        : approvedLeaveList.isEmpty
            ? const Center(child: Padding(
              padding: EdgeInsets.only(top: 300.0),
              child: Text('No approved class'),
            ))
            : listWidget;
  }

  Container item(bool isRequestClass,
      {OneToOneListModel? requestModel,
      OneToOneListModel? approvedLeaveModel}) {
    return Container(
      width: double.infinity,
      decoration: defaultDecoration,
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text( "Title",
            // toBeginningOfSentenceCase((isLeaveRequest
            //         ? leaveRequestModel?.leaveType!.replaceAll('_', ' ')
            //         : approvedLeaveRequestModel?.leaveType?.leaveName!
            //             .replaceAll('_', ' '))) ??
            //     '',
            style: titleSmall.darkBG,
          ),
          const Gap(8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Date",
                // isLeaveRequest
                //     ? '${leaveRequestModel?.leaveStartDate == null ? '' : DateConverter.estimatedDate(leaveRequestModel!.leaveStartDate!)} - ${leaveRequestModel?.leaveEndDate == null ? '' : DateConverter.estimatedDate(leaveRequestModel!.leaveEndDate!)}'
                //     : '${approvedLeaveRequestModel?.leaveStartDate == null ? '' : DateConverter.estimatedDate(approvedLeaveRequestModel!.leaveStartDate!)} - ${approvedLeaveRequestModel?.leaveEndDate == null ? '' : DateConverter.estimatedDate(approvedLeaveRequestModel!.leaveEndDate!)}',
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
            isRequestClass ? 'Pending Approval' : 'Approved',
            style: isRequestClass ? labelMedium.secondary : labelMedium.primary,
          ),
          const Gap(8),
          Text("Description",
            // (isLeaveRequest
            //         ? leaveRequestModel?.description
            //         : approvedLeaveRequestModel?.description) ??
            //     '',
            style: bodyMedium.grey1,
          ),
          // if (!isLeaveRequest) ...[
          //   const Gap(8),
          //   SizedBox(
          //     height: 49,
          //     child: CustomOutlineButton(
          //       'Reschedule this class',
          //       onTap: (loader) {
          //         Navigator.pushNamed(context, RescheduleScreen.path,
          //             arguments: {
          //               "studentId": AppConstants.studentID,
          //               "leaveId": approvedLeaveRequestModel?.id,
          //               "leaveDate": approvedLeaveRequestModel?.leaveStartDate
          //             }).then((value) => setState(() {
          //               _initData(mode: null);
          //             }));
          //       },
          //     ),
          //   ),
          // ],
        ],
      ),
    );
  }
}


enum _PageMode { requestedClass, approvedClass }