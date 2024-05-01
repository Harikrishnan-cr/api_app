import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:samastha/core/isparent_loged_in_details.dart';
import 'package:samastha/core/urls.dart';
import 'package:samastha/helper/dio_client.dart';
import 'package:samastha/helper/service_locator.dart' as di;
import 'package:samastha/modules/student/models/leader_board_model.dart';

class LeaderBoardProvider extends ChangeNotifier {
  final DioClient dioClient = di.sl<DioClient>();

  LeaderBoardProvider() {
    if (IsParentLogedInDetails.isParentLogedIn()) {
      getLeaderBoardData(studentID: IsParentLogedInDetails.getStudebtID());

      return;
    }
    getLeaderBoardData();
  }

  bool isLoading = false;

  PageMode pageMode = PageMode.batchWise;

  List<LeaderBoardStudnetList> globalandBatchStudentList = [];
  List<LeaderBoardStudnetList> globalandBatchStudentListFrom4thPosition = [];
  // List<LeaderBoardStudnetList> batchStudentList = [];

  void onPageModeChnages({required PageMode pageMode}) {
    this.pageMode = pageMode;
    notifyListeners();
  }

  void getLeaderBoardData({int? studentID}) async {
    // log('page mode is  ${pageMode.name}');
    globalandBatchStudentList.clear();
    globalandBatchStudentListFrom4thPosition.clear();
    // batchStudentList.clear();
    try {
      isLoading = true;
      notifyListeners();
      await dioClient
          .post(Urls.leaderBoard,
              queryParameters:
                  studentID != null ? {"student_id": studentID} : null)
          .then((data) {
        final responce = leaderBoardModelFromJson(jsonEncode(data.data));

        if (pageMode == PageMode.batchWise) {
          globalandBatchStudentList.addAll(responce.data?.batchStudents ?? []);
        } else {
          globalandBatchStudentList.addAll(responce.data?.globalStudents ?? []);
        }

        if (globalandBatchStudentList.length > 3) {
          globalandBatchStudentListFrom4thPosition =
              globalandBatchStudentList.sublist(3);
        }

        isLoading = false;
        notifyListeners();
      });
    } catch (e) {
      isLoading = false;
      notifyListeners();
    }
  }
}

enum PageMode { batchWise, global }
