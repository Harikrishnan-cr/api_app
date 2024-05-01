import 'package:flutter/material.dart';
import 'package:flutter_svprogresshud/flutter_svprogresshud.dart';
import 'package:samastha/modules/student/models/approved_leave_model.dart';
import 'package:samastha/modules/student/models/leave_request_model.dart';
import 'package:samastha/modules/student/models/leave_type_model.dart';
import 'package:samastha/modules/student/models/rescheduled_classes_model.dart';
import 'package:samastha/modules/student/repository/leave_repository.dart';
import 'package:samastha/widgets/custom_calendar/event.dart';
import 'package:samastha/widgets/custom_calendar/event_list.dart';
import 'package:samastha/widgets/custom_snackbar.dart';

class LeaveController {
  LeaveRepository repository = LeaveRepository();
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

  Future<List<LeaveTypeModel>> fetchLeaveTypes() async {
    try {
      return await repository.fetchLeaveTypes();
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<List<LeaveRequestModel>> fetchLeaveRequest() async {
    try {
      return await repository.fetchLeaveRequests();
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<List<LeaveRequestModel>> fetchLeaveRequestfromParent() async {
    try {
      return await repository.fetchLeaveRequestsFromParentData();
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<List<ApprovedLeaveRequestModel>> fetchApprovedLeaveRequest() async {
    try {
      return await repository.fetchApprovedLeaveRequests();
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<List<ApprovedLeaveRequestModel>>
      fetchApprovedLeaveRequestfromParent() async {
    try {
      return await repository.fetchApprovedLeaveRequestsParentData();
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<RescheduledClassesJsonModel> rescheduledClasses(
      int studentId, int leaveId) async {
    try {
      return await repository.rescheduledClasses(studentId, leaveId);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<RescheduleSubmitResponse> submitRescheduledClass(
      int studentId, int leaveId, int timeSlotId, DateTime date) async {
    try {
      return await repository.submitRescheduledClasses(
          studentId, leaveId, timeSlotId, date);
    } catch (e) {
      return Future.error(e);
    }
  }

  applyLeave(LeaveTypeModel? selectedLeaveReason, String numOfDays,
      DateTimeRange? leaveDate, String desc) async {
    try {
      return await repository.applyLeave(
          selectedLeaveReason?.id, numOfDays, leaveDate, desc);
    } catch (e) {
      SnackBarCustom.success(e.toString());
      return false;
    }
  }
}
