import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:samastha/gen/assets.gen.dart';
import 'package:samastha/modules/parent/controller/certificate_controller.dart';
import 'package:samastha/modules/parent/screens/certificate_detail_screen.dart';
import 'package:samastha/theme/color_resources.dart';
import 'package:samastha/theme/dimensions.dart';
import 'package:samastha/theme/t_style.dart';
import 'package:samastha/widgets/app_bars_custom.dart';
import 'package:samastha/widgets/default_loading_widget.dart';

class CertificatesListScreen extends StatelessWidget {
  const CertificatesListScreen({super.key});
  static const String path = '/certificates-list';

  @override
  Widget build(BuildContext context) {
    Provider.of<CertificateController>(context, listen: false)
        .getAllCertificateList(onInt: true);
    return Scaffold(
      appBar: const SimpleAppBar(title: 'Certificates'),
      body: SafeArea(child: Consumer<CertificateController>(
              builder: (context, controller, _) {
        return RefreshIndicator(
            onRefresh: () async {
              // Provider.of<CertificateController>(context, listen: false)
              controller.getAllCertificateList();
            },
            child: controller.isLoading
                ? const LoadingWidget()
                : controller.certificateList != null &&
                        controller.certificateList!.isNotEmpty
                    ? ListView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        padding: pagePadding,
                        children: List.generate(
                            controller.certificateList?.length ?? 0, (index) {
                          final certificateDat =
                              controller.certificateList?[index];

                          log('url is loading ${certificateDat?.downloadLink}');
                          return Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, CertificateDetailScreen.path,
                                      arguments: {
                                        'certificateUrl':
                                            certificateDat?.downloadLink
                                      });
                                },
                                child: Container(
                                  decoration: defaultDecoration,
                                  child: Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: SizedBox(
                                          width: 90,
                                          height: 90,
                                          child: CachedNetworkImage(
                                              fit: BoxFit.cover,
                                              imageUrl: certificateDat
                                                      ?.certificate
                                                      ?.course
                                                      ?.signedPhotoUrl ??
                                                  'https://cdn1.vectorstock.com/i/1000x1000/50/45/network-error-line-icon-linear-concept-vector-25335045.jpg'),
                                        ),

                                        // Assets.image.videoBg.image(
                                        //     width: 128,
                                        //     height: 96,
                                        //     fit: BoxFit.cover),
                                      ),
                                      const Gap(12),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              certificateDat
                                                      ?.certificate?.title ??
                                                  '',
                                              style: titleSmall.secondary,
                                            ),
                                            const Gap(2),
                                            Text(
                                              certificateDat
                                                      ?.certificate?.subTitle ??
                                                  '',
                                              style: bodyMedium.darkBG,
                                            ),
                                            const Gap(14),
                                            Row(
                                              children: [
                                                Assets.icon.download
                                                    .image(height: 16),
                                                const Gap(4),
                                                Text(
                                                  'Download Certificate',
                                                  style: titleSmall.secondary,
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              const Gap(15)
                            ],
                          );
                        }),
                      )
                    : ListView(
                        shrinkWrap: true,
                        children: [
                          SizedBox(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height * 0.9,
                            child: Center(
                              child: Text('No certificates found!',
                                  style: button.copyWith(
                                    color: ColorResources.BLACKGREY,
                                  )),
                            ),
                          )
                        ],
                      ));
      })

          //     SingleChildScrollView(
          //   padding: pagePadding,
          //   child:

          //   Column(
          //     children: [
          //       GestureDetector(
          //         onTap: () {
          //           Navigator.pushNamed(context, CertificateDetailScreen.path);
          //         },
          //         child: Container(
          //           decoration: defaultDecoration,
          //           child: Row(
          //             children: [
          //               ClipRRect(
          //                 borderRadius: BorderRadius.circular(8),
          //                 child: Assets.image.videoBg
          //                     .image(width: 128, height: 96, fit: BoxFit.cover),
          //               ),
          //               const Gap(12),
          //               Expanded(
          //                 child: Column(
          //                   crossAxisAlignment: CrossAxisAlignment.start,
          //                   children: [
          //                     Text(
          //                       'Fiqh',
          //                       style: titleSmall.secondary,
          //                     ),
          //                     const Gap(2),
          //                     Text(
          //                       'How To Pray Salah - step by step lessons',
          //                       style: bodyMedium.darkBG,
          //                     ),
          //                     const Gap(14),
          //                     Row(
          //                       children: [
          //                         Assets.icon.download.image(height: 16),
          //                         const Gap(4),
          //                         Text(
          //                           'Download Certificate',
          //                           style: titleSmall.secondary,
          //                         )
          //                       ],
          //                     )
          //                   ],
          //                 ),
          //               )
          //             ],
          //           ),
          //         ),
          //       )
          //     ],
          //   ),
          // )

          ),
    );
  }
}
