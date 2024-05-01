import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:samastha/core/isparent_loged_in_details.dart';
import 'package:samastha/helper/date_converter.dart';
import 'package:samastha/modules/madrasa/controller/time_table_controller.dart';
import 'package:samastha/modules/madrasa/models/time_table_subjects_model.dart';
import 'package:samastha/modules/madrasa/screens/course_materials.dart';
import 'package:samastha/modules/student/models/academic_calender_model.dart';
import 'package:samastha/theme/color_resources.dart';
import 'package:samastha/theme/t_style.dart';
import 'package:samastha/widgets/app_bars_custom.dart';
import 'package:samastha/widgets/custom_calendar/custom_calender_carsoul.dart';
import 'package:samastha/widgets/default_loading_widget.dart';

class TimeTableScreen extends StatefulWidget {
  const TimeTableScreen({super.key});
  static const String path = '/time-table';

  @override
  State<TimeTableScreen> createState() => _TimeTableScreenState();
}

class _TimeTableScreenState extends State<TimeTableScreen> {
  TimeTableController bloc = TimeTableController();
  late Future subjectsFuture;
  // late Future academiccalendarFuture;
  late DateTime selectedDate;

  @override
  void initState() {
    selectedDate = DateTime.now();
    if (IsParentLogedInDetails.isParentLogedIn()) {
      subjectsFuture = bloc.fetchSubjectsForParents(
          day: selectedDate.day,
          month: selectedDate.month,
          year: selectedDate.year);

      return;
      // academiccalendarFuture =
    }

    subjectsFuture = bloc.fetchSubjects(
        day: selectedDate.day,
        month: selectedDate.month,
        year: selectedDate.year);
    // academiccalendarFuture =
    //     bloc.academicCalendar(selectedDate.year, selectedDate.month, selectedDate.day);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SimpleAppBar(title: 'Academic Calendar'),
      body: SafeArea(
          child: SingleChildScrollView(
        padding: pagePadding,
        child: Column(
          children: [
            CustomCalendarWidget(
              currentDate: selectedDate,
              calendarOnChange: (dateTime) {
                log('curent date time is $dateTime');
                if (IsParentLogedInDetails.isParentLogedIn()) {
                  setState(() {
                    selectedDate = dateTime;
                  });
                  return subjectsFuture = bloc.fetchSubjectsForParents(
                      day: dateTime.day,
                      month: dateTime.month,
                      year: dateTime.year);
                }
                setState(() {
                  selectedDate = dateTime;
                });
                return subjectsFuture = bloc.fetchSubjects(
                    day: dateTime.day,
                    month: dateTime.month,
                    year: dateTime.year);
              },
              onDayPressed: (dateTime, listEvent) {
                if (IsParentLogedInDetails.isParentLogedIn()) {
                  setState(() {
                    selectedDate = dateTime;
                  });
                  return subjectsFuture = bloc.fetchSubjectsForParents(
                      day: dateTime.day,
                      month: dateTime.month,
                      year: dateTime.year);
                }
                setState(() {
                  selectedDate = dateTime;
                });
                return subjectsFuture = bloc.fetchSubjects(
                    day: dateTime.day,
                    month: dateTime.month,
                    year: dateTime.year);
              },
            ),
            // CustomCalendarWidget(
            //   currentDate: selectedDate,
            //   markedDatesMap: bloc.markedDateMap,
            //   calendarOnChange: (DateTime date) {
            //     setState(() {
            //       selectedDate = date;
            //       academiccalendarFuture = bloc.academicCalendar(date.year, date.month, date.day);
            //     });
            //   },
            //   onDayPressed: (dateTime, event) {
            //     print('object date changed');
            //     setState(() {
            //       selectedDate = dateTime;
            //       //  academiccalendarFuture = bloc.academicCalendar(
            //       //       selectedDate.year, selectedDate.month, selectedDate.day);
            //     });
            //   },
            // ),

            const Gap(25),

            // FutureBuilder(
            //   future: academiccalendarFuture,
            //   builder: (context, snapshot) {
            //     AcademicCalenderModel? academicCalendarList = snapshot.data;
            //     List<Day?> days = academicCalendarList?.days ?? [];
            //     if (bloc.markedDateMap.events.isEmpty) {
            //       bloc.fetchDays(List.generate(
            //           days.length, (index) => days[index]!.lessonDate!));
            //       WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            //         setState(() {});
            //       });
            //     }
            //     return Container();
            //   },
            // ),

            FutureBuilder(
                future: subjectsFuture,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Center(
                        child: Padding(
                      padding: EdgeInsets.only(top: 300.0),
                      child: Text('No data found'),
                    ));
                  }

                  switch (snapshot.connectionState) {
                    case ConnectionState.done:
                      List<TimeTableSubjectsModel> list = snapshot.data;
                      return ListView.builder(
                          itemCount: list.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12.0),
                              child: AgendaWidget(
                                  data: list[index].subjects,
                                  selectedDate: list[index].lessonDate!),
                            );
                          });

                    case ConnectionState.waiting:
                      return const Center(child: LoadingWidget());
                    default:
                      return Container();
                  }
                }),

            // AgendaWidget(
            //   bgColor: ColorResources.secondary.withOpacity(.4),
            // ),
            // const Gap(16),
            // const AgendaWidget(
            //   bgColor: ColorResources.WHITE,
            //   status: 'Attended',
            // ),
            const Gap(80),
          ],
        ),
      )),
    );
  }
}

class AgendaWidget extends StatelessWidget {
  const AgendaWidget({
    super.key,
    this.bgColor,
    this.status,
    required this.data,
    required this.selectedDate,
  });

  final Color? bgColor;
  final String? status;
  final List<TimeTableSubject>? data;
  final DateTime selectedDate;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: bgColor ?? ColorResources.WHITE,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  DateConverter.dateWithMonth(selectedDate),
                  style: titleSmall.darkBG,
                ),
              ),
              if (status != null) ...[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      status ?? '',
                      style: titleSmall.primary,
                    ),
                    Text(
                      '30 min/50 min',
                      style:
                          labelLarge.copyWith(color: const Color(0xffEBB700)),
                    )
                  ],
                ),
              ]
            ],
          ),
          const Gap(14),
          const Divider(),
          ...data!.map((e) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Subject',
                    style: labelMedium.darkBG,
                  ),
                  Text(
                    e.title ?? '',
                    style: titleLarge.darkBG,
                  ),
                  const Gap(10),
                  Text(
                    'What will cover?',
                    style: labelMedium.darkBG,
                  ),
                  const Gap(4),
                  ListView.builder(
                      itemCount: e.lessons?.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            Text(
                                '${index + 1}. ${e.lessons?[index].title ?? ''}')
                          ],
                        );
                      }),
                  const Gap(10),
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, CourseMaterialsScreen.path,
                            arguments: e.id);
                      },
                      child: Text(
                        "View Material",
                        style: titleSmall.primary,
                      ))
                ],
              )),
        ],
      ),
    );
  }
}
