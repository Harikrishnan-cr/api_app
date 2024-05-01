import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:samastha/core/app_constants.dart';
import 'package:samastha/core/isparent_loged_in_details.dart';
import 'package:samastha/gen/assets.gen.dart';
import 'package:samastha/modules/kids/modules/dashboard/screen/kids_bg.dart';
import 'package:samastha/modules/student/controller/leader_board_provider.dart';
import 'package:samastha/theme/color_resources.dart';
import 'package:samastha/theme/t_style.dart';
import 'package:samastha/widgets/app_bars_custom.dart';
import 'package:samastha/widgets/default_loading_widget.dart';
import 'package:screenshot/screenshot.dart';
import 'package:social_share/social_share.dart';

class LeaderBoardScreen extends StatefulWidget {
  const LeaderBoardScreen({super.key, this.isKid});
  static const String path = '/leader-board';
  final bool? isKid;

  @override
  State<LeaderBoardScreen> createState() => _LeaderBoardScreenState();
}

class _LeaderBoardScreenState extends State<LeaderBoardScreen> {
  // PageMode _pageMode = PageMode.batchWise;
  bool isScreenshotTaking = false;
  static final ScreenshotController _screenshotController =
      ScreenshotController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: RefreshIndicator(
        onRefresh: () async {
          if (IsParentLogedInDetails.isParentLogedIn()) {
            Provider.of<LeaderBoardProvider>(context, listen: false)
                .getLeaderBoardData(
                    studentID: IsParentLogedInDetails.getStudebtID());

            return;
          }

          Provider.of<LeaderBoardProvider>(context, listen: false)
              .getLeaderBoardData();
        },
        child: Container(
          color: Colors.white,
          child: Stack(
            children: [
              Visibility(
                  visible: (widget.isKid ?? false),
                  child: const KidsBg(isHomeScreen: false)),
              SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  // padding: pagePadding,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Gap(23),
                      _buildModeSwitcher(),
                      const Gap(24),
                      Consumer<LeaderBoardProvider>(
                          builder: (context, controller, _) {
                        return controller.isLoading
                            ? SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.8,
                                width: double.infinity,
                                child: const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    LoadingWidget()
                                    // CircularProgressIndicator(),
                                  ],
                                ),
                              )
                            : Screenshot(
                                controller: _screenshotController,
                                child: Container(
                                  padding: pagePadding,
                                  color: isScreenshotTaking
                                      ? Colors.white
                                      : Colors.transparent,
                                  child: Column(
                                    children: [
                                      GestureDetector(
                                          onTap: () {
                                            controller.getLeaderBoardData();
                                          },
                                          child: _buildMyScore()),
                                      const Gap(18),
                                      _buildLeaderBoard(),
                                      const Gap(24),

                                      controller
                                              .globalandBatchStudentListFrom4thPosition
                                              .isNotEmpty
                                          ? ListView(
                                              shrinkWrap: true,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              children: List.generate(
                                                  controller
                                                      .globalandBatchStudentListFrom4thPosition
                                                      .length, (index) {
                                                final leaderBoardStd = controller
                                                        .globalandBatchStudentListFrom4thPosition[
                                                    index];
                                                return _buildUserRow(
                                                    name: leaderBoardStd
                                                            .student?.name ??
                                                        '',
                                                    batch: leaderBoardStd
                                                            .student
                                                            ?.batch
                                                            ?.academicClass
                                                            ?.classDisplayId ??
                                                        '',
                                                    score: 659,
                                                    number: index + 4);
                                              }),
                                            )
                                          : Column(
                                              children: [
                                                const Gap(10),
                                                Text(
                                                  'No students list to show',
                                                  style: button,
                                                ),
                                              ],
                                            )
                                      // _buildUserRow("Aisha", "SKIMVB124578", 659),
                                      // _buildUserRow("Summaya", "SKIMVB124578", 659),
                                      // _buildUserRow("Shibila", "SKIMVB124578", 659),
                                      // _buildUserRow("Saly", "SKIMVB124578", 659),
                                    ],
                                  ),
                                ),
                              );
                      }),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return SimpleAppBar(
      title: 'Leader Board',
      trailing: [
        IconButton(
          onPressed: () async {
            try {
              setState(() {
                isScreenshotTaking = true;
              });
              var data = await _screenshotController.capture();
              setState(() {
                isScreenshotTaking = false;
              });
              if (data == null) {
                return;
              }
              final tempDir = await getTemporaryDirectory();
              final assetPath = '${tempDir.path}/temp.png';
              File file = await File(assetPath).create();
              await file.writeAsBytes(data);
              SocialShare.shareOptions('', imagePath: file.path);
            } catch (e) {
              debugPrint('share error : $e');
            }
          },
          icon: Assets.image.share.image(color: ColorResources.primary),
        )
      ],
    );
  }

  Widget _buildModeSwitcher() {
    return Consumer<LeaderBoardProvider>(builder: (context, controller, _) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              controller.onPageModeChnages(pageMode: PageMode.batchWise);
              controller.getLeaderBoardData();
            },
            child: Container(
              width: 115,
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color: controller.pageMode == PageMode.batchWise
                    ? const Color(0xff0BAA56)
                    : const Color(0xff0BAA56).withOpacity(.4),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(100),
                  bottomLeft: Radius.circular(100),
                  topRight: Radius.circular(0), // Adjusted
                  bottomRight: Radius.circular(0), // Adjusted
                ),
              ),
              child: Text(
                'Batch Wise',
                textAlign: TextAlign.center,
                style: controller.pageMode == PageMode.batchWise
                    ? titleSmall.white
                    : titleSmall.copyWith(
                        color: const Color(0xff10A089),
                      ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              controller.onPageModeChnages(pageMode: PageMode.global);
              controller.getLeaderBoardData();
            },
            child: Container(
              width: 115,
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color: controller.pageMode == PageMode.global
                    ? const Color(0xff0BAA56)
                    : const Color(0xff0BAA56).withOpacity(.4),
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(100),
                  bottomRight: Radius.circular(100),
                  topLeft: Radius.circular(0), // Adjusted
                  bottomLeft: Radius.circular(0), // Adjusted
                ),
              ),
              child: Text(
                'Global',
                textAlign: TextAlign.center,
                style: controller.pageMode == PageMode.global
                    ? titleSmall.white
                    : titleSmall.copyWith(
                        color: const Color(0xff10A089),
                      ),
              ),
            ),
          ),
        ],
      );
    });
  }

  Widget _buildModeButton(String text, PageMode mode) {
    // final isSelected = pageMode == mode;

    final isSelected = true;
    return GestureDetector(
      onTap: () {
        // setState(() {
        //   pageMode = mode;
        // });
      },
      child: Container(
        width: 115,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? ColorResources.textFiledBorder
              : ColorResources.textFiledBorder.withOpacity(.4),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(100),
            bottomLeft: Radius.circular(100),
            topRight: Radius.circular(100),
            bottomRight: Radius.circular(100),
          ),
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: isSelected
              ? titleSmall.white
              : titleSmall.copyWith(color: const Color(0xff10A089)),
        ),
      ),
    );
  }

  Widget _buildMyScore() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'My Score ',
          style: bodyMedium.secondary,
        ),
        Text(
          '700',
          style: titleMedium.copyWith(color: const Color(0xff0BAA56)),
        ),
      ],
    );
  }

  // Widget _buildLeaderBoardRow() {
  //   return Row(
  //     crossAxisAlignment: CrossAxisAlignment.end,
  //     children: [
  //       _buildLeaderboardColumn(2, 94, ColorResources.secondary, '2'),
  //       _buildLeaderboardColumn(1, 125, const Color(0xff0BAA56), '1'),
  //       _buildLeaderboardColumn(3, 94, ColorResources.textFiledBorder, '3'),
  //     ],
  //   );
  // }

  Widget _buildLeaderboardColumn(
      {required int position,
      required double containerSize,
      required Color borderColor,
      required String circleText,
      String? imageUrl}) {
    return Expanded(
      child: Column(
        children: [
          position == 1
              ? Assets.image.crowngoldpng.image(height: 41)
              : position == 2
                  ? Assets.image.crownssilver.image(height: 28)
                  : Assets.image.groupbrozone.image(height: 28),
          const Gap(16),
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                height: containerSize,
                width: containerSize,
                margin: const EdgeInsets.only(bottom: 10),
                alignment: Alignment.bottomCenter,
                decoration: BoxDecoration(
                  image: imageUrl == null
                      ? DecorationImage(
                          image: AssetImage(Assets.image.sinan.path),
                          fit: BoxFit.cover)
                      : DecorationImage(
                          image: CachedNetworkImageProvider(imageUrl),
                          fit: BoxFit.cover),
                  shape: BoxShape.circle,
                  color: ColorResources.PLACEHOLDER,
                  border: Border.all(
                    color: const Color(0xff0BAA56),
                    width: position == 1 ? 2 : 1,
                  ),
                ),
              ),
              CircleAvatar(
                radius: 13,
                backgroundColor: borderColor,
                child: Text(
                  circleText,
                  style: titleMedium.white,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLeaderRowInfo(
      {required String name,
      required String batch,
      required int score,
      required Color textColor,
      required Color batchColor,
      required int position}) {
    return Expanded(
      child: Column(
        children: [
          const Gap(7),
          Text(
            name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: bodyMedium.darkBG,
            textAlign: TextAlign.center,
          ),
          Text(
            score.toString(),
            style: bodyMedium.copyWith(
                color: textColor,
                fontWeight: position == 1 ? FontWeight.w700 : FontWeight.w400),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            batch,
            style: labelMedium.copyWith(color: batchColor),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildLeaderBoard() {
    return Consumer<LeaderBoardProvider>(builder: (context, controller, _) {
      return controller.globalandBatchStudentList.length > 3
          ? Column(
              children: [
                // _buildLeaderBoardRow(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    _buildLeaderboardColumn(
                        position: 2,
                        containerSize: 94,
                        borderColor: ColorResources.secondary,
                        imageUrl: controller
                            .globalandBatchStudentList[1].student?.imageUrl,
                        circleText: '2'),
                    _buildLeaderboardColumn(
                        position: 1,
                        containerSize: 125,
                        borderColor: const Color(0xff0BAA56),
                        imageUrl: controller
                            .globalandBatchStudentList[0].student?.imageUrl,
                        circleText: '1'),
                    _buildLeaderboardColumn(
                        position: 3,
                        containerSize: 94,
                        borderColor: ColorResources.textFiledBorder,
                        imageUrl: controller
                            .globalandBatchStudentList[2].student?.imageUrl,
                        circleText: '3'),
                  ],
                ),
                Row(
                  children: [
                    _buildLeaderRowInfo(
                        name: controller
                                .globalandBatchStudentList[1].student?.name ??
                            '',
                        batch:
                            'Batch ${controller.globalandBatchStudentList[1].student?.batch?.academicClass?.classDisplayId}',
                        score:
                            controller.globalandBatchStudentList[1].mark ?? 0,
                        textColor: const Color(0xff1696BB),
                        batchColor: const Color(0xff1696BB),
                        position: 2),
                    _buildLeaderRowInfo(
                        name: controller
                                .globalandBatchStudentList[0].student?.name ??
                            '',
                        batch:
                            'Batch ${controller.globalandBatchStudentList[0].student?.batch?.academicClass?.classDisplayId}',
                        score:
                            controller.globalandBatchStudentList[0].mark ?? 0,
                        textColor: const Color(0xff0BAA56),
                        batchColor: const Color(0xff0BAA56),
                        position: 1),
                    _buildLeaderRowInfo(
                        name: controller
                                .globalandBatchStudentList[2].student?.name ??
                            '',
                        batch:
                            'Batch ${controller.globalandBatchStudentList[2].student?.batch?.academicClass?.classDisplayId}',
                        score:
                            controller.globalandBatchStudentList[2].mark ?? 0,
                        textColor: ColorResources.secondary,
                        batchColor: ColorResources.secondary,
                        position: 3),
                  ],
                ),
              ],
            )
          : Column(
              children: [
                // _buildLeaderBoardRow(),
                Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: controller.globalandBatchStudentList.length == 3
                        ? [
                            _buildLeaderboardColumn(
                                position: 2,
                                containerSize: 94,
                                borderColor: ColorResources.secondary,
                                imageUrl: controller
                                    .globalandBatchStudentList[1]
                                    .student
                                    ?.imageUrl,
                                circleText: '2'),
                            _buildLeaderboardColumn(
                                position: 1,
                                imageUrl: controller
                                    .globalandBatchStudentList[0]
                                    .student
                                    ?.imageUrl,
                                containerSize: 125,
                                borderColor: const Color(0xff0BAA56),
                                circleText: '1'),
                            _buildLeaderboardColumn(
                                position: 3,
                                imageUrl: controller
                                    .globalandBatchStudentList[2]
                                    .student
                                    ?.imageUrl,
                                containerSize: 94,
                                borderColor: ColorResources.textFiledBorder,
                                circleText: '3'),
                          ]
                        : List.generate(
                            controller.globalandBatchStudentList.length,
                            (index) {
                            log('image url is ${controller.globalandBatchStudentList[index].student?.imageUrl}');

                            return _buildLeaderboardColumn(
                                position: index + 1,
                                containerSize: 94,
                                // imageUrl: controller
                                //     .globalandBatchStudentList[index]
                                //     .student
                                //     ?.imageUrl,
                                borderColor: index == 0
                                    ? const Color(0xff0BAA56)
                                    : ColorResources.secondary,
                                circleText: '${index + 1}');
                          })

                    // [
                    // _buildLeaderboardColumn(
                    //     2, 94, ColorResources.secondary, '2'),
                    //   _buildLeaderboardColumn(
                    //       1, 125, const Color(0xff0BAA56), '1'),
                    //   _buildLeaderboardColumn(
                    //       3, 94, ColorResources.textFiledBorder, '3'),
                    // ],
                    ),
                controller.globalandBatchStudentList.length > 3
                    ? Row(
                        children: [
                          _buildLeaderRowInfo(
                              name: controller.globalandBatchStudentList[1]
                                      .student?.name ??
                                  '',
                              batch:
                                  'Batch ${controller.globalandBatchStudentList[1].student?.batch?.academicClass?.classDisplayId}',
                              score: controller
                                      .globalandBatchStudentList[1].mark ??
                                  0,
                              textColor: const Color(0xff1696BB),
                              batchColor: const Color(0xff1696BB),
                              position: 2),
                          _buildLeaderRowInfo(
                              name: controller.globalandBatchStudentList[0]
                                      .student?.name ??
                                  '',
                              batch:
                                  'Batch ${controller.globalandBatchStudentList[0].student?.batch?.academicClass?.classDisplayId}',
                              score: controller
                                      .globalandBatchStudentList[0].mark ??
                                  0,
                              textColor: const Color(0xff0BAA56),
                              batchColor: const Color(0xff0BAA56),
                              position: 1),
                          _buildLeaderRowInfo(
                              name: controller.globalandBatchStudentList[2]
                                      .student?.name ??
                                  '',
                              batch:
                                  'Batch ${controller.globalandBatchStudentList[2].student?.batch?.academicClass?.classDisplayId}',
                              score: controller
                                      .globalandBatchStudentList[2].mark ??
                                  0,
                              textColor: ColorResources.secondary,
                              batchColor: ColorResources.secondary,
                              position: 3),
                        ],
                      )
                    : Row(
                        children: controller.globalandBatchStudentList.length ==
                                3
                            ? [
                                _buildLeaderRowInfo(
                                    name: controller
                                            .globalandBatchStudentList[1]
                                            .student
                                            ?.name ??
                                        '',
                                    batch:
                                        'Batch ${controller.globalandBatchStudentList[1].student?.batch?.academicClass?.classDisplayId}',
                                    score: controller
                                            .globalandBatchStudentList[1]
                                            .mark ??
                                        0,
                                    textColor: const Color(0xff1696BB),
                                    batchColor: const Color(0xff1696BB),
                                    position: 2),
                                _buildLeaderRowInfo(
                                    name: controller
                                            .globalandBatchStudentList[0]
                                            .student
                                            ?.name ??
                                        '',
                                    batch:
                                        'Batch ${controller.globalandBatchStudentList[0].student?.batch?.academicClass?.classDisplayId}',
                                    score: controller
                                            .globalandBatchStudentList[0]
                                            .mark ??
                                        0,
                                    textColor: const Color(0xff0BAA56),
                                    batchColor: const Color(0xff0BAA56),
                                    position: 1),
                                _buildLeaderRowInfo(
                                    name: controller
                                            .globalandBatchStudentList[2]
                                            .student
                                            ?.name ??
                                        '',
                                    batch:
                                        'Batch ${controller.globalandBatchStudentList[2].student?.batch?.academicClass?.classDisplayId}',
                                    score: controller
                                            .globalandBatchStudentList[2]
                                            .mark ??
                                        0,
                                    textColor: ColorResources.secondary,
                                    batchColor: ColorResources.secondary,
                                    position: 3),
                              ]
                            : List.generate(
                                controller.globalandBatchStudentList.length,
                                (index) {
                                return _buildLeaderRowInfo(
                                    name: controller
                                            .globalandBatchStudentList[index]
                                            .student
                                            ?.name ??
                                        '',
                                    batch:
                                        'Batch ${controller.globalandBatchStudentList[index].student?.batch?.academicClass?.classDisplayId}',
                                    score: controller
                                            .globalandBatchStudentList[index]
                                            .mark ??
                                        0,
                                    textColor: index == 0
                                        ? const Color(0xff0BAA56)
                                        : const Color(0xff1696BB),
                                    batchColor: index == 0
                                        ? const Color(0xff0BAA56)
                                        : const Color(0xff1696BB),
                                    position: index + 1);
                              }),
                      ),
              ],
            );
    });
  }

  Widget _buildUserRow(
      {required String name,
      required String batch,
      required int score,
      required int number}) {
    const value = 0xffEBEBEB;
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          width: 1,
          color: const Color(value),
        ),
      ),
      child: Row(
        children: [
          Text(
            "$number",
            style: titleMedium.darkBG,
          ),
          const Gap(12),
          CircleAvatar(
            radius: 38 / 2,
            backgroundColor: ColorResources.PLACEHOLDER,
            backgroundImage: AssetImage(
              Assets.image.sumayya.path,
            ),
          ),
          const Gap(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: bodyMedium.darkBG,
                ),
                Text(
                  batch,
                  style: labelSmall.primary,
                ),
              ],
            ),
          ),
          Text(
            score.toString(),
            style: titleSmall.primary,
          )
        ],
      ),
    );
  }
}
