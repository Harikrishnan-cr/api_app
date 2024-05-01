// import 'package:flutter_calendar_carousel/classes/event.dart';
// import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:flutter_svprogresshud/flutter_svprogresshud.dart';
import 'package:samastha/modules/student/models/time_slots_model.dart';
import 'package:samastha/modules/student/models/viva_call_model.dart';
import 'package:samastha/modules/student/repository/viva_repository.dart';
import 'package:samastha/widgets/custom_calendar/event.dart';
import 'package:samastha/widgets/custom_calendar/event_list.dart';
import 'package:samastha/widgets/custom_snackbar.dart';

class VivaController {
  VivaRepository repository = VivaRepository();

  // List<DateTime> dates = [];

  EventList<Event> markedDateMap = EventList<Event>(events: {});

  fetchDays(DateTime date, int studentId) async {
    try {
      SVProgressHUD.show(status: 'Loading dates');
      List<DateTime> list = await repository.fetchDates(date, studentId);
      SVProgressHUD.dismiss();
      if (list.isNotEmpty) {
        markedDateMap.clear();
        for (var i = 0; i < list.length; i++) {
          markedDateMap.add(
              list[i],
              Event(
                date: list[i],
              ));
        }
      }
    } catch (e) {
      SVProgressHUD.dismiss();
      SnackBarCustom.success('Could not fetch dates retry! ${e.toString()}');
    }
  }

  Future<List<TimeSlotModel>> fetchSlots(
      DateTime currentDate, int studentId) async {
    try {
      return await repository.fetchSlots(currentDate, studentId);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future submitSlotForViva(int studentId, TimeSlotModel selectedSlot) async {
    try {
      return await repository.submitSlotForViva(studentId, selectedSlot);
    } catch (e) {
      SnackBarCustom.success(e.toString());
    }
  }

  Future<VivaCallModel?> vivaCall(int? studentId, vivaId) async {
    try {
      return await repository.vivaCall(studentId, vivaId);
    } catch (e) {
      rethrow;
    }
  }

  submitViva(int? studentId, int? vivaId) async {
    try {
      return await repository.submitViva(studentId, vivaId);
    } catch (e) {
      rethrow;
    }
  }
  

  bool isSlotActive(String timeSlot) {
    DateTime currentTime = DateTime.now();

    List<String> slotParts = timeSlot.split(':');
    int slotHour = int.parse(slotParts[0]);
    int slotMinute = int.parse(slotParts[1]);
    int slotSecond = int.parse(slotParts[2]);

    DateTime slotTime = DateTime(
      currentTime.year,
      currentTime.month,
      currentTime.day,
      slotHour,
      slotMinute,
      slotSecond,
    );

    return currentTime.isBefore(slotTime);
  }

  bool isDateActive(DateTime selectedDate) {
    DateTime currentDate = DateTime.now();

    DateTime currentWithoutTime =
        DateTime(currentDate.year, currentDate.month, currentDate.day);
    DateTime selectedWithoutTime =
        DateTime(selectedDate.year, selectedDate.month, selectedDate.day);

    return currentWithoutTime.isBefore(selectedWithoutTime);
  }

  bool isDatesSame(DateTime? selectedDate) {
    return DateTime(
            DateTime.now().year, DateTime.now().month, DateTime.now().day)
        .isAtSameMomentAs(selectedDate!);
  }
}
