import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:samastha/core/app_constants.dart';
import 'package:samastha/gen/assets.gen.dart';
import 'package:samastha/helper/date_converter.dart';
import 'package:samastha/modules/student/bloc/missed_class/missed_class_controller.dart';
import 'package:samastha/modules/student/models/missed_class/missed_classes_model.dart';
import 'package:samastha/modules/student/screens/missed_class/one_to_one_class.dart';
import 'package:samastha/theme/dimensions.dart';
import 'package:samastha/theme/t_style.dart';
import 'package:samastha/widgets/app_bars_custom.dart';
import 'package:samastha/widgets/custom_calendar/custom_calender_carsoul.dart';
import 'package:samastha/widgets/custom_form_elements.dart';
import 'package:samastha/widgets/default_loading_widget.dart';

class MissedClassesScreen extends StatefulWidget {
  const MissedClassesScreen({super.key, required this.studentId});
  static const String path = '/missed-classes';
  final int studentId;

  @override
  State<MissedClassesScreen> createState() => _MissedClassesScreenState();
}

class _MissedClassesScreenState extends State<MissedClassesScreen> {
  MissedClassController bloc = MissedClassController();
  late Future missedClassFuture;
  DateTime currentDate = DateTime.now();

  fetchMissedClass(DateTime dateTime) {
    missedClassFuture = bloc.fetchMissedClasses(
        widget.studentId, dateTime.year, dateTime.month, dateTime.day);
  }

  @override
  void initState() {
    fetchMissedClass(currentDate);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SimpleAppBar(title: 'Missed Classes'),
      body: SafeArea(
          child: SingleChildScrollView(
        padding: pagePadding,
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: CustomCalendarWidget(
                currentDate: currentDate,
                onDayPressed: (dateTime, event) {
                  setState(() {
                    currentDate = dateTime;
                    fetchMissedClass(dateTime);
                  });
                },
                calendarOnChange: (date) {
                  setState(() {
                    currentDate = date;
                    missedClassFuture = bloc.fetchMissedClasses(
                        widget.studentId, date.year, date.month, date.day);
                  });
                },
              ),
            ),
            // const Gap(16),
            // CustomMultiDateCalendar(selectedDates: [
            //   DateTime(2023, 12, 5),
            //   DateTime(2023, 12, 8),
            //   DateTime(2023, 12, 10),
            //   DateTime(2023, 12, 18),
            // ],onDatesSelected: (dates) {

            // },),
            const Gap(16),
            FutureBuilder(
                future: missedClassFuture,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  }

                  switch (snapshot.connectionState) {
                    case ConnectionState.done:
                      MissedClassData? missedClassModel = snapshot.data;
                      List<MissedSubject> missedSubjects =
                          missedClassModel?.subjects ?? [];

                      return ListView.builder(
                          itemCount: missedSubjects.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: _AgendaWidget(
                                date: DateConverter.dateWithMonth(currentDate),
                                subjectName: missedSubjects[index].title,
                                whatsWillCover: List.generate(
                                    missedSubjects[0].lessons?.length ?? 0,
                                    (lessonIndex) =>
                                        missedSubjects[index]
                                            .lessons?[lessonIndex]
                                            .title ??
                                        ''),
                                bgColor: Colors.white,
                                // status: 'Absent',
                                buttonWidget: CustomOutlineButton('Reschedule',
                                    onTap: (loader) {
                                  AppConstants.studentID =
                                      missedClassModel?.studentId;
                                  Navigator.pushNamed(
                                      context, OneToOneClassWelcomeScreen.path,
                                      arguments: {
                                        "missedClassId":
                                            missedClassModel!.missedClassId,
                                        "subjectId": missedSubjects[index].id
                                      });
                                }),
                              ),
                            );
                          });
                    case ConnectionState.waiting:
                      return const Center(child: LoadingWidget());
                    default:
                      return Container();
                  }
                }),
            // const AgendaWidget(
            //   bgColor: Colors.white,
            //   status: 'Absent',
            // ),
            const Gap(12),
            Visibility(
              visible: false,
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, OneToOneClassWelcomeScreen.path,
                      arguments: {"missedClassId": 0, "subjectId": 0});
                },
                child: Container(
                  decoration: defaultDecoration,
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Assets.image.usthadSmall.image(height: 57),
                        const Gap(16),
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Request One to one class',
                              style: titleMedium.secondary,
                            ),
                            const Gap(4),
                            Text(
                              'Request one to one class to compensate missed class',
                              style: labelMedium.darkBG,
                            ),
                          ],
                        ))
                      ]),
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}

class _AgendaWidget extends StatelessWidget {
  const _AgendaWidget({
    this.bgColor,
    this.date,
    this.subjectName,
    this.whatsWillCover,
    this.buttonWidget,
  });

  final Color? bgColor;
  // final String? status;
  final String? date;
  final String? subjectName;
  final List<String>? whatsWillCover;
  final Widget? buttonWidget;

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
          Text(
            'Subject',
            style: labelMedium.darkBG,
          ),
          Text(
            subjectName ?? '',
            style: titleLarge.darkBG,
          ),
          const Gap(10),
          Text(
            'What will cover?',
            style: labelMedium.darkBG,
          ),
          const Gap(4),
          whatsWillCover != null
              ? ListView.builder(
                  itemCount: whatsWillCover?.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Text('${index + 1}. ${whatsWillCover?[index]}');
                  })
              : const SizedBox(),
          Visibility(
            visible: buttonWidget != null,
            child: Column(
              children: [
                const Gap(16),
                buttonWidget ?? const SizedBox(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
