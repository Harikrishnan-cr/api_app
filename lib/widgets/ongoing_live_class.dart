import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:samastha/core/isparent_loged_in_details.dart';
import 'package:samastha/gen/assets.gen.dart';
import 'package:samastha/modules/madrasa/controller/live_class_controller.dart';
import 'package:samastha/theme/t_style.dart';
import 'package:samastha/widgets/default_loading_widget.dart';

class OngoingLiveClass extends StatefulWidget {
  const OngoingLiveClass({
    super.key,
  });

  @override
  State<OngoingLiveClass> createState() => _OngoingLiveClassState();
}

class _OngoingLiveClassState extends State<OngoingLiveClass> {
  @override
  void initState() {
    if (IsParentLogedInDetails.isParentLogedIn()) {
      Provider.of<LiveClassController>(context, listen: false)
          .getLiveClassDetails(
              studentID: IsParentLogedInDetails.getStudebtID(), isLoad: true);

      return;
    }
    Provider.of<LiveClassController>(context, listen: false)
        .getLiveClassDetails(isLoad: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LiveClassController>(builder: (context, controller, _) {
      return controller.isLoading
          ? Container(
              height: 100,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(9),
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 30,
                      offset: Offset(0, 10),
                      spreadRadius: 0,
                      color: Color(0xffF0F0F0),
                    )
                  ]),
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
              child: const LoadingWidget())
          : CupertinoButton(
              minSize: 0,
              onPressed: () async {
                controller.joinLiveClass(studentBatcName: '24B22A');
                // try {
                //   if (controller.liveClassModelFullData?.data?.data == null &&
                //       controller.liveClassModelFullData!.data!.data!.isEmpty) {
                //     return;
                //   }
                //   final url = Uri.parse(controller
                //           .liveClassModelFullData?.data?.data?.first.zoomLink ??
                //       '');

                //   if (await canLaunchUrl(url)) {
                //     await launchUrl(url);
                //   } else {
                //     SnackBarCustom.success(
                //         'Failed to launch zoom please try again after some time');
                //   }
                // } catch (e) {
                //   SnackBarCustom.success(
                //       'Failed to launch zoom please try again after some time');
                // }
              },
              padding: EdgeInsets.zero,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(9),
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 30,
                        offset: Offset(0, 10),
                        spreadRadius: 0,
                        color: Color(0xffF0F0F0),
                      )
                    ]),
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Assets.icon.live.image(height: 15),
                          const Gap(2),
                          Text(
                            "Ongoing Live class",
                            style: titleMedium.secondary,
                          ),
                          const Gap(1),
                          Text(
                            "click to join the ongoing live class",
                            style: labelMedium.darkBG,
                          ),
                        ],
                      ),
                    ),
                    Assets.svgs.rightarrow2.svg(),
                  ],
                ),
              ),
            );
    });
  }
}
