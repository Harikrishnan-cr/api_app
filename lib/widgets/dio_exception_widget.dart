
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DioExceptionWidget extends StatelessWidget {
  const DioExceptionWidget({
    super.key,
    required this.exception,
  });

  final DioException exception;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Icon(
            Icons.error_outline,
            size: 48,
            color: Colors.red,
          ),
          const SizedBox(height: 16),
          const Text(
            'Oops! An error occurred.',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'Please check your network connection and try again.',
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
          if (kDebugMode)
            Column(
              children: [
                Text((exception).message.toString()),
                Text((exception).requestOptions.uri.toString()),
                Text((exception).requestOptions.data.toString()),
                Text(((exception).response?.data).toString()),
              ],
            ),
        ],
      ),
    );
  }
}
