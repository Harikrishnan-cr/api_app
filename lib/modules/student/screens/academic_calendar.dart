import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:samastha/core/isparent_loged_in_details.dart';
import 'package:samastha/helper/date_converter.dart';
import 'package:samastha/modules/student/bloc/lesson_plan_controller.dart';
import 'package:samastha/modules/student/models/academic_calender_model.dart';
import 'package:samastha/theme/color_resources.dart';
import 'package:samastha/theme/t_style.dart';
import 'package:samastha/widgets/app_bars_custom.dart';
import 'package:samastha/widgets/custom_calendar/custom_calender_carsoul.dart';
import 'package:samastha/widgets/custom_form_elements.dart';
import 'package:samastha/widgets/default_loading_widget.dart';

class AcademicCalendar extends StatefulWidget {
  const AcademicCalendar({super.key});
  static const String path = '/academic-calendar';

  @override
  State<AcademicCalendar> createState() => _AcademicCalendarState();
}

class _AcademicCalendarState extends State<AcademicCalendar> {
  LessonPlanController bloc = LessonPlanController();
  late Future academiccalendarFuture;
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    if (IsParentLogedInDetails.isParentLogedIn()) {
      academiccalendarFuture =
          bloc.academicCalendarForParent(selectedDate.year, selectedDate.month);

      return;
    }
    academiccalendarFuture =
        bloc.academicCalendar(selectedDate.year, selectedDate.month);
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
              markedDatesMap: bloc.markedDateMap,
              calendarOnChange: (DateTime date) {
                if (IsParentLogedInDetails.isParentLogedIn()) {
                  setState(() {
                    selectedDate = date;
                    academiccalendarFuture =
                        bloc.academicCalendarForParent(date.year, date.month);
                  });

                  return;
                }
                setState(() {
                  selectedDate = date;
                  academiccalendarFuture =
                      bloc.academicCalendar(date.year, date.month);
                });
              },
              onDayPressed: (dateTime, event) {
                print('object date changed');
                setState(() {
                  selectedDate = dateTime;
                  //  academiccalendarFuture = bloc.academicCalendar(
                  //       selectedDate.year, selectedDate.month, selectedDate.day);
                });
              },
            ),
            const Gap(25),
            FutureBuilder(
                future: academiccalendarFuture,
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
                      AcademicCalenderModel? academicCalendarList =
                          snapshot.data;
                      List<Day?> days = academicCalendarList?.days ?? [];

                      if (bloc.markedDateMap.events.isEmpty) {
                        bloc.fetchDays(List.generate(
                            days.length, (index) => days[index]!.lessonDate!));
                        WidgetsBinding.instance
                            .addPostFrameCallback((timeStamp) {
                          setState(() {});
                        });
                      }
                      return ListView.builder(
                          itemCount: days.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12.0),
                              child: _AgendaWidget(
                                bgColor: selectedDate == days[index]?.lessonDate
                                    ? ColorResources.secondary.withOpacity(0.4)
                                    : Colors.white,
                                date: DateConverter.dateWithMonth(
                                    days[index]!.lessonDate!),
                                lessons: days[index]?.batchLessons,
                              ),
                            );
                          });
                    case ConnectionState.waiting:
                      return const Center(child: LoadingWidget());
                    default:
                      return Container();
                  }
                }),
            const Gap(20),
            SizedBox(
              width: 160,
              child: CustomOutlineButton(
                textColor: Colors.white,
                bgColor: ColorResources.secondary,
                'Today',
                onTap: (loader) {
                  setState(() {
                    selectedDate = DateTime.now();
                    //  academiccalendarFuture = bloc.academicCalendar(
                    //       selectedDate.year, selectedDate.month, selectedDate.day);
                  });
                },
              ),
            ),
          ],
        ),
      )),
    );
  }
}

class _AgendaWidget extends StatelessWidget {
  _AgendaWidget({
    this.bgColor,
    this.date,
    this.lessons,
  });

  final Color? bgColor;
  final String? date;
  List<BatchLesson>? lessons;
  // final String? status;
  // final String? subjectName;
  // final List<String>? whatsWillCover;
  // final Widget? buttonWidget;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: bgColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  date ?? '',
                  style: titleLarge.darkBG,
                ),
              ),
              // if (status != null)
              //   Text(
              //     status ?? '',
              //     style: titleSmall.copyWith(color: const Color(0xffEB1313)),
              //   )
            ],
          ),
          const Gap(14),
          const Divider(),
          ListView.builder(
              itemCount: lessons?.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Subject',
                        style: labelMedium.darkBG,
                      ),
                      Text(
                        '${lessons?[index].lesson?.title ?? ''} (${lessons?[index].lesson?.subject?.title ?? ''})',
                        style: titleLarge.darkBG,
                      ),
                      const Gap(10),
                      Text(
                        'What will cover?',
                        style: labelMedium.darkBG,
                      ),
                      const Gap(4),
                      lessons?[index].lesson?.topics != null
                          ? ListView.builder(
                              itemCount: lessons?[index].lesson?.topics?.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return Text(
                                    '${index + 1}. ${lessons?[index].lesson?.topics?[index].title ?? ''}');
                              })
                          : const SizedBox(),
                    ],
                  ),
                );
              }),
          // Visibility(
          //   visible: buttonWidget != null,
          //   child: Column(
          //     children: [
          //       const Gap(16),
          //       buttonWidget ?? const SizedBox(),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}
