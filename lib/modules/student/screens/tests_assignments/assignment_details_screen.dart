import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:samastha/core/app_constants.dart';
import 'package:samastha/gen/assets.gen.dart';
import 'package:samastha/helper/date_converter.dart';
import 'package:samastha/modules/student/bloc/assignment_controller.dart';
import 'package:samastha/modules/student/models/assignment_details_model.dart';
import 'package:samastha/theme/color_resources.dart';
import 'package:samastha/theme/t_style.dart';
import 'package:samastha/utils/error_reload.dart';
import 'package:samastha/utils/signed_image_viewer.dart';
import 'package:samastha/widgets/custom_form_elements.dart';
import 'package:samastha/widgets/custom_snackbar.dart';
import 'package:samastha/widgets/default_loading_widget.dart';
import 'package:samastha/widgets/dotted_border_custom.dart';

class AssignmentDetailsScreen extends StatefulWidget {
  const AssignmentDetailsScreen({super.key});

  static const String path = '/assignment-details';

  @override
  State<AssignmentDetailsScreen> createState() =>
      _AssignmentDetailsScreenState();
}

class _AssignmentDetailsScreenState extends State<AssignmentDetailsScreen> {
  bool isExpanded = false;

  List<Widget> item = [];
  File? worksheetFile;
  AssignmentController bloc = AssignmentController();

  late Future assignmentDetailsFuture;

  WorkSheet? selectedWorkSheet;

  _initData() {
    // var id = ModalRoute.of(context)!.settings.arguments! as int;
    print('tempselected ${AppConstants.tempSelected}');
    assignmentDetailsFuture =
        bloc.fetchAssignmentDetails(AppConstants.tempSelected);
  }

  @override
  void initState() {
    _initData();
    // setState(() {
    //   item.addAll([
    //     WhatToDoItem(
    //       title: AppConstants.lorem,
    //     ),
    //     WhatToDoItem(
    //       title: AppConstants.lorem,
    //     ),
    //     WhatToDoItem(
    //       title: AppConstants.lorem,
    //     ),
    //     WhatToDoItem(
    //       title: AppConstants.lorem,
    //     ),
    //     WhatToDoItem(
    //       title: AppConstants.lorem,
    //     ),
    //     WhatToDoItem(
    //       title: AppConstants.lorem,
    //     ),
    //     WhatToDoItem(
    //       title: AppConstants.lorem,
    //     ),
    //   ]);
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: assignmentDetailsFuture,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return errorReload(snapshot.error.toString(),
                  onTap: () => _initData());
            }

            switch (snapshot.connectionState) {
              case ConnectionState.done:
                AssignmentDetailsModel? assignmentDetailsModel = snapshot.data;

                return CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      pinned: true,
                      expandedHeight: 220,
                      title: Text(
                        assignmentDetailsModel?.title ?? '',
                        style: titleLarge.white,
                      ),
                      flexibleSpace: FlexibleSpaceBar(
                        background:
                            ImageViewer(path: assignmentDetailsModel?.imageUrl),
                        // SignedImageLoader(
                        //   path: assignmentDetailsModel?.imageUrl,
                        //   imageBuilder: (x, isLoading) {
                        //     return isLoading
                        //         ? const LoadingWidget()
                        //         : Container(
                        //             width: double.maxFinite,
                        //             foregroundDecoration: BoxDecoration(
                        //               gradient: LinearGradient(
                        //                 begin: const Alignment(-0.00, -1.00),
                        //                 end: const Alignment(0, 1),
                        //                 colors: [
                        //                   Colors.black,
                        //                   Colors.black.withOpacity(0)
                        //                 ],
                        //               ),
                        //             ),
                        //             decoration: BoxDecoration(
                        //               image: DecorationImage(
                        //                   image: x!, fit: BoxFit.cover),
                        //             ),
                        //           );
                        //   },
                        // ),
                      ),
                      bottom: PreferredSize(
                        preferredSize: const Size.fromHeight(18),
                        child: Container(
                          height: 20,
                          decoration: BoxDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(24),
                              topRight: Radius.circular(24),
                            ),
                            // border: Border.all(color: Colors.white),
                          ),
                        ),
                      ),
                      elevation: 0,
                      scrolledUnderElevation: 0,
                    ),
                    SliverToBoxAdapter(
                      child: _body(snapshot.data),
                    )
                  ],
                );

              case ConnectionState.waiting:
                return const Center(child: LoadingWidget());
              default:
                return Container();
            }
          }),
    );
  }

  _body(AssignmentDetailsModel? data) {
    return SingleChildScrollView(
      padding: pagePadding.copyWith(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            data?.subTitle ?? '',
            style: titleLarge.darkBG,
          ),
          const Gap(14),
          Html(data: data?.description ?? ''),

          // Text(
          //   data?.description ?? '',
          //   style: bodyMedium.grey1,
          // ),
          const Gap(16),
          Row(
            children: [
              Text(
                'Date : ',
                style: titleSmall.darkBG,
              ),
              Text(
                DateConverter.dateWithMonth(
                    data?.submissionDate ?? DateTime.now()),
                style: titleSmall.primary,
              ),
            ],
          ),
          const Gap(16),
          Text(
            'What to do?',
            style: titleMedium.darkBG,
          ),
          const Gap(16),

          ...data!.instructions!.map((e) => Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Row(
                  children: [
                    Assets.image.blueTick.image(),
                    const Gap(16),
                    Expanded(
                      child: Text(
                        e,
                      ),
                    )
                  ],
                ),
              )),
          // Html(data: data?.instructions),

          if (!isExpanded)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...item
                    .sublist(0, item.length > 4 ? 4 : item.length)
                    .map((e) => e),
                if (item.length > 4)
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isExpanded = true;
                      });
                    },
                    child: Text(
                      '+9 more',
                      style: titleMedium.primary,
                    ),
                  ),
                const Gap(18),
              ],
            )
          else
            ...item.map((e) => e),
          Text(
            'Worksheets',
            style: titleMedium.darkBG,
          ),

          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            // padding: pagePadding,
            itemCount: data?.workSheets?.length,
            itemBuilder: (context, index) => Worksheet(
              title: data?.workSheets?[index].name,
              subTitle: 'AssignmentTasksheet.pdf',
              status: toBeginningOfSentenceCase(
                  (data?.workSheets?[index].status)!.replaceAll('_', ' ')),
              borderColor: selectedWorkSheet == data?.workSheets?[index]
                  ? ColorResources.primary
                  : null,
              onTap: () {
                setState(() {
                  selectedWorkSheet = data?.workSheets?[index];
                });
              },
              onDownload: () =>
                  bloc.openPdf(data?.workSheets?[index].worksheet),
            ),
          ),

          // const Worksheet(
          //   title: 'Worksheet 1',
          //   subTitle: 'AssignmentTasksheet.pdf',
          // ),
          // const Worksheet(
          //   title: 'Worksheet 1',
          //   subTitle: 'AssignmentTasksheet.pdf',
          // ),
          // const Worksheet(
          //   title: 'Worksheet 1',
          //   subTitle: 'AssignmentTasksheet.pdf',
          // ),
          const Gap(16),
          if (selectedWorkSheet != null)
            DottedBorderCustom(
              dashPattern: const [5, 5],
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 14),
                //check status of the worksheet. if upload completed show another widget.
                child: selectedWorkSheet?.status != "pending"
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  debugPrint('view already uploaded worksheet');
                                },
                                child: Image.asset(
                                  Assets.icon.viewIcon.path,
                                  height: 15,
                                ),
                              ),
                              const Gap(25),
                              GestureDetector(
                                onTap: () async {
                                  debugPrint('edit already uploaded worksheet');
                                  worksheetFile = await bloc.pickFile();
                                  selectedWorkSheet?.answerWorksheet =
                                      worksheetFile;
                                  setState(() {});
                                },
                                child: Image.asset(
                                  Assets.icon.editIcon.path,
                                  height: 20,
                                ),
                              ),
                            ],
                          ),
                          const Gap(10),
                          Text(selectedWorkSheet?.name ?? '')
                        ],
                      )
                    : GestureDetector(
                        onTap: () async {
                          worksheetFile = await bloc.pickFile();
                          selectedWorkSheet?.answerWorksheet = worksheetFile;
                          setState(() {});
                        },
                        child: Column(
                          children: [
                            selectedWorkSheet?.answerWorksheet == null
                                ? Assets.svgs.cloudComputing.svg(
                                    color: ColorResources.secondary, height: 40)
                                : Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child:
                                        Assets.svgs.boxChecked.svg(height: 26),
                                  ),
                            Text(
                              selectedWorkSheet?.answerWorksheet == null
                                  ? 'Upload completed worksheets'
                                  : 'Selected',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                                color: ColorResources.darkBG.withOpacity(.5),
                              ),
                            ),
                            Text(
                              'Pdf or jpg',
                              style: labelSmall.s10.darkBG,
                            )
                          ],
                        ),
                      ),
              ),
            ),

          const Gap(16),
          SubmitButton('Submit', onTap: (_) async {
            try {
              // var result = await bloc.submitAssignment(AppConstants.studentID,
              //     data?.id, worksheetFile, data?.workSheets);
              var result = await bloc
                  .uploadAssignment(AppConstants.studentID,
                      selectedWorkSheet?.id, selectedWorkSheet?.answerWorksheet)
                  .then((value) {
                setState(() {
                  if (value.status ?? false) {
                    assignmentDetailsFuture =
                        bloc.fetchAssignmentDetails(AppConstants.tempSelected);
                  }
                });
                return value;
              });
              SnackBarCustom.success(result.message ?? '');
              // if (result.status ?? false) Navigator.pop(context);
            } catch (e) {
              SnackBarCustom.success(e.toString());
            }
          }),
          const Gap(80),
        ],
      ),
    );
  }
}

class WhatToDoItem extends StatelessWidget {
  const WhatToDoItem({
    super.key,
    required this.title,
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Assets.image.blueTick.image(),
          const Gap(16),
          Expanded(
            child: Text(
              title,
              style: bodyMedium.grey1,
              maxLines: 3,
            ),
          )
        ],
      ),
    );
  }
}

class Worksheet extends StatelessWidget {
  const Worksheet(
      {super.key,
      required this.title,
      this.subTitle,
      this.onTap,
      this.onDownload,
      this.borderColor,
      this.status});
  final String? title, subTitle, status;
  final void Function()? onTap;
  final void Function()? onDownload;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              width: 1,
              color: borderColor ?? ColorResources.BORDER,
            )),
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(top: 18),
        child: Row(
          children: [
            Assets.icon.pdf.image(height: 49),
            const Gap(16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title ?? '',
                    style: bodyMedium.darkBG,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Gap(3),
                  Text(
                    subTitle ?? '',
                    style: bodyMedium.grey1,
                    maxLines: 3,
                  ),
                  const Gap(3),
                  Text(
                    status ?? '',
                    style: bodyMedium.grey1,
                    maxLines: 3,
                  ),
                ],
              ),
            ),
            GestureDetector(
                onTap: onDownload,
                child: Assets.icon.download.image(height: 30))
          ],
        ),
      ),
    );
  }
}
