// import 'package:flutter/material.dart';
// import 'package:pdf/widgets.dart' as pw;


// class PdfNetwork extends StatelessWidget {
//   const PdfNetwork({super.key, required this.pdfUrl});
//   final String pdfUrl;
//   final netImage = await networkImage('https://www.nfet.net/nfet.jpg');
//   final pdf = pw.Document();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: pdf.addPage(pw.Page(build: (pw.Context context) {
//   return pw.Center(
//     child: pw.Image(netImage),
//   ); // Center
// })),
//     );
//   }
// }