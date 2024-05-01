import 'dart:developer';
import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';

import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:samastha/gen/assets.gen.dart';
import 'package:samastha/theme/t_style.dart';
import 'package:samastha/widgets/app_bars_custom.dart';
import 'package:samastha/widgets/custom_form_elements.dart';
import 'package:samastha/widgets/custom_snackbar.dart';
import 'package:samastha/widgets/default_loading_widget.dart';
// import 'package:webcontent_converter/webcontent_converter.dart';

import 'package:webview_flutter/webview_flutter.dart';

class CertificateDetailScreen extends StatefulWidget {
  const CertificateDetailScreen({super.key, required this.certificateUrl});
  static const String path = '/certificate';

  final String certificateUrl;

  @override
  State<CertificateDetailScreen> createState() =>
      _CertificateDetailScreenState();
}

class _CertificateDetailScreenState extends State<CertificateDetailScreen> {
  late WebViewController controller;
  bool isLoading = false;

  bool isCertificateDownloadLoading = false;
  @override
  void initState() {
    setState(() {
      isLoading = true;
    });

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0xFFFFFFFF))
      ..loadRequest(Uri.parse(widget.certificateUrl));

    controller.enableZoom(false);

    controller.setNavigationDelegate(NavigationDelegate(
      onPageFinished: (url) {
        setState(() {
          isLoading = false;
        });
        log('vvvvvvvvv on page  finished is isloading : - $isLoading ----------- $url');
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

        if (error.description.split('::').last == 'ERR_INTERNET_DISCONNECTED') {
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
    ));
    // WebViewWidget(
    //   controller: WebViewController()
    //     ..setJavaScriptMode(JavaScriptMode.unrestricted)
    //     ..setBackgroundColor(const Color(0xFFFFFFFF))
    //     ..loadRequest(
    //         Uri.parse('https://test.samastha.lilacinfotech.com/certificate/6')),
    // );
    // controller: WebViewController()
    //             ..setJavaScriptMode(JavaScriptMode.unrestricted)
    //             ..setBackgroundColor(const Color(0xFFFFFFFF))
    //             ..loadRequest(
    //                 Uri.parse('${getEnvironment().domainUrl}/#about')),
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SimpleAppBar(title: 'Certificate'),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 91),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Assets.image.certificateDummy
              //     .image(width: double.infinity, fit: BoxFit.cover),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Container(
                  clipBehavior: Clip.antiAlias,
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.28,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white),
                  child: isLoading
                      ? const Center(
                          child: LoadingWidget(),
                        )
                      : WebViewWidget(
                          controller: controller,
                          // ignore: prefer_collection_literals
                          gestureRecognizers: Set()
                            ..add(Factory<VerticalDragGestureRecognizer>(
                                () => VerticalDragGestureRecognizer())),
                        ),
                ),
              ),
              const Gap(5),
              Padding(
                  padding: pagePadding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Certificate verification link',
                        style: titleSmall.darkBG,
                      ),
                      const Gap(16),
                      CupertinoButton(
                        onPressed: () async {
                          // if (model?.applicationNumber != null) {
                          await Clipboard.setData(
                            ClipboardData(text: widget.certificateUrl),
                          );
                          SnackBarCustom.success('Copied to clipboard');
                          //}
                        },
                        minSize: 0,
                        padding: EdgeInsets.zero,
                        child: TextFieldCustom(
                          initialValue:
                              // widget.certificateUrl ??
                              'samasthaelearning.com/153413235422',
                          isEnabled: false,
                          suffix: Padding(
                            padding: EdgeInsets.zero,
                            child: Assets.svgs.share2.svg(),
                          ),
                        ),
                      ),
                    ],
                  )),
              isCertificateDownloadLoading
                  ? const LoadingWidget()
                  : CupertinoButton(
                      onPressed: () async {
                        final DeviceInfoPlugin info = DeviceInfoPlugin();
                        final AndroidDeviceInfo androidInfo =
                            await info.androidInfo;
                        debugPrint(
                            'releaseVersion : ${androidInfo.version.release}');
                        final int androidVersion =
                            int.parse(androidInfo.version.release);
                        bool havePermission = false;

                        if (androidVersion >= 13) {
                          final request = await [
                            Permission.videos,
                            Permission.photos,
                            //..... as needed
                          ].request(); //import 'package:permission_handler/permission_handler.dart';
                          Permission.manageExternalStorage.request();
                          havePermission = request.values.every(
                              (status) => status == PermissionStatus.granted);
                        } else {
                          final status = await Permission.storage.request();
                          havePermission = status.isGranted;
                        }

                        if (!havePermission) {
                          // if no permission then open app-setting
                          await openAppSettings();
                        }

                        // return havePermission;

                        // var status = await Permission.storage.status;

                        // await Permission.storage.request().then((value) {
                        //   log('the permission $value');
                        // });

                        // if (status.isPermanentlyDenied) {
                        //   log('permentaly denied');
                        // }

                        // if (status.isDenied) {
                        //   try {
                        //     await Permission.storage.request().then((value) {
                        //       log('the permission $value');
                        //     });
                        //   } catch (e) {
                        //     log('permiison error is $e');
                        //   }
                        //   return;
                        // }

                        // var status = await Permission.storage.status;
                        // if (status.isRestricted) {
                        //   await Permission.storage.request();
                        //   log('permisoo requsted');
                        // } else {
                        //   await Permission.storage.request().then((value) {
                        //     log('permisss appoved');
                        //   });
                        //   log('permisoom ------denaid');
                        // }

                        Directory directory =
                            Directory('/storage/emulated/0/samastha/');
                        if (!(await directory.exists())) {
                          await directory.create(recursive: true).then((value) {
                            log('value is directory data $value');
                          });
                        } else {
                          log('ther is directory value data');
                        }

                        // var dir = await getExternalCacheDirectories(
                        //     //type: StorageDirectory.dcim

                        //     );

                        // final data = dir?.first.path;
                        // log('file path   $data     is${dir?.first.toString().split(':').last.toString().trim()}');

                        //if(dir?.path == null) return;

                        // log('file path is ${dir?.path}');

                        // final newPath = convertFilePath(dir!.path);

                        // log('file new new path is ${dir?.first.path}');

                        // String? downloadDirectoryPath =
                        //     await getDownloadDirectoryPath();
                        // if (downloadDirectoryPath != null) {
                        //   log('Downloads folder path: $downloadDirectoryPath');
                        // } else {
                        //   log('Failed to retrieve downloads folder path.');
                        //   return;
                        // }

                        // String? downloadDirectoryPath =
                        //     await getDownloadDirectoryPath();
                        // if (downloadDirectoryPath != null) {
                        //   log('~~M Downloads folder path: $downloadDirectoryPath');
                        // } else {
                        //   log('~~M Failed to retrieve downloads folder path.');
                        // }

                        // bool success = await openDownloadFolder();
                        // if (success) {
                        //   log('~~M Download folder opened successfully.');
                        // } else {
                        //   log('~~M Failed to open download folder.');
                        // }

                        //  / initDownloadsDirectoryPath();
                        // var savedPath = join(dir.path, "sample.pdf");

                        // try {
                        //   setState(() {
                        //     isCertificateDownloadLoading = true;
                        //   });
                        //   final String idNumberis =
                        //       widget.certificateUrl.split('certificate/').last;
                        //   var result = await WebcontentConverter.webUriToPdf(
                        //     uri: widget.certificateUrl,
                        //     savedPath:
                        //         '${directory.path}/samastha$idNumberis.pdf',
                        //     format: PaperFormat.a4,
                        //     margins: PdfMargins.px(
                        //         top: 35, bottom: 35, right: 35, left: 35),
                        //   ).whenComplete(() {
                        //     setState(() {
                        //       isCertificateDownloadLoading = false;
                        //     });
                        //     SnackBarCustom.success(
                        //         'certificate downloaded successfully');
                        //   });

                        //   log('final result is $result');
                        // } catch (e) {
                        //   SnackBarCustom.success(e.toString());
                        //   setState(() {
                        //     isCertificateDownloadLoading = false;
                        //   });
                        // }
                      },
                      minSize: 0,
                      padding: EdgeInsets.zero,
                      child: Center(
                        child: Container(
                          padding: const EdgeInsets.all(17),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: const Color(0xff0BAA56),
                              boxShadow: const [
                                BoxShadow(
                                    blurRadius: 30,
                                    spreadRadius: 0,
                                    offset: Offset(0, 10),
                                    color: Color(0xffF0F0F0))
                              ]),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Assets.image.downloadWhite.image(height: 16),
                              const Gap(6),
                              Text(
                                'Download Certificate',
                                style: titleSmall.white,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> ensureDirectoryExists(String path) async {
  Directory directory = Directory(path);
  if (!(await directory.exists())) {
    await directory.create(recursive: true).then((value) {
      log('value is directory data $value');
    });
  } else {
    log('ther is directory value data');
  }
}

String convertFilePath(String originalPath) {
  // Split the original path into segments
  List<String> pathSegments = originalPath.split('/');

  // Find the index of the segment that contains "Android"
  int androidIndex = pathSegments.indexOf("Android");

  // Remove segments after the "Android" segment
  if (androidIndex != -1) {
    pathSegments.removeRange(androidIndex, pathSegments.length);
  }

  // Join the remaining segments to build the new path
  String newPath = pathSegments.join();

  return newPath;
}
