import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:samastha/widgets/app_bars_custom.dart';
import 'package:samastha/widgets/default_loading_widget.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  const WebViewScreen({
    super.key,
    required this.controller,
    this.showAppbar = false,
    this.title,
  });

  final WebViewController controller;
  final bool showAppbar;
  final String? title;

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  bool isLoading = false;
  @override
  void initState() {
    widget.controller.setNavigationDelegate(
      NavigationDelegate(
        onPageFinished: (url) {
          setState(() {
            isLoading = false;
          });
          log('vvvvvvvvv on page finished is isloading : - $isLoading ----------- $url');
        },
        onPageStarted: (url) {
          setState(() {
            isLoading = true;
          });
          log('vvvvvvvvv on page started is isloading : - $isLoading ----------- $url');
        },
        onProgress: (progress) {
          // log('vvvvvvvvv on page started is progress ---------------------------------- $progress');
        },
        onWebResourceError: (error) {
          log('vvvvvvvvv on page started is eeeeeeeee ---------------------------------- ${error.description.split('::').last}');

          if (error.description.split('::').last ==
              'ERR_INTERNET_DISCONNECTED') {
          } else {}
        },
        onNavigationRequest: (NavigationRequest request) {
          if (request.url.startsWith('https://www.google.com/')) {
            ///final uri = Uri.parse(request.url);

            // log('userweb is ${uri.queryParameters['redirectResult']}');

            // Handle navigation based on redirectResult if needed
            // (e.g., Navigator.pop(context, uri.queryParameters['redirectResult']))
          }

          return NavigationDecision.navigate;
        },
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: widget.showAppbar
          ? SimpleAppBar(
              title: widget.title ?? '',
              iconColor: Colors.black,
              leadingWidget: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const IconButton(
                  onPressed: null,
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                ),
              ))
          : null,
      body: SafeArea(
        child: isLoading
            ? const LoadingWidget()
            : WebViewWidget(
                controller: widget.controller,
              ),
      ),
    );
  }
}
