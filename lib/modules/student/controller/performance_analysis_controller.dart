import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:samastha/core/urls.dart';
import 'package:samastha/helper/dio_client.dart';
import 'package:samastha/helper/service_locator.dart' as di;
import 'package:samastha/modules/student/models/performance_model_class.dart';
import 'package:samastha/modules/student/screens/performance_score.dart';
import 'package:screenshot/screenshot.dart';
import 'package:social_share/social_share.dart';

class PerformanceAmalysisProvider extends ChangeNotifier {
  final DioClient dioClient = di.sl<DioClient>();

  // PerformanceAmalysisProvider() {
  //   getAllPerformanceData();
  // }

  bool isLoading = false;

  PerformanceModelClass? performanceData;

  List<ChartData> chartData = [];

  List<String> abbreviatedMonthsList = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];

  void onChartDataAdded() {
    chartData.clear();
    for (int i = 0; i < (performanceData?.data?.overall?.length ?? 0); i++) {
      chartData.add(ChartData(
          (abbreviatedMonthsList[i]),
          double.parse(
              (performanceData?.data?.overall?[i].toString() ?? '0.0'))));
    }

    // notifyListeners();
  }

  bool isScreenshotTaking = false;
  static final ScreenshotController screenshotController =
      ScreenshotController();
  void shareScreenShot() async {
    try {
      isScreenshotTaking = true;

      var data = await screenshotController.capture();

      isScreenshotTaking = false;

      if (data == null) {
        return;
      }
      final tempDir = await getTemporaryDirectory();
      final assetPath = '${tempDir.path}/temp.png';
      File file = await File(assetPath).create();
      await file.writeAsBytes(data);
      SocialShare.shareOptions('', imagePath: file.path);
    } catch (e) {
      debugPrint('share error : $e');
    }
  }

  void getAllPerformanceData({int? studentID}) async {
    try {
      isLoading = true;
      //notifyListeners();
      await dioClient
          .post(Urls.performnaceAnalysis,
              queryParameters:
                  studentID != null ? {"student_id": studentID} : null)
          .then((data) {
        performanceData = performanceModelClassFromJson(jsonEncode(data.data));

        // if (pageMode == PageMode.batchWise) {
        //   globalandBatchStudentList.addAll(responce.data?.batchStudents ?? []);
        // } else {
        //   globalandBatchStudentList.addAll(responce.data?.globalStudents ?? []);
        // }

        isLoading = false;
        notifyListeners();
      });
    } catch (e) {
      isLoading = false;
      notifyListeners();
    }
  }
}
