import 'package:flutter_svprogresshud/flutter_svprogresshud.dart';
import 'package:intl/intl.dart';
import 'package:samastha/modules/student/models/missed_class/matching_schedules_model.dart';
import 'package:samastha/modules/student/models/missed_class/missed_class_schedule_response_model.dart';
import 'package:samastha/modules/student/repository/missed_class_repository.dart';
import 'package:samastha/utils/snackbar_utils.dart';
import 'package:samastha/widgets/custom_calendar/event.dart';
import 'package:samastha/widgets/custom_calendar/event_list.dart';
import 'package:samastha/widgets/custom_snackbar.dart';

class OneToOneController {
EventList<Event> markedDateMap = EventList<Event>(events: {});
MissedClassRepository repository = MissedClassRepository();

  fetchDays(List<DateTime> dateList) async {
    try {
      SVProgressHUD.show(status: 'Loading dates');
      List<DateTime> list = dateList;
      // await repository.fetchDates(date, studentId);
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

  Future<ScheduleDatum> fetchMatchingSchedules(
      int studentId, int missedClassId) async {
    try {
      return await repository.fetchMatchingSchedules(studentId, missedClassId);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<ScheduleMissedRespJsonModel> scheduleMissedClass(
     DateTime? scheduleDate, int batchId) async {
    try {
      var dateString = DateFormat("yyyy-MM-dd").format(scheduleDate!);
      return await repository.scheduleMissedClass(dateString, batchId);
    } catch (e) {
      print('error catch 2 $e');
      showErrorMessage(e.toString());
      return Future.error(e);
    }
  }

  Future<List<String>> fetchOneToOneList({bool? isComplete}) async {
    try {
      return [] ?? await repository.fetchOneToOneList(isComplete: isComplete);
    } catch (e) {
      return Future.error(e);
    }
  }
}