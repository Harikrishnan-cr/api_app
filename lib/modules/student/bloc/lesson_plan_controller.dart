import 'package:flutter_svprogresshud/flutter_svprogresshud.dart';
import 'package:samastha/modules/student/models/academic_calender_model.dart';
import 'package:samastha/modules/student/repository/lesson_plan_repository.dart';
import 'package:samastha/widgets/custom_calendar/event.dart';
import 'package:samastha/widgets/custom_calendar/event_list.dart';
import 'package:samastha/widgets/custom_snackbar.dart';

class LessonPlanController {
  LessonPlanRepository repository = LessonPlanRepository();

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

  Future<AcademicCalenderModel> academicCalendar(int year, int month) async {
    try {
      return await repository.academicCalendar(year, month);
    } catch (e) {
      print('error : $e');
      return Future.error(e);
    }
  }

  Future<AcademicCalenderModel> academicCalendarForParent(
      int year, int month) async {
    try {
      return await repository.academicCalendarForParent(year, month);
    } catch (e) {
      print('error : $e');
      return Future.error(e);
    }
  }
}
