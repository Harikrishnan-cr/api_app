import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:samastha/core/isparent_loged_in_details.dart';
import 'package:samastha/core/urls.dart';
import 'package:samastha/helper/dio_client.dart';
import 'package:samastha/helper/service_locator.dart' as di;
import 'package:samastha/modules/madrasa/models/live_class_model.dart';
import 'package:zoom_allinonesdk/zoom_allinonesdk.dart';

class LiveClassController extends ChangeNotifier {
  final DioClient dioClient = di.sl<DioClient>();

  LiveClassController() {
    if (IsParentLogedInDetails.isParentLogedIn()) {
      getLiveClassDetails(studentID: IsParentLogedInDetails.getStudebtID());

      return;
    }
    getLiveClassDetails();
  }

  bool isLoading = false;
  bool isLiveClassActive = false;
  bool isZoomInitilized = false;
  bool isNotifime = true;
  bool isNotifimeLoading = false;

  LiveClassModel? liveClassModelFullData;

  DateTime get getZoomDateTime {
    log('~m date ${liveClassModelFullData?.data?.data?.first.zoomDate}');
    //return DateTime.now();
    return liveClassModelFullData?.data?.data?.first.zoomDate ?? DateTime.now();
  }

  String get getZoomTime {
    log('~m time ${liveClassModelFullData?.data?.data?.first.zoomTime}');
    // return '00:00:00';
    return liveClassModelFullData?.data?.data?.first.zoomTime ?? '00:00:00';
  }

  void getLiveClassDetails({int? studentID, bool? isLoad = false}) async {
    try {
      isLoading = true;

      if (!(isLoad ?? false)) {
        log('is loading callsed setstate');
        notifyListeners();
      }

      await dioClient
          .post(Urls.liveClassZoom,
              queryParameters:
                  studentID != null ? {"student_id": studentID} : null)
          .then((data) {
        liveClassModelFullData = liveClassModelFromJson(jsonEncode(data.data));

        if (liveClassModelFullData?.data?.data != null &&
            liveClassModelFullData!.data!.data!.isNotEmpty) {
          isLiveActive(liveClassModelFullData!);
          // isLiveClassActive = true;
          isLoading = false;
          notifyListeners();
          return;
        } else {
          liveClassModelFullData = null;
          isLoading = false;
          notifyListeners();
          log('live class is empty');
          return;
        }

        // isLoading = false;
        // notifyListeners();
      });
    } catch (e) {
      isLoading = false;
      notifyListeners();
    }
  }

  void isLiveActive(LiveClassModel liveOrUpcomModel) {
    isZoomInitilized = false;
    final activeDate = liveOrUpcomModel.data?.data?.first.zoomDate;
    // final activeTime = liveClassModelFullData?.data?.data?.first.zoomTime;
    DateTime currentDateTime = DateTime.now();

    String formattedDate = DateFormat('yyyy-MM-dd')
        .format(activeDate?.toLocal() ?? DateTime.now());

    DateTime zoomDateTime = DateTime.parse(
        '$formattedDate ${liveOrUpcomModel.data?.data?.first.zoomTime}');
    log('currnt date is ${currentDateTime} zoomdate is $zoomDateTime');
    if (currentDateTime.isAfter(zoomDateTime) ||
        currentDateTime.isAtSameMomentAs(zoomDateTime)) {
      log('current date time is ${currentDateTime}');
      isLiveClassActive = true;
      notifyListeners();
    } else {
      isLiveClassActive = false;
      notifyListeners();
      log('current date time is false            --------------------$currentDateTime');
    }
  }

  void joinLiveClass({required String studentBatcName}) {
    log('meeting id is ${liveClassModelFullData?.data?.data?.first.zoomID}');

    if (liveClassModelFullData?.data?.data?.first.zoomID == null) return;
    ZoomOptions zoomOptions = ZoomOptions(
      domain: "zoom.us",
      clientId: 'k2e4ByVlSRKmEFHCRJdpfg',
      clientSecert: 'XdhrMtfjCZtoMt0MmjS5OODIKDd1bkW0',
    );

    var meetingOptions = MeetingOptions(
        //  displayName: "YOUR_NAME",
        meetingId: liveClassModelFullData?.data?.data?.first.zoomID,
        meetingPassword: studentBatcName);

    var zoom = ZoomAllInOneSdk();
    isZoomInitilized = true;

    notifyListeners();
    zoom.initZoom(zoomOptions: zoomOptions).then((results) {
      if (results[0] == 0) {
        try {
          // isZoomInitilized = false;

          // notifyListeners();
          zoom.joinMeting(meetingOptions: meetingOptions).then((loginResult) {
            // if (loginResult) {
            //   isZoomInitilized = false;

            //   notifyListeners();

            //   return;
            // }

            // isZoomInitilized = false;

            // notifyListeners();
            log('login result of the meetimg $loginResult');
          });

          Future.delayed(Duration(seconds: 1)).whenComplete(() {
            log('duration seconds completed');
            isZoomInitilized = false;

            notifyListeners();
          });
        } catch (e) {
          log('login result of the meetimg $e');
          isZoomInitilized = false;

          notifyListeners();
        }
      }
    }).catchError((error) {
      isZoomInitilized = true;

      notifyListeners();
      print("[Error Generated] : " + error);
    });
  }

  void onNotifiyMechnages() {
    try {
      isNotifimeLoading = true;
      notifyListeners();

      Future.delayed(const Duration(milliseconds: 400)).whenComplete(() {
        isNotifime = false;
        isNotifimeLoading = false;

        notifyListeners();
      });
    } catch (e) {
      isNotifimeLoading = false;
      notifyListeners();
    }
  }
}
