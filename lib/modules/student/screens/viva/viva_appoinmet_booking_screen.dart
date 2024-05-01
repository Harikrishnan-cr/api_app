// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:samastha/core/app_constants.dart';
import 'package:samastha/helper/date_converter.dart';
import 'package:samastha/modules/dashboard/screens/dashbaord_screen.dart';
import 'package:samastha/modules/kids/modules/dashboard/screen/kids_dashboard_screen.dart';
import 'package:samastha/modules/student/bloc/viva_controller.dart';
import 'package:samastha/modules/student/models/time_slots_model.dart';
import 'package:samastha/theme/color_resources.dart';
import 'package:samastha/theme/t_style.dart';
import 'package:samastha/utils/error_reload.dart';
import 'package:samastha/utils/snackbar_utils.dart';
import 'package:samastha/widgets/app_bars_custom.dart';
import 'package:samastha/widgets/custom_calendar/custom_calender_carsoul.dart';
import 'package:samastha/widgets/custom_form_elements.dart';
import 'package:samastha/widgets/default_loading_widget.dart';

class AppointmentBookingScreen extends StatefulWidget {
  const AppointmentBookingScreen({super.key, required this.studentId});
  static const String path = '/appointment-booking-screen';
  final int studentId;

  @override
  State<AppointmentBookingScreen> createState() =>
      _AppointmentBookingScreenState();
}

class _AppointmentBookingScreenState extends State<AppointmentBookingScreen> {
  var _currentDate = DateTime.now();

  VivaController bloc = VivaController();

  Future<List<TimeSlotModel>>? future;

  TimeSlotModel? selectedSlot;

  DateTime? selectedDate;

  @override
  void initState() {
    fetchDates();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SimpleAppBar(title: 'Schedule your VIVA'),
      body: SingleChildScrollView(
        padding: pagePadding.copyWith(bottom: 20),
        child: Column(
          children: [
            CustomCalendarWidget(
              currentDate: _currentDate,
              onDayPressed: (date, events) {
                setState(() {
                  selectedDate = date;
                  selectedSlot = null;
                  future = bloc.fetchSlots(date, widget.studentId);
                });
              },
              calendarOnChange: (DateTime date) {
                setState(() {
                  selectedSlot = null;
                  _currentDate = date;
                });
                //call api
                fetchDates();
              },
              markedDatesMap: bloc.markedDateMap,
            ),
            const Gap(18),
            // if (future != null)
            FutureBuilder(
              future: future,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return errorReload(snapshot.error.toString(), onTap: () {
                    setState(() {
                      selectedSlot = null;
                      future = bloc.fetchSlots(_currentDate, widget.studentId);
                    });
                  });
                }

                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return const LoadingWidget();
                  case ConnectionState.done:
                    var data = snapshot.data ?? [];
                    String formattedString = '';
                    if (selectedDate != null) {
                      // Format the DateTime object to a string with the desired format

                      String formattedDay =
                          DateFormat('d').format(selectedDate!);
                      formattedString =
                          DateFormat('MMMM y, EEEE').format(selectedDate!);

                      // Manually add the "th" suffix to the day part
                      formattedString =
                          '$formattedDay${DateConverter.getDaySuffix(int.parse(formattedDay))} $formattedString';
                    }
                    return data.isEmpty
                        ? const Text("No slots avaiable for the day")
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Select Time',
                                style: titleLarge.darkBG,
                              ),
                              const Gap(25),
                              Wrap(
                                spacing: 10,
                                children: [
                                  for (var item in data)
                                    GestureDetector(
                                      onTap: () {
                                        selectedSlot = item;

                                        setState(() {});
                                      },
                                      child: Chip(
                                        padding: const EdgeInsets.all(1),
                                        backgroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            side: BorderSide(
                                                color: selectedSlot == (item)
                                                    ? ColorResources.primary
                                                    : ColorResources.darkBG,
                                                width: 1)),
                                        label: Text(
                                          '${item.startTime} - ${item.endTime}',
                                          style: selectedSlot == (item)
                                              ? titleSmall.primary
                                                  .copyWith(fontSize: 12)
                                              : titleSmall.darkBG
                                                  .copyWith(fontSize: 12),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                              const Gap(27),
                              if (selectedSlot != null) ...[
                                Text(
                                  'Selected Time',
                                  style: titleLarge.darkBG,
                                ),
                                const Gap(15),
                                if (selectedDate != null)
                                  Text(
                                    formattedString,
                                    // '16th January, Wednesday',
                                    style: titleLarge.primary,
                                  ),
                                const Gap(7),
                                Text(
                                  '${selectedSlot?.startTime ?? ""} - ${selectedSlot?.endTime ?? ""}',
                                  style: titleLarge.secondary,
                                ),
                                const Gap(38),
                                Text(
                                  'The viva will be a video call from the team. Please prepare for the call.',
                                  style: labelMedium.darkBG,
                                  textAlign: TextAlign.center,
                                ),
                                const Gap(35),
                                SubmitButton(
                                  'Schedule',
                                  onTap: (loader) async {
                                    //TODO - CHECK AFTER BEFORE
                                    if (selectedDate == null) {
                                      showErrorMessage('Select a date');
                                      return;
                                    }
                                    try {
                                      print(
                                          'timeslot : $selectedDate $selectedSlot - ${selectedSlot?.timeSlot} - ${selectedSlot?.timeSlot?.title}');
                                      if (bloc.isDatesSame(selectedDate)) {
                                        if (bloc.isSlotActive(
                                            selectedSlot!.timeSlot!.title!)) {
                                          _submitViva(loader);
                                        } else {
                                          showErrorMessage('Timeslot expired');
                                        }
                                      } else {
                                        if (bloc.isSlotActive(selectedSlot!
                                                .timeSlot!.title!) &&
                                            bloc.isDateActive(selectedDate!)) {
                                          _submitViva(loader);
                                        } else {
                                          showErrorMessage('Timeslot expired');
                                        }
                                      }
                                    } catch (e) {
                                      debugPrint('schedule viva : $e');
                                    }
                                  },
                                ),
                              ],
                              const Gap(22)
                            ],
                          );
                  default:
                    return Container();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  _submitViva(loader) async {
    try {
      loader();
      await bloc.submitSlotForViva(widget.studentId, selectedSlot!);
      loader();
      debugPrint('slot: ${selectedSlot?.id}, date: $selectedDate ');
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => VivaScheduledSuccessScreen(
                  selectedSlot: selectedSlot, selectedDate: selectedDate)));
    } catch (e) {
      loader(isLoading: false);
    }
  }

  fetchDates() async {
    await bloc.fetchDays(_currentDate, widget.studentId);
    future = bloc.fetchSlots(_currentDate, widget.studentId);
    setState(() {});
  }
}

class VivaScheduledSuccessScreen extends StatelessWidget {
  final TimeSlotModel? selectedSlot;
  final DateTime? selectedDate;
  const VivaScheduledSuccessScreen(
      {super.key, required this.selectedSlot, required this.selectedDate});

  @override
  Widget build(BuildContext context) {
    String formattedString = '';

    // Format the DateTime object to a string with the desired format

    String formattedDay =
        selectedDate != null ? DateFormat('d').format(selectedDate!) : '';
    formattedString = selectedDate != null
        ? DateFormat('MMMM y, EEEE').format(selectedDate!)
        : '';

    // Manually add the "th" suffix to the day part
    formattedString = formattedDay.isNotEmpty
        ? '$formattedDay${DateConverter.getDaySuffix(int.parse(formattedDay))} $formattedString'
        : '';
    return Scaffold(
      // appBar: const SimpleAppBar(title: 'Schedule your VIVA'),
      body: Padding(
        padding: pagePadding.copyWith(bottom: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
                flex: 2,
                child: Center(
                  child: Text(
                    "Successfully scheduled\nyour Viva",
                    style: titleLarge.primary,
                    textAlign: TextAlign.center,
                  ),
                )),
            const Gap(18),
            // if (future != null)
            if (selectedSlot != null) ...[
              Text(
                'Scheduled for',
                style: titleLarge.darkBG,
              ),
              const Gap(15),
              if (selectedDate != null)
                Text(
                  formattedString,
                  // '16th January, Wednesday',
                  style: titleLarge.primary,
                ),
              const Gap(7),
              Text(
                '${selectedSlot?.startTime ?? ""} - ${selectedSlot?.endTime ?? ""}',
                style: titleLarge.secondary,
              ),
              const Gap(35),
              SubmitButton(
                'Go Home',
                onTap: (loader) async {
                  if (AppConstants.loggedUser?.role == 'kid') {
                    Navigator.pushNamedAndRemoveUntil(
                        context, KidsDashboardScreen.path, (route) => false);
                  } else {
                    Navigator.pushNamedAndRemoveUntil(
                        context, DashboardScreen.path, (route) => false);
                  }
                  // Navigator.pushNamedAndRemoveUntil(
                  //     context, DashboardScreen.path, (route) => false);
                },
              ),
            ],
          ],
        ),
      ),
    );
  }
}
