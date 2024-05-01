import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:samastha/gen/assets.gen.dart';
import 'package:samastha/modules/student/controller/performance_analysis_controller.dart';
import 'package:samastha/theme/color_resources.dart';
import 'package:samastha/theme/dimensions.dart';
import 'package:samastha/theme/t_style.dart';
import 'package:samastha/widgets/app_bars_custom.dart';
import 'package:screenshot/screenshot.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class PerformanceScore extends StatelessWidget {
  // const PerformanceScore({super.key});
  static const String path = '/performance-score';

  // List<ChartData> chartData = <ChartData>[
  //   const ChartData('Jan', 35.53),
  //   const ChartData('Feb', 46.06),
  //   const ChartData('Mar', 46.06),
  //   const ChartData('Apr', 50.86),
  //   const ChartData('May', 60.89),
  //   const ChartData('Jun', 70.27),
  //   const ChartData('Jul', 75.65),
  //   const ChartData('Aug', 75.65),
  //   const ChartData('Sep', 75.65),
  //   const ChartData('Oct', 75.65),
  //   const ChartData('Nov', 75.65),
  //   const ChartData('Dec', 75.65),
  // ];

  PerformanceScore({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) {
        SystemChrome.setPreferredOrientations(
            [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: SimpleAppBar(title: 'Performance Score', trailing: [
          IconButton(
            onPressed: () {
              Provider.of<PerformanceAmalysisProvider>(context, listen: false)
                  .shareScreenShot();
            },
            icon: Assets.image.share.image(color: ColorResources.primary),
          )
        ]),
        // bottomNavigationBar: Padding(
        //   padding: pagePadding.copyWith(bottom: 30),
        //   child: CustomOutlineButton(
        //     'Share Report',
        //     onTap: (loader) {
        //       Provider.of<PerformanceAmalysisProvider>(context, listen: false)
        //           .getAllPerformanceData();
        //     },
        //   ),
        // ),
        body: Consumer<PerformanceAmalysisProvider>(
            builder: (context, controller, _) {
          return Screenshot(
            controller: PerformanceAmalysisProvider.screenshotController,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: defaultDecoration,
                  child: Column(
                    children: [
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     Text(
                      //       'Overall\nPerformance Score',
                      //       style: titleLarge.darkBG,
                      //     ),
                      //     Row(
                      //       crossAxisAlignment: CrossAxisAlignment.baseline,
                      //       textBaseline: TextBaseline.alphabetic,
                      //       children: [
                      //         Text(
                      //           '50',
                      //           style: GoogleFonts.openSans(
                      //             fontSize: 36,
                      //             color: ColorResources.secondary,
                      //             fontWeight: FontWeight.w700,
                      //           ),
                      //         ),
                      //         Text(
                      //           '/100',
                      //           style: GoogleFonts.openSans(
                      //               fontSize: 16,
                      //               color: ColorResources.primary,
                      //               fontWeight: FontWeight.w700,
                      //               fontFeatures: [
                      //                 const FontFeature.subscripts(),
                      //               ]),
                      //         ),
                      //       ],
                      //     ),
                      //   ],
                      // ),
                      // const Gap(45),
                      _CustomChart(chartData: controller.chartData),
                    ],
                  ),
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}

class _CustomChart extends StatelessWidget {
  const _CustomChart({
    required this.chartData,
  });

  final List<ChartData> chartData;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.65,
      child: SfCartesianChart(
        plotAreaBorderWidth: 0,
        primaryXAxis: CategoryAxis(
            placeLabelsNearAxisLine: true,
            majorGridLines: const MajorGridLines(
              width: 0,
            ), // Remove vertical grid lines
            minorGridLines: const MinorGridLines(
                width: 0), // Remove vertical minor grid lines
            axisLine: const AxisLine(width: 1, color: Color(0xffEBEBEB)),
            majorTickLines:
                const MajorTickLines(width: 0), // Remove vertical tick lines
            minorTickLines: const MinorTickLines(
                width: 0), // Remove vertical minor tick lines
            labelStyle: labelSmall.darkBG),
        primaryYAxis: NumericAxis(
            majorGridLines:
                const MajorGridLines(width: 0), // Remove horizontal grid lines
            minorGridLines: const MinorGridLines(
                width: 0), // Remove horizontal minor grid lines
            axisLine: const AxisLine(width: 1, color: Color(0xffEBEBEB)),
            labelStyle: labelSmall.darkBG),
        series: <ColumnSeries<ChartData, String>>[
          ColumnSeries<ChartData, String>(
            dataSource: chartData,
            xValueMapper: (ChartData sales, _) => sales.x,
            yValueMapper: (ChartData sales, _) => sales.y,
            gradient: const LinearGradient(
              colors: [
                Color(0xff08AA4D),
                Color(
                  0xff129C98,
                )
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(
                100,
              ),
              topRight: Radius.circular(
                100,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final double sales;
}

class ChartData {
  const ChartData(this.x, this.y);
  final String x;
  final double y;
}
