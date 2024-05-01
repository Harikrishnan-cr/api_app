import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:samastha/helper/date_converter.dart';
import 'package:samastha/modules/student/bloc/missed_class/one_to_one_controller.dart';
import 'package:samastha/modules/student/models/missed_class/matching_schedules_model.dart';
import 'package:samastha/modules/student/models/rescheduled_classes_model.dart';
import 'package:samastha/theme/color_resources.dart';
import 'package:samastha/theme/t_style.dart';
import 'package:samastha/utils/snackbar_utils.dart';
import 'package:samastha/widgets/app_bars_custom.dart';
import 'package:samastha/widgets/custom_calendar/custom_calender_carsoul.dart';
import 'package:samastha/widgets/custom_form_elements.dart';
import 'package:samastha/widgets/default_loading_widget.dart';

class OneToOneScheduleScreen extends StatefulWidget {
  const OneToOneScheduleScreen(
      {super.key, required this.subjectId, required this.missedClassId});
  static const String path = '/one-to-one-screen';
  final int subjectId;
  final int missedClassId;

  @override
  State<OneToOneScheduleScreen> createState() => _OneToOneScheduleScreenState();
}

class _OneToOneScheduleScreenState extends State<OneToOneScheduleScreen> {
  OneToOneController bloc = OneToOneController();
  late Future matchingSchedulesFuture;
  DateTime leaveDate = DateTime.now();

  @override
  void initState() {
    matchingSchedulesFuture = bloc.fetchMatchingSchedules(
        widget.subjectId, widget.missedClassId); //todo.
    bloc.fetchDays([
      DateTime(2023, 12, 27),
      DateTime(2023, 12, 24),
      DateTime(2023, 12, 25),
      DateTime(2023, 12, 28)
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SimpleAppBar(title: 'Matching schedules'),
      body: SafeArea(
          child: SingleChildScrollView(
        padding: pagePadding.copyWith(bottom: 20),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: CustomCalendarWidget(
                currentDate: leaveDate,
                // markedDatesMap: bloc.markedDateMap,
              ),
            ),
            const Gap(16),
            FutureBuilder(
                future: matchingSchedulesFuture,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                        child: Padding(
                      padding: const EdgeInsets.only(top: 30.0),
                      child: Text(snapshot.error.toString()),
                    ));
                  }

                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return const Center(child: LoadingWidget());
                    case ConnectionState.done:
                      ScheduleDatum scheduleData = snapshot.data;
                      List<MatchingScheduleModel> list =
                          scheduleData.data ?? [];

                      return (list.isEmpty)
                          ? const Text('Lessons not found')
                          : ListView.builder(
                              itemCount: list.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return _Item(
                                    leaveId: 0,
                                    studentId: 0,
                                    date: list[index].date!,
                                    leaveDate: DateConverter.dateWithMonth(
                                        list[index].date ?? DateTime.now()),
                                    // toDate: rescheduleList.toDate == null
                                    //     ? null
                                    //     : DateConverter.dateWithMonth(
                                    //         rescheduleList.toDate!),
                                    subjectName:
                                        // rescheduleModel.subjects?[index].title ??
                                        'Subject',
                                    availableTimeSlot:
                                        list[index].availableTime ?? [],
                                    onButtonPressed: (loader, timeslot) {
                                      if (timeslot == null) {
                                        showErrorMessage('Select time slot');
                                      } else {
                                        try {
                                          bloc
                                              .scheduleMissedClass(
                                                  list[index].date,
                                                  timeslot.id!)
                                              .then((value) {
                                                print('schdd one to ${value.message}');
                                            showErrorMessage(
                                                value.message ?? '');
                                            if (value.status ?? false) {
                                              matchingSchedulesFuture =
                                                  bloc.fetchMatchingSchedules(
                                                      widget.subjectId,
                                                      widget.missedClassId);
                                              setState(() {});
                                            } else {}
                                          });
                                          // AvailableTimeSlot? selectedTimeSlote =
                                          //     widget.availableTimeSlot[0];
                                          // int? selectedTimeSlotId = widget.availableTimeSlot[0].id ?? 0;
                                          // String? testString = widget.availableTimeSlot[0].name ?? '';
                                          // LeaveController bloc = LeaveController();
                                          // showErrorMessage('Scheduled');
                                        } catch (e) {
                                          print('error schdd : $e');
                                          showErrorMessage(e.toString());
                                        }
                                      }
                                    },
                                    onJoinedBatch: (bool value) {
                                      if (value) {
                                        setState(() {
                                          // rescheduledClassesFuture =
                                          //     bloc.rescheduledClasses(
                                          //         widget.studentId,
                                          //         widget.leaveId); //tod
                                        });
                                      }
                                    });
                              });
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
  const _Item(
      {required this.leaveDate,
      required this.availableTimeSlot,
      required this.subjectName,
      // required this.whatsWillCover,
      // required this.toDate,
      required this.studentId,
      required this.leaveId,
      required this.date,
      this.onJoinedBatch,
      this.bgColor,
      this.onButtonPressed
      // this.batchname,
      });

  final Color? bgColor;
  // final String? status;
  final String leaveDate;
  // final String? toDate;
  final String subjectName;
  // final List<AvailableTimeSlot> availableTimeSlot;
  final List<AvailableTime> availableTimeSlot;
  // final List<String> whatsWillCover;
  final int studentId;
  final int leaveId;
  final DateTime date;
  final ValueChanged<bool>? onJoinedBatch;
  final void Function(void Function() loader, AvailableTime? selectedTime)?
      onButtonPressed;

  // final String? batchname;

  @override
  State<_Item> createState() => _ItemState();
}

class _ItemState extends State<_Item> {
  AvailableTime? selectedTimeSlote;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: widget.bgColor ?? ColorResources.WHITE,
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
                  'Available slots',
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
                    // Text(
                    //   'Batch ${widget.batchname ?? ''}',
                    //   style: bodyMedium.darkBG,
                    // )
                  ],
                ),
                const Gap(15),
                Wrap(
                  children: [
                    ...widget.availableTimeSlot.map((e) => GestureDetector(
                          onTap: () {
                            selectedTimeSlote = e;
                            setState(() {});
                          },
                          child: Card(
                            elevation: 0,
                            color: (selectedTimeSlote?.id == e.id)
                                ? ColorResources.primary
                                : const Color(0xffF0F0F0),
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
                  ],
                )
              ],
            ),
          ),
          const Gap(12),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: CustomOutlineButton(
                'Schedule',
                onTap: (loader) =>
                    widget.onButtonPressed!(loader, selectedTimeSlote),
              )),
          const Gap(12),
        ],
      ),
    );
  }
}
