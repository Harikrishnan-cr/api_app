import 'package:flutter/material.dart';

import 'default_loading_widget.dart';
import 'error_widget_with_retry.dart';
import '../core/app_error.dart';

class NetworkResource extends StatelessWidget {
  const NetworkResource({
    super.key,
    required this.builder,
    required this.isLoading,
    this.loadingWidget,
    required this.error,
    required this.retry,
  });

  final WidgetBuilder builder;
  final bool isLoading;
  final AppError? error;
  final Widget? loadingWidget;
  final VoidCallback retry;

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? loadingWidget ?? const LoadingWidget()
        : error != null
            ? ErrorWidgetWithRetry(error: error!.exception!, retry: retry)
            : builder(context);
  }
}
