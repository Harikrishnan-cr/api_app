
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:samastha/helper/date_converter.dart';
import 'package:samastha/modules/student/bloc/leave_controller.dart';
import 'package:samastha/modules/student/models/rescheduled_classes_model.dart';
import 'package:samastha/theme/color_resources.dart';
import 'package:samastha/theme/t_style.dart';
import 'package:samastha/utils/snackbar_utils.dart';
import 'package:samastha/widgets/app_bars_custom.dart';
import 'package:samastha/widgets/custom_calendar/custom_calender_carsoul.dart';
import 'package:samastha/widgets/custom_form_elements.dart';
import 'package:samastha/widgets/default_loading_widget.dart';

class RescheduleScreen extends StatefulWidget {
  const RescheduleScreen(
      {super.key, required this.studentId, required this.leaveId, required this.leaveStartDate});
  static const String path = '/reschedule-screen';
  final int studentId;
  final int leaveId;
  final DateTime? leaveStartDate;

  @override
  State<RescheduleScreen> createState() => _RescheduleScreenState();
}

class _RescheduleScreenState extends State<RescheduleScreen> {
  LeaveController bloc = LeaveController();
  late Future rescheduledClassesFuture;
 late DateTime leaveDate;

  @override
  void initState() {
    leaveDate = widget.leaveStartDate ?? DateTime.now();
    print('leaveDate $leaveDate');
    rescheduledClassesFuture =
        bloc.rescheduledClasses(widget.studentId, widget.leaveId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SimpleAppBar(title: 'Reschedule'),
      body: SafeArea(
          child: SingleChildScrollView(
        padding: pagePadding.copyWith(bottom: 20),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: CustomCalendarWidget(
                currentDate: leaveDate,
                markedDatesMap: bloc.markedDateMap,
              ),
            ),
            const Gap(16),
            FutureBuilder(
                future: rescheduledClassesFuture,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                        child: Padding(
                      padding: const EdgeInsets.only(top: 30.0),
                      child: Text(snapshot.error.toString()),
                    ));
                  }

                  switch (snapshot.connectionState) {
                    case ConnectionState.done:
                    RescheduledClassesJsonModel? model = snapshot.data;
                      List<RescheduledClassesModel> rescheduleList = model?.data ?? [];
                      List<DateTime> dateTimeList = model?.dates ?? [];
                      if (bloc.markedDateMap.events.isEmpty) {
                        bloc.fetchDays(dateTimeList);
                        WidgetsBinding.instance
                            .addPostFrameCallback((timeStamp) {
                          setState(() {});
                        });
                      }
                      // rescheduleList.add(rescheduleList[0]);
                      // List<Subject> subjects = rescheduleList.subjects ?? [];
                      // print('rescheduleList len ${rescheduleList.length}');
                      // print('dateTimeList len ${dateTimeList.length}');
                      
                      // WidgetsBinding.instance.addPostFrameCallback((_) {
                      //   setState(() {
                      //     if(rescheduleList.isNotEmpty) leaveDate = rescheduleList[0].date!;
                      //   });
                      // });

                      return ListView.builder(
                              itemCount: rescheduleList.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return _Item(
                                  leaveId: widget.leaveId,
                                  studentId: widget.studentId,
                                  date: rescheduleList[index].date!,
                                  leaveDate: DateConverter.dateWithMonth(
                                      rescheduleList[index].date ??
                                          DateTime.now()),
                                  // toDate: rescheduleList.toDate == null
                                  //     ? null
                                  //     : DateConverter.dateWithMonth(
                                  //         rescheduleList.toDate!),
                                  subjectName:
                                      // rescheduleModel.subjects?[index].title ??
                                      '',
                                  availableTimeSlot:
                                      rescheduleList[index].availableTime ?? [],
                                  whatsWillCover: List.generate(
                                      rescheduleList[index].subjects!.length,
                                      (subjectIndex) =>
                                          rescheduleList[index]
                                              .subjects?[subjectIndex]
                                                .title ??
                                            ''),
                                    onJoinedBatch: (bool value) {
                                      if (value) {
                                        setState(() {
                                          rescheduledClassesFuture =
                                              bloc.rescheduledClasses(
                                                  widget.studentId,
                                                  widget.leaveId);
                                        });
                                      }
                                    });
                              });
                    case ConnectionState.waiting:
                      return const Center(child: LoadingWidget());
                    default:
                      return Container();
                  }
                }),
            // const _Item(
            //   bgColor: Colors.white,
            //   status: '',
            // ),
            const Gap(12),
          ],
        ),
      )),
    );
  }
}

class _Item extends StatefulWidget {
  const _Item({
    required this.leaveDate,
    required this.availableTimeSlot,
    required this.subjectName,
    required this.whatsWillCover,
    // required this.toDate,
    required this.studentId,
    required this.leaveId, required this.date, this.onJoinedBatch,
  });

  // final Color? bgColor;
  // final String? status;
  final String leaveDate;
  // final String? toDate;
  final String subjectName;
  final List<AvailableTimeSlot> availableTimeSlot;
  final List<String> whatsWillCover;
  final int studentId;
  final int leaveId;
  final DateTime date;
  final ValueChanged<bool>? onJoinedBatch;

  @override
  State<_Item> createState() => _ItemState();
}

class _ItemState extends State<_Item> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Container(
        // padding: const EdgeInsets.all(16),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: ColorResources.WHITE,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Gap(16),
                  Text(
                    'Matching Schedule',
                    style: titleLarge.darkBG,
                  ),
                  const Gap(9),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          widget.leaveDate,
                          style: titleSmall.darkBG,
                        ),
                      ),
                      Text(
                        'Batch UKSP22334',
                        style: bodyMedium.darkBG,
                      )
                    ],
                  ),
                  const Gap(6),
                  Text(
                    'Available Slots',
                    style: bodyMedium.secondary,
                  ),
                  const Gap(7),
                  Wrap(
                    children: [
                      ...widget.availableTimeSlot.map((e) => GestureDetector(
                            onTap: () {},
                            child: Card(
                              elevation: 0,
                              color: const Color(0xffF0F0F0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(DateConverter.convertTimeToTime(
                                    e.name ?? '')),
                              ),
                            ),
                          )),
                      // for (var i = 0; i <= 5; i++)
                      //   GestureDetector(
                      //     onTap: () {},
                      //     child: Card(
                      //       elevation: 0,
                      //       color: const Color(0xffF0F0F0),
                      //       shape: RoundedRectangleBorder(
                      //         borderRadius: BorderRadius.circular(100),
                      //       ),
                      //       child: const Padding(
                      //         padding: EdgeInsets.all(5.0),
                      //         child: Text('03:30 AM'),
                      //       ),
                      //     ),
                      //   )
                    ],
                  )
                ],
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Subject',
                    style: labelMedium.darkBG,
                  ),
                  Text(
                    widget.subjectName,
                    style: titleLarge.darkBG,
                  ),
                  const Gap(10),
                  Text(
                    'What will cover?',
                    style: labelMedium.darkBG,
                  ),
                  const Gap(4),
                  ListView.builder(
                      itemCount: widget.whatsWillCover.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Text(
                            '${index + 1}. ${widget.whatsWillCover[index]}');
                      }),
                  const Gap(16),
                  CustomOutlineButton(
                    'Join this batch',
                    onTap: (loader) {
                      AvailableTimeSlot? selectedTimeSlote =
                          widget.availableTimeSlot[0];
                      int? selectedTimeSlotId =
                          widget.availableTimeSlot[0].id ?? 0;
                          // String? testString = widget.availableTimeSlot[0].name ?? '';
                      LeaveController bloc = LeaveController();
                      showDialog(
                        context: context,
                        builder: (context) => Dialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(22),
                          ),
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(22),
                              color: Colors.white,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Select time slot',
                                  style: titleLarge.darkBG,
                                ),
                                const Gap(16),
                                // CustomDropdownButtonFormField(
                                //   value: testString,
                                //   items: List.generate(
                                //       widget.availableTimeSlot.length,
                                //       (index) => widget.availableTimeSlot[index].name),
                                //   onChanged: (timeSlotId) {
                                //     setState(() {
                                //       // this.selectedCityId = states
                                //       //     .singleWhere((x) => x.stateId == timeSlotId)
                                //       //     .cities[0]
                                //       //     .cityId; // set to first city for this state
                                //       testString = timeSlotId;
                                //     });
                                //   },
                                //   hintText: 'Select your time slot',
                                //   // labelText: 'Class time',
                                // ),
                                
                                DropdownButtonFormField<int>(
                                  decoration: defaultInputDecoration.copyWith(
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    hintText: 'Select your time slot',
                                    hintStyle: labelLarge.darkBG,
                                    labelStyle: labelLarge.darkBG,
                                    // suffixIcon: Assets.svgs.dropdown.svg(),
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 17,
                                      vertical: 0,
                                    ),
                                  ),
                                  value: selectedTimeSlotId,
                                  items: widget.availableTimeSlot
                                      .map((AvailableTimeSlot state) {
                                    return DropdownMenuItem<int>(
                                      value: state.id,
                                      child: Text(DateConverter.convertTimeToTime(
                                          widget.availableTimeSlot
                                                  .singleWhere(
                                                      (x) => x.id == state.id)
                                                  .name ??
                                              '')),
                                    );
                                  }).toList(),
                                  onChanged: (int? timeSlotId) {
                                    setState(() {
                                      selectedTimeSlotId = timeSlotId;
                                    });
                                  },
                                ),
                                const Gap(16),
                                SubmitButton(
                                  'Join Batch',
                                  onTap: (loader) => bloc
                                      .submitRescheduledClass(widget.studentId,
                                          widget.leaveId, selectedTimeSlote.id!,widget.date)
                                      .then((value) {
                                        print('submit reschedule $value');
                                    if (value.status ?? false) {
                                      //todo
                                      showErrorMessage(value.data ?? 'Joined');
                                      Navigator.pop(context);
                                      widget.onJoinedBatch?.call(value.status ?? false);
                                    } else {
                                      //todo
                                    }
                                  }),
                                )
                              ],
                            ),
                          ),
                          // title: Text('Select time slot'),
                        ),
                      );
                    },
                  ),
                  const Gap(12),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
