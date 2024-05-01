import 'package:flutter/material.dart';
import 'package:samastha/theme/color_resources.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfViewerCommonScreen extends StatelessWidget {
  const PdfViewerCommonScreen(
      {super.key, required this.appTitle, required this.pdfUrl});

  final String pdfUrl;

  final String appTitle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            appTitle,
            style: const TextStyle(
                color: ColorResources.WHITE, fontWeight: FontWeight.bold),
          ),
        ),
        body: Container(
          color: Colors.black,
          padding: const EdgeInsets.all(8),
          child: SfPdfViewer.network(pdfUrl),
        ));
  }
}
