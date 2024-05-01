import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'dio_exception_widget.dart';

class ErrorWidgetWithRetry extends StatelessWidget {
  const ErrorWidgetWithRetry({
    super.key,
    required this.error,
    required this.retry,
  });

  final Exception error;
  final VoidCallback retry;

  @override
  Widget build(BuildContext context) {
    Widget widget = Container();
    switch (error.runtimeType) {
      case DioException:
        widget = DioExceptionWidget(exception: error as DioException);
        break;
      default:
        widget = Center(
          child: Column(
            children: [
              Text(error.runtimeType.toString()),
              Text(error.toString()),
            ],
          ),
        );
    }
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            widget,
            TextButton(onPressed: retry, child: const Text("Retry")),
          ],
        ),
      ),
    );
  }
}
