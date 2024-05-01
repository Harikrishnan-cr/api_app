import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:samastha/gen/assets.gen.dart';
import 'package:samastha/helper/date_converter.dart';
import 'package:samastha/theme/color_resources.dart';
import 'package:samastha/theme/t_style.dart';
import 'package:samastha/widgets/custom_calendar/event.dart';
import 'package:samastha/widgets/custom_calendar/event_list.dart';
import 'package:samastha/widgets/custom_calendar/flutter_calendar_carousel.dart';
import 'package:table_calendar/table_calendar.dart';

class CustomCalendarWidget extends StatefulWidget {
  final DateTime currentDate;

  final dynamic Function(DateTime date)? calendarOnChange;
  final dynamic Function(DateTime date, List<Event> events)? onDayPressed;

  final EventList<Event>? markedDatesMap;

  const CustomCalendarWidget(
      {super.key,
      required this.currentDate,
      this.calendarOnChange,
      this.markedDatesMap,
      this.onDayPressed});

  @override
  State<CustomCalendarWidget> createState() => _CustomCalendarWidgetState();
}

class _CustomCalendarWidgetState extends State<CustomCalendarWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(
        5,
      ),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              spreadRadius: 0,
              offset: Offset(0, 10),
              blurRadius: 30,
              color: Color(0xffF0F0F0),
            )
          ],
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xffF0F0F0), width: 1)),
      child: CalendarCarousel<Event>(
        onDayPressed: widget.onDayPressed,
        onCalendarChanged: widget.calendarOnChange,
        customWeekDayBuilder: (weekday, weekdayName) {
          return Expanded(
            child: Center(
              child: Container(
                width: 35,
                height: 35,
                margin: const EdgeInsets.only(bottom: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                      color: weekday == 0
                          ? const Color(0xffFF0000)
                          : ColorResources.darkBG),
                ),
                child: Center(
                  child: Text(
                    weekdayName[0].toString(),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: weekday == 0
                            ? const Color(0xffFF0000)
                            : ColorResources.darkBG),
                  ),
                ),
              ),
            ),
          );
        },
        weekendTextStyle: titleLarge.darkBG,
        dayButtonColor: Colors.transparent,
        todayButtonColor: Colors.transparent,
        selectedDayButtonColor: ColorResources.primary,
        thisMonthDayBorderColor: const Color(0xffD7D7D7),
        headerText: widget.currentDate.monthYearName,
        headerTextStyle: titleLarge.darkBG,
        leftButtonIcon: Assets.svgs.arrrowBack.svg(),
        rightButtonIcon:
            RotatedBox(quarterTurns: 2, child: Assets.svgs.arrrowBack.svg()),
        markedDateCustomShapeBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
            side: const BorderSide(
              color: ColorResources.secondary,
            )),
        showOnlyCurrentMonthDate: true,
        weekFormat: false,
        dayCrossAxisAlignment: CrossAxisAlignment.center,
        dayMainAxisAlignment: MainAxisAlignment.center,
        height: 420.0 - 50,
        selectedDateTime: widget.currentDate,
        daysHaveCircularBorder: false,
        markedDatesMap: widget.markedDatesMap,
        markedDateCustomTextStyle: titleLarge.secondary,
        todayTextStyle: titleLarge.darkBG,
        weekdayTextStyle: titleLarge.darkBG,
        markedDateShowIcon: false,
        // daysTextStyle: titleLarge.darkBG,
        inactiveDaysTextStyle: titleLarge.darkBG,
        prevDaysTextStyle: titleLarge.darkBG,
        dayPadding: 4,
        selectedDayTextStyle: titleLarge.darkBG,
        selectedDayBorderColor: const Color(0xffF0F0F0),
        markedDateIconBuilder: (event) {
          return Container();
        },
      ),
    );
  }
}

class CustomMultiDateCalendar extends StatefulWidget {
  final List<DateTime> selectedDates;
  final Function(List<DateTime> dates)? onDatesSelected;
  final DateTime? firstDay;
  final DateTime? lastDay;
  const CustomMultiDateCalendar({
    super.key,
    required this.selectedDates,
    this.onDatesSelected,
    this.firstDay,
    this.lastDay,
  });

  @override
  State<CustomMultiDateCalendar> createState() =>
      _CustomMultiDateCalendarState();
}

class _CustomMultiDateCalendarState extends State<CustomMultiDateCalendar> {
  late CalendarFormat _calendarFormat;
  late DateTime _focusedDay;

  late DateTime _selectedDay;
  late Map<DateTime, List> _events;
  // late CalendarController _calendarController;

  @override
  void initState() {
    super.initState();
    _calendarFormat = CalendarFormat.month;
    _focusedDay = DateTime.now();
    _selectedDay = DateTime.now();
    _events = {}; // Add your events here
    // _calendarController = CalendarController();
  }

  @override
  void dispose() {
    // _calendarController.dispose();
    super.dispose();
  }

  bool _checkSelected(DateTime date) {
    return widget.selectedDates
        .contains(DateTime(date.year, date.month, date.day));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(
        5,
      ),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              spreadRadius: 0,
              offset: Offset(0, 10),
              blurRadius: 30,
              color: Color(0xffF0F0F0),
            )
          ],
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xffF0F0F0), width: 1)),
      child: TableCalendar(
        // calendarController: _calendarController,
        focusedDay: _focusedDay,
        firstDay: widget.firstDay ??
            DateTime(2010), // Modify according to your requirements
        lastDay: widget.lastDay ??
            DateTime(DateTime.now().year, 12,
                31), // Modify according to your requirements
        calendarFormat: _calendarFormat,
        startingDayOfWeek: StartingDayOfWeek.sunday,
        headerStyle: const HeaderStyle(
          formatButtonVisible: false,
          titleTextStyle: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        calendarStyle: const CalendarStyle(
          selectedDecoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.blue,
          ),
          selectedTextStyle: TextStyle(color: Colors.white),
          todayTextStyle: TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.bold,
          ),
          rangeHighlightColor: Colors.red,
          markerSize: 6,
        ),
        daysOfWeekStyle: DaysOfWeekStyle(
          weekdayStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 18,
          ),
          weekendStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.red,
            fontSize: 18,
          ),
          decoration: BoxDecoration(
            // border: Border.all(color:  Colors.black),  // Add black border
            borderRadius: BorderRadius.circular(4.0),
          ),
          dowTextFormatter: (date, locale) {
            return DateFormat.E('en_US').format(date).substring(0, 1);
          },
        ),
        headerVisible: true, // Hide the header
        locale: 'en_US', // Set locale for English names
        daysOfWeekHeight: 40, // Adjust the height of the days of week container
        // daysOfWeekBuilder: (context, day) {
        //   final weekDays =
        //       DateFormat.E('en_US').format(day); // Get weekday names in English
        //   return Center(
        //     child: Text(
        //       weekDays.substring(
        //           0, 1), // Show only the first letter of weekday names
        //       style: TextStyle(
        //         fontWeight: FontWeight.bold,
        //         fontSize: 18,
        //       ),
        //     ),
        //   );
        // },
        calendarBuilders: CalendarBuilders(
          defaultBuilder: (context, date, events) {
            return Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 5.0, vertical: 8.0),
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(
                      color: _checkSelected(date)
                          ? ColorResources.primary
                          : Colors.black26), // Add black border
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Text(
                  '${date.day}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: _checkSelected(date)
                        ? ColorResources.primary
                        : Colors.black,
                  ),
                ),
              ),
            );
          },
        ),
        onFormatChanged: (format) {
          setState(() {
            _calendarFormat = format;
          });
        },
        onPageChanged: (focusedDay) {
          _focusedDay = focusedDay;
        },
        selectedDayPredicate: (date) {
          return widget.selectedDates.contains(date);
        },
        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            _selectedDay = selectedDay;
            // Handle your selected dates here in _selectedDay
            if (widget.selectedDates.contains(selectedDay)) {
              widget.selectedDates.remove(selectedDay);
            } else {
              widget.selectedDates.add(selectedDay);
            }

            if (widget.onDatesSelected != null) {
              widget.onDatesSelected!(widget.selectedDates);
            }
          });
        },
        availableCalendarFormats: const {
          // Set available formats to only month view
          CalendarFormat.month: 'Month',
        },
      ),
    );
  }
}
