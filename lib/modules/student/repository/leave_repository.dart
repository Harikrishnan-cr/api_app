import 'package:flutter/src/material/date.dart';
import 'package:samastha/core/isparent_loged_in_details.dart';
import 'package:samastha/core/urls.dart';
import 'package:samastha/helper/api_exception.dart';
import 'package:samastha/helper/dio_client.dart';
import 'package:samastha/helper/service_locator.dart' as di;
import 'package:samastha/modules/student/models/approved_leave_model.dart';
import 'package:samastha/modules/student/models/leave_request_model.dart';
import 'package:samastha/modules/student/models/leave_type_model.dart';
import 'package:samastha/modules/student/models/rescheduled_classes_model.dart';

class LeaveRepository {
  DioClient dioClient = di.sl<DioClient>();

  Future<List<LeaveTypeModel>> fetchLeaveTypes() async {
    try {
      final response = await dioClient.get(Urls.getLeaveTypes);

      return List.generate(
        response.data["data"].length,
        (index) => LeaveTypeModel.fromJson(response.data['data'][index]),
      );
    } catch (e) {
      return throw ApiException(e);
    }
  }

  Future<List<LeaveRequestModel>> fetchLeaveRequests() async {
    try {
      final response = await dioClient.post(Urls.getLeaveRequest);

      return List.generate(
        response.data["data"]['leaveRequest'].length,
        (index) => LeaveRequestModel.fromJson(
            response.data['data']['leaveRequest'][index]),
      );
    } catch (e) {
      return throw ApiException(e);
    }
  }

  Future<List<LeaveRequestModel>> fetchLeaveRequestsFromParentData() async {
    try {
      final response = await dioClient.post(Urls.getLeaveRequest,
          queryParameters: {
            'student_id': IsParentLogedInDetails.getStudebtID()
          });

      return List.generate(
        response.data["data"]['leaveRequest'].length,
        (index) => LeaveRequestModel.fromJson(
            response.data['data']['leaveRequest'][index]),
      );
    } catch (e) {
      return throw ApiException(e);
    }
  }

  Future<List<ApprovedLeaveRequestModel>> fetchApprovedLeaveRequests() async {
    try {
      final response = await dioClient.post(
        Urls.getApprovedLeaveRequest,
      );

      return List.generate(
        response.data["data"]['leaveRequest'].length,
        (index) => ApprovedLeaveRequestModel.fromJson(
            response.data['data']['leaveRequest'][index]),
      );
    } catch (e) {
      return throw ApiException(e);
    }
  }

  Future<List<ApprovedLeaveRequestModel>>
      fetchApprovedLeaveRequestsParentData() async {
    try {
      final response = await dioClient.post(Urls.getApprovedLeaveRequest,
          queryParameters: {
            'student_id': IsParentLogedInDetails.getStudebtID()
          });

      return List.generate(
        response.data["data"]['leaveRequest'].length,
        (index) => ApprovedLeaveRequestModel.fromJson(
            response.data['data']['leaveRequest'][index]),
      );
    } catch (e) {
      return throw ApiException(e);
    }
  }

  applyLeave(
      int? id, String numOfDays, DateTimeRange? leaveDate, String desc) async {
    try {
      final response = await dioClient.post(Urls.applyLeave, data: {
        "leave_type_id": id,
        "no_of_days": numOfDays,
        "leave_date": leaveDate?.start.toIso8601String(),
        "description": desc
      });
      return response.data['status'];
    } catch (e) {
      return throw ApiException(e);
    }
  }

  Future<RescheduledClassesJsonModel> rescheduledClasses(
      int studentId, int leaveId) async {
    try {
      final response = await dioClient.post(Urls.rescheduledClassesUrl,
          data: {"student_id": studentId, "leave_id": leaveId});
      return RescheduledClassesJsonModel.fromJson(response.data['data']);
    } catch (e) {
      print(e);
      throw ApiException(e);
    }
  }

  Future<RescheduleSubmitResponse> submitRescheduledClasses(
      int studentId, int leaveId, int timeSlotId, DateTime date) async {
    try {
      final response =
          await dioClient.post(Urls.submitRescheduledClassUrl, data: {
        "student_id": studentId,
        //  "batch_id" : bat,
        "date": [
          {"year": date.year, "day": date.day, "month": date.month}
        ]
      });

      return RescheduleSubmitResponse.fromJson(response.data);
    } catch (e) {
      throw ApiException(e);
    }
  }
}
