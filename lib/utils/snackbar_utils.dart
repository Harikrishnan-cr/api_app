import 'package:flutter/material.dart';
import 'package:samastha/core/app_constants.dart';


void showErrorMessage(String message) {
  ScaffoldMessenger.of(AppConstants. globalNavigatorKey.currentState!.context)
      .showSnackBar(SnackBar(content: Text(message)));
}
