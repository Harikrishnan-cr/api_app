import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
// import 'package:samastha/helper/dio_client.dart';
// import 'package:samastha/helper/service_locator.dart' as di;

class VideoSpeedProvider extends ChangeNotifier {
  // final DioClient dioClient = di.sl<DioClient>();

  List<double> videoSpeed = [0.5, 1.0, 2.0, 3.0, 4.0, 5.0];

  double currentSpeed = 1.0;

  int currentIndex = 1;

  void onCurrentSpeedUpdate() {
    if (currentIndex < videoSpeed.length - 1) {
      currentIndex++;
    } else {
      currentIndex = 0;
    }

    currentSpeed = videoSpeed[currentIndex];
    notifyListeners();
  }

  void makeCurrentSpeedDefault({FlickControlManager? flickmanager}) async {
    currentSpeed = 1.0;
    currentIndex = 1;
    await flickmanager?.setPlaybackSpeed(1.0);
    notifyListeners();
  }
}
