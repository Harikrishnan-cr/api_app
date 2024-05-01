import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:samastha/core/app_constants.dart';
import 'package:samastha/core/common_pdf_viewer.dart';
import 'package:samastha/core/sample.dart';
import 'package:samastha/core/web_view_common.dart';
import 'package:samastha/gen/assets.gen.dart';
import 'package:samastha/theme/dimensions.dart';
import 'package:samastha/theme/t_style.dart';
import 'package:samastha/widgets/custom_snackbar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NotesClassItem extends StatefulWidget {
  const NotesClassItem({
    super.key,
    required this.name,
    required this.id,
    this.url,
    this.title,
    this.isPurchased = true,
  });

  final String name;
  final String? url;
  final int id;
  final String? title;
  final bool isPurchased;

  @override
  State<NotesClassItem> createState() => _NotesClassItemState();
}

class _NotesClassItemState extends State<NotesClassItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.isPurchased
          ? () {
              log('url web is ${widget.url}');
              if (widget.url == null) {
                SnackBarCustom.success(
                    'Unable to load pdf please try again after some time');
              }
              Navigator.push(
                  AppConstants.globalNavigatorKey.currentContext!,
                  MaterialPageRoute(
                    builder: (context) => PdfViewerCommonScreen(
                        appTitle: widget.title ?? 'PDF', pdfUrl: widget.url!),
                  ));

              // Navigator.push(
              //     AppConstants.globalNavigatorKey.currentContext!,
              //     MaterialPageRoute(
              //       builder: (context) => WebViewScreen(
              //         controller: WebViewController()
              //           ..setJavaScriptMode(JavaScriptMode.unrestricted)
              //           ..setBackgroundColor(const Color(0xFFFFFFFF))
              //           ..loadRequest(Uri.parse(
              //               'https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy')),
              //         showAppbar: true,
              //         title: 'About',
              //       ),
              //     ));
              // launchUrl(Uri.parse(widget.url ?? ''));

              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) => PDFViewScreen(),
              //     ));
              // print('url $url');
              //  launchUrl(Uri.parse(url!),mode: LaunchMode.inAppWebView);
              //    getUrl(url!).then((value) {
              //   launchUrl(Uri.parse(value!),mode: LaunchMode.inAppWebView);
              // });
            }
          : null,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.only(bottom: 12),
            decoration: widget.isPurchased
                ? defaultDecoration
                : defaultDecoration.copyWith(
                    boxShadow: [],
                    color: const Color.fromRGBO(1, 1, 1, 0.2),
                  ),
            child: Row(
              children: [
                Assets.icon.pdf.image(height: 50),
                const Gap(16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.name,
                        style: titleSmall.grey1,
                      ),
                      const Gap(4),
                      Text(
                        widget.title ??
                            '', //'How To Pray Salah - step by step lessons',
                        style: bodyMedium.darkBG,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const Gap(4),
                    ],
                  ),
                )
              ],
            ),
          ),
          if (!widget.isPurchased)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Assets.icon.courseLock.image(color: Colors.white, height: 30)
              ],
            )
        ],
      ),
    );
  }
}

// class PDFViewScreen extends StatefulWidget {
//   @override
//   _PDFViewScreenState createState() => _PDFViewScreenState();
// }

// class _PDFViewScreenState extends State<PDFViewScreen> {
//   final Completer<WebViewController> _controller =
//       Completer<WebViewController>();

//   @override
//   void initState() {
//     super.initState();
//     // if (Platform.isAndroid) {
//     //   WebView.platform = SurfaceAndroidWebView();
//     // }
//   }

//   final String pdfUrl =
//       r'https://samastha-dev-storage.s3.ap-south-1.amazonaws.com/images/425/media-libraryHMhUnw?X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAVBUNEONALO242OOW%2F20240127%2Fap-south-1%2Fs3%2Faws4_request&X-Amz-Date=20240127T091833Z&X-Amz-SignedHeaders=host&X-Amz-Expires=1200&X-Amz-Signature=1d133ae82edfc3a8e1b455b9d2ecc5a6ea0a77a5a74a8df6a7213b2fb3d0ce4a.pdf';

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text('PDF Viewer'),
//         ),
//         body: Column(
//           children: [
//             Image.network(
//                 'https://samastha-dev-storage.s3.ap-south-1.amazonaws.com/images/425/media-libraryHMhUnw?X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAVBUNEONALO242OOW%2F20240127%2Fap-south-1%2Fs3%2Faws4_request&X-Amz-Date=20240127T105254Z&X-Amz-SignedHeaders=host&X-Amz-Expires=1200&X-Amz-Signature=b7896e246abf9c547313fe824ab9651fd673c62be25b43c59c99ba1319c0c079')
//           ],
//         ));
//   }

//   Future<void> _launchURL(String url) async {
//     if (await canLaunch(url)) {
//       await launch(url);
//     } else {
//       throw 'Could not launch $url';
//     }
//   }
// }

void finalsss() {
  // final conteoll = WebViewControlle;
}
