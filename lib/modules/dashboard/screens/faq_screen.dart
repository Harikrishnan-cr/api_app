import 'dart:developer';

import 'package:animate_icons/animate_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_faq/flutter_faq.dart';
import 'package:provider/provider.dart';
import 'package:samastha/modules/dashboard/controller/faq_screen_conroller.dart';
import 'package:samastha/widgets/app_bars_custom.dart';

class FaqScreen extends StatelessWidget {
  const FaqScreen({super.key});
  static const String path = '/faq-screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const SimpleAppBar(title: 'FAQ'),
        body: Consumer<FaqScreenController>(builder: (context, controller, _) {
          return ListView(
              children: List.generate(dummyFaq.length, (index) {
            return CustumFaqTile(
              
            );

            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Container(
            //     decoration:
            //         BoxDecoration(borderRadius: BorderRadius.circular(15)),
            //     child: ExpansionPanelList(
            //       expansionCallback: (panelIndex, isExpanded) {
            //         controller.onIsExpanded(dummyFaq[index].id);
            //       },
            //       elevation: 1,
            //       expandedHeaderPadding: EdgeInsets.all(0),
            //       animationDuration: Duration(milliseconds: 500),
            //       children: [
            //         ExpansionPanel(
            //           canTapOnHeader: true,
            //           headerBuilder: (BuildContext context, bool isExpanded) {
            //             return ListTile(
            //               title: Text(dummyFaq[index].tittle),
            //             );
            //           },
            //           body: ListTile(
            //             title: Text(dummyFaq[index].discription),
            //           ),
            //           isExpanded: controller.isExpandedList
            //               .contains(dummyFaq[index].id),
            //         ),
            //       ],
            //     ),
            //   ),
            // );
          }));
        })

        // FutureBuilder<List<FaqModel>>(

        // // future: controller.getFaqs(),
        //   future: Future.delayed(Duration(seconds: 0)),
        //   builder: (context, snapshot) {
        //     if (snapshot.hasError) {
        //       return Padding(
        //         padding: const EdgeInsets.all(16.0),
        //         child: Center(
        //           child: Text(snapshot.error.toString()),
        //         ),
        //       );
        //     } else if (!snapshot.hasData) {
        //       return const Center(
        //         child: CircularProgressIndicator(
        //             // color: AppColors.warningRed,
        //             ),
        //       );
        //     }
        //     return SingleChildScrollView(
        //       child: ListView.builder(
        //         physics: const NeverScrollableScrollPhysics(),
        //         shrinkWrap: true,
        //         padding: const EdgeInsets.all(16),
        //         itemCount: snapshot.data?.length,
        //         itemBuilder: (context, index) {
        //           return Column(
        //             crossAxisAlignment: CrossAxisAlignment.start,
        //             children: [
        //               Theme(
        //                 data: Theme.of(context).copyWith(
        //                   dividerColor: Colors.transparent,
        //                 ),
        //                 child: ExpansionTile(
        //                   tilePadding: EdgeInsets.zero,
        //                   childrenPadding: EdgeInsets.zero,
        //                   title: Text(
        //                     snapshot.data![index].question,
        //                     style:
        //                         Theme.of(context).textTheme.bodyLarge!.copyWith(
        //                               // color: AppColors.secondaryBlue,
        //                               fontSize: 18,
        //                               fontWeight: FontWeight.w700,
        //                             ),
        //                   ),
        //                   children: [
        //                     Align(
        //                       alignment: Alignment.centerLeft,
        //                       child: Text(
        //                         snapshot.data![index].answer,
        //                         // style: Theme.of(context)
        //                         //     .textTheme
        //                         //     .bodyLarge!
        //                         //     .secondaryBlack,
        //                         textAlign: TextAlign.start,
        //                       ),
        //                     ),
        //                   ],
        //                 ),
        //               ),
        //             ],
        //           );
        //         },
        //       ),
        //     );
        //   },
        // ),
        );
  }
}

// Widget custumFaqTile() {
//   return Container(

//   );
// }





class CustumFaqTile extends StatefulWidget {
  const CustumFaqTile({super.key});

  @override
  State<CustumFaqTile> createState() => _CustumFaqTileState();
}

class _CustumFaqTileState extends State<CustumFaqTile> {
  double height = 72.0;
  late AnimateIconController animatedController;

  bool onEnd = false;
  bool onStart = false;

  @override
  void initState() {
    animatedController = AnimateIconController();
    super.initState();
  }

  bool onEndIconPress(BuildContext context) {
    onHeightChnages();
    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(
    //     content: Text("onEndIconPress called"),
    //     duration: Duration(seconds: 1),
    //   ),
    // );
    return true;
  }

  bool onStartIconPress(BuildContext context) {
    onHeightChnages();
    // onHeightChnages();
    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(
    //     content: Text("onStartIconPress called"),
    //     duration: Duration(seconds: 1),
    //   ),
    // );
    return true;
  }

  void onHeightChnages() {
    if (height > 72) {
      setState(() {
        height = 72;
      });

      return;
    }
    setState(() {
      height = 200;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AnimatedContainer(
        color: Colors.amber,
        height: height,
        duration: const Duration(milliseconds: 500),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                AnimateIcons(
                  duration: const Duration(milliseconds: 500),
                  startIcon: Icons.keyboard_arrow_up,
                  endIconColor: Colors.black,
                  startIconColor: Colors.black,
                  endIcon: Icons.keyboard_arrow_down,
                  controller: animatedController,
                  size: 40.0,
                  onEndIconPress: () => onEndIconPress(context),
                  onStartIconPress: () => onStartIconPress(context),
                )
              ],
            ),
            const Expanded(
                child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                  'In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content. Lorem ipsum may be used as a placeholder before the final copy is available.'),
            ))
          ],
        ),
      ),
    );
  }
}
