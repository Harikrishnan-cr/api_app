import 'package:flutter_svprogresshud/flutter_svprogresshud.dart';
import 'package:samastha/modules/madrasa/models/batch_lesson_model.dart';
import 'package:samastha/modules/madrasa/models/time_table_subjects_model.dart';
import 'package:samastha/modules/madrasa/repository/time_table_repository.dart';
import 'package:samastha/modules/student/models/academic_calender_model.dart';
import 'package:samastha/widgets/custom_calendar/event.dart';
import 'package:samastha/widgets/custom_calendar/event_list.dart';
import 'package:samastha/widgets/custom_snackbar.dart';

class TimeTableController {
  TimeTableRepository repository = TimeTableRepository();
  EventList<Event> markedDateMap = EventList<Event>(events: {});

  Future<void> fetchDays(List<DateTime> listDates) async {
    if (listDates.isNotEmpty) {
      try {
        SVProgressHUD.show(status: 'Loading dates');
        List<DateTime> list = listDates;
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
    } else {}
  }

  Future<List<TimeTableSubjectsModel>> fetchSubjects(
      {required int day, required int month, required int year}) async {
    try {
      return await repository.fetchSubjects(day: day, month: month, year: year);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<List<TimeTableSubjectsModel>> fetchSubjectsForParents(
      {required int day, required int month, required int year}) async {
    try {
      return await repository.fetchSubjectsParents(
          day: day, month: month, year: year);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<List<BatchLessonModel>> fetchBatchLessons(
      {required int batchLessonId, required String type}) async {
    try {
      return await repository.fetchBatchLessons(
          batchLessonId: batchLessonId, type: type);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<AcademicCalenderModel> academicCalendar(
      int year, int month, int day) async {
    try {
      return await repository.academicCalendar(year, month, day);
    } catch (e) {
      print('error : $e');
      return Future.error(e);
    }
  }
}
