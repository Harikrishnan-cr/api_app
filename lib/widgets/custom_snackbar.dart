import 'package:flutter/material.dart';
import 'package:samastha/core/app_constants.dart';

class SnackBarCustom {
  static void success(String string) {
    ScaffoldMessenger.of(AppConstants.globalNavigatorKey.currentContext!)
        .showSnackBar(SnackBar(
            content: Text(
      string,
      maxLines: 2,
      overflow: TextOverflow.fade,
    )));
  }
}
