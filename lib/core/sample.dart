import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class SampleClassScreen extends StatefulWidget {
  const SampleClassScreen({super.key});

  @override
  State<SampleClassScreen> createState() => _SampleClassScreenState();
}

class _SampleClassScreenState extends State<SampleClassScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('PDF'),
        ),
        body: Container(
          color: Colors.black,
          padding: const EdgeInsets.all(8),
          child: SfPdfViewer.network(
              'https://samastha-dev-storage.s3.ap-south-1.amazonaws.com/images/64/AcademicClass.pdf?X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAVBUNEONALO242OOW%2F20240307%2Fap-south-1%2Fs3%2Faws4_request&X-Amz-Date=20240307T065600Z&X-Amz-SignedHeaders=host&X-Amz-Expires=1200&X-Amz-Signature=d4c744b7f8c2c49869e8dc03536dd268f8ab24938fd07592bdf30a64e24ca7a3'),
        ));
  }
}
