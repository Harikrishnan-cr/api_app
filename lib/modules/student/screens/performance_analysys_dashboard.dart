import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:samastha/core/isparent_loged_in_details.dart';
import 'package:samastha/gen/assets.gen.dart';
import 'package:samastha/modules/student/controller/performance_analysis_controller.dart';
import 'package:samastha/modules/student/screens/performance_score.dart';
import 'package:samastha/theme/color_resources.dart';
import 'package:samastha/theme/dimensions.dart';
import 'package:samastha/theme/t_style.dart';
import 'package:samastha/widgets/app_bars_custom.dart';
import 'package:samastha/widgets/custom_form_elements.dart';
import 'package:samastha/widgets/default_loading_widget.dart';

class PerformanceAnalysisDashboard extends StatefulWidget {
  const PerformanceAnalysisDashboard({super.key});
  static const String path = '/performance-analysis-dashboard';

  @override
  State<PerformanceAnalysisDashboard> createState() =>
      _PerformanceAnalysisDashboardState();
}

class _PerformanceAnalysisDashboardState
    extends State<PerformanceAnalysisDashboard> {
  @override
  void initState() {
    if (IsParentLogedInDetails.isParentLogedIn()) {
      Provider.of<PerformanceAmalysisProvider>(context, listen: false)
          .getAllPerformanceData(
              studentID: IsParentLogedInDetails.getStudebtID());

      return;
    }
    Provider.of<PerformanceAmalysisProvider>(context, listen: false)
        .getAllPerformanceData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SimpleAppBar(title: 'Performance Analysis'),
      body: SafeArea(
        child: SingleChildScrollView(
          child: PaddedColumn(padding: pagePadding, children: [
            //image
            GestureDetector(
              onTap: () {
                Provider.of<PerformanceAmalysisProvider>(context, listen: false)
                    .onChartDataAdded();
                Navigator.pushNamed(context, PerformanceScore.path);
              },
              child: Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  Assets.image.perfoAnalyysBanner.image(fit: BoxFit.fitWidth),
                  Consumer<PerformanceAmalysisProvider>(
                      builder: (context, controller, _) {
                    return Container(
                      margin: EdgeInsets.only(
                          bottom: MediaQuery.sizeOf(context).height * .035,
                          left: MediaQuery.sizeOf(context).width * .035),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          controller.performanceData?.data?.overallPercentage ==
                                  null
                              ? Text(
                                  '0',
                                  style: GoogleFonts.openSans(
                                    fontSize: 36,
                                    color: ColorResources.secondary,
                                    fontWeight: FontWeight.w700,
                                  ),
                                )
                              : Text(
                                  '${controller.performanceData?.data?.overallPercentage}',
                                  style: GoogleFonts.openSans(
                                    fontSize: 36,
                                    color: ColorResources.secondary,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                          Text(
                            '/100',
                            style: GoogleFonts.openSans(
                                fontSize: 16,
                                color: ColorResources.primary,
                                fontWeight: FontWeight.w700,
                                fontFeatures: [
                                  const FontFeature.subscripts(),
                                ]),
                          ),
                        ],
                      ),
                    );
                  })
                ],
              ),
            ),
            Consumer<PerformanceAmalysisProvider>(
                builder: (context, controller, _) {
              return controller.isLoading
                  ? LoadingWidget()
                  : Column(
                      children: [
                        const Gap(16),
                        _Item(
                          mark: controller
                                      .performanceData?.data?.attendanceScore !=
                                  null
                              ? '${(controller.performanceData?.data?.attendanceScore)}'
                              : '0',
                          title: 'Attendance Score',
                        ),
                        const Gap(13),
                        _Item(
                          mark: controller.performanceData?.data?.examScore !=
                                  null
                              ? '${(controller.performanceData?.data?.examScore)}'
                              : '0',
                          title: 'Exam Performance',
                        ),
                        const Gap(13),
                        _Item(
                          mark: controller.performanceData?.data?.quizScore !=
                                  null
                              ? '${(controller.performanceData?.data?.quizScore)}'
                              : '0',
                          title: 'Quiz Performance',
                        ),
                        const Gap(13),
                        _Item(
                          mark: controller
                                      .performanceData?.data?.assignmentScore !=
                                  null
                              ? '${(controller.performanceData?.data?.assignmentScore)}'
                              : '0',
                          title: 'Assignment',
                        ),
                      ],
                    );
            })
          ]),
        ),
      ),
    );
  }
}

class _Item extends StatelessWidget {
  const _Item({
    required this.title,
    required this.mark,
  });
  final String title;
  final String mark;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: defaultDecoration,
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: f16w400.darkBG,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          // const Spacer(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                mark,
                style: GoogleFonts.openSans(
                  fontSize: 36,
                  color: ColorResources.secondary,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                '/100',
                style: GoogleFonts.openSans(
                    fontSize: 16,
                    color: ColorResources.primary,
                    fontWeight: FontWeight.w700,
                    fontFeatures: [
                      const FontFeature.subscripts(),
                    ]),
              ),
            ],
          ),
          // const Gap(20),
          const Gap(10),
          Assets.svgs.doubleArrow.svg()
        ],
      ),
    );
  }
}
