import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:gap/gap.dart';
import 'package:samastha/gen/assets.gen.dart';
import 'package:samastha/modules/madrasa/controller/madrasa_controller.dart';
import 'package:samastha/modules/madrasa/models/usthad_model.dart';
import 'package:samastha/modules/student/screens/chat/chart_with_usthad.dart';
import 'package:samastha/theme/color_resources.dart';
import 'package:samastha/theme/dimensions.dart';
import 'package:samastha/theme/t_style.dart';
import 'package:samastha/utils/error_reload.dart';
import 'package:samastha/widgets/app_bars_custom.dart';
import 'package:samastha/widgets/custom_form_elements.dart';
import 'package:samastha/widgets/default_loading_widget.dart';

class UsthadDetailScreen extends StatefulWidget {
  const UsthadDetailScreen({super.key, required this.tutorId});
  static const String path = '/usthad-detail';

  final int tutorId;

  @override
  State<UsthadDetailScreen> createState() => _UsthadDetailScreenState();
}

class _UsthadDetailScreenState extends State<UsthadDetailScreen> {
  late Future<UsthadModel> future;

  MadrasaController bloc = MadrasaController();

  @override
  void initState() {
    future = bloc.fetchUsthadDetails(widget.tutorId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SimpleAppBar(title: 'Usthad details'),
      body: SafeArea(
        child: FutureBuilder<UsthadModel>(
            future: future,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return errorReload(snapshot.error.toString(), onTap: () {
                  setState(() {
                    future = bloc.fetchUsthadDetails(widget.tutorId);
                  });
                });
              }

              if (snapshot.hasData) {
                UsthadModel? data = snapshot.data;
                return SingleChildScrollView(
                  child: PaddedColumn(padding: pagePadding, children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.only(bottom: 20),
                      decoration: defaultDecoration,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    data?.photo == null
                                        ? CircleAvatar(
                                            backgroundColor:
                                                ColorResources.PLACEHOLDER,
                                            radius: 70 / 2,
                                            backgroundImage: AssetImage(
                                                Assets.image.ustadDetails.path),
                                          )
                                        : CircleAvatar(
                                            backgroundImage: Image.network(
                                              data!.photo!,
                                              loadingBuilder: (context, child,
                                                      loadingProgress) =>
                                                  const LoadingWidget(),
                                            ).image,
                                            radius: 70 / 2,
                                          ),

                                    // UserAvatar(
                                    //   path: data?.photo ?? "",
                                    //   size: 70,
                                    // ),

                                    // CircleAvatar(
                                    //   backgroundColor:
                                    //       ColorResources.PLACEHOLDER,
                                    //   radius: 70 / 2,
                                    //   backgroundImage: AssetImage(
                                    //       Assets.image.ustadDetails.path),
                                    // ),
                                    const Gap(23),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            data?.name ?? "",
                                            style: titleMedium.darkBG,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Text(
                                            data?.qualification ?? "",
                                            style: labelLarge.secondary,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                const Gap(18),
                                const Divider(),
                                const Gap(18),
                                Text(
                                  'About',
                                  style: titleSmall.secondary,
                                ),
                                const Gap(9),
                                Html(data: data?.about ?? ""),
                                // Text(
                                //   AppConstants.lorem,
                                //   style: bodyMedium.darkBG,
                                // ),
                                const Gap(21),
                                Text(
                                  'Qualifications',
                                  style: titleSmall.secondary,
                                ),
                                const Gap(9),
                                Text(
                                  data?.qualification ?? "",
                                  style: bodyMedium.darkBG,
                                ),
                                const Gap(21),
                                Text(
                                  'Experience',
                                  style: titleSmall.secondary,
                                ),
                                const Gap(9),
                                Html(data: data?.experience ?? "")
                              ],
                            ),
                          ),
                          const Divider(),
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, ChatWithUsthad.path);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Assets.svgs.chatUsthad.svg(),
                                const Gap(11),
                                Text(
                                  'Chat with Usthad',
                                  style: titleSmall.primary,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ]),
                );
              } else {
                return const LoadingWidget();
              }
            }),
      ),
    );
  }
}
