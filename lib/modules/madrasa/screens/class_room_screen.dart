import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:samastha/core/app_constants.dart';
import 'package:samastha/core/date_time_converter.dart';
import 'package:samastha/core/isparent_loged_in_details.dart';
import 'package:samastha/gen/assets.gen.dart';
import 'package:samastha/modules/madrasa/controller/live_class_controller.dart';
import 'package:samastha/modules/madrasa/controller/madrasa_controller.dart';
import 'package:samastha/modules/madrasa/models/subjects_model.dart';
import 'package:samastha/modules/madrasa/screens/lession_screen.dart';
import 'package:samastha/modules/madrasa/screens/time_table_screen.dart';
import 'package:samastha/modules/student/bloc/admission_bloc.dart';
import 'package:samastha/modules/student/models/student_profile_model.dart';
import 'package:samastha/theme/color_resources.dart';
import 'package:samastha/theme/dimensions.dart';
import 'package:samastha/theme/t_style.dart';
import 'package:samastha/utils/error_reload.dart';
import 'package:samastha/utils/signed_image_viewer.dart';
import 'package:samastha/widgets/app_bars_custom.dart';
import 'package:samastha/widgets/custom_snackbar.dart';
import 'package:samastha/widgets/default_loading_widget.dart';
import 'package:samastha/widgets/student_tile.dart';

class ClassRoomScreen extends StatefulWidget {
  const ClassRoomScreen({super.key});
  static const String path = '/class-room-screen';

  @override
  State<ClassRoomScreen> createState() => _ClassRoomScreenState();
}

class _ClassRoomScreenState extends State<ClassRoomScreen> {
  late Future<List<SubjectModel>> subjectsFuture;

  late Future<StudentProfileModel> studentFuture;

  MadrasaController bloc = MadrasaController();

  AdmissionBloc admissionBloc = AdmissionBloc();

  @override
  void initState() {
    if (IsParentLogedInDetails.isParentLogedIn()) {
      studentFuture = admissionBloc
          .fetchProfileparentLogin(IsParentLogedInDetails.getStudebtID());

      return;
    }

    studentFuture = admissionBloc.fetchProfile();
    // subjectsFuture = bloc.fetchSubjects();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: const SimpleAppBar(title: 'Classroom'),
      body: FutureBuilder(
          future: studentFuture,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return errorReload(snapshot.error.toString(), onTap: () {
                if (IsParentLogedInDetails.isParentLogedIn()) {
                  setState(() {
                    studentFuture = admissionBloc.fetchProfileparentLogin(
                        IsParentLogedInDetails.getStudebtID());
                  });

                  return;
                }
                setState(() {
                  studentFuture = admissionBloc.fetchProfile();
                });
              });
            }
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return const LoadingWidget();
              case ConnectionState.done:
              case ConnectionState.active:
                subjectsFuture = bloc.fetchSubjects(
                    snapshot.data!.classId, snapshot.data!.batchId);
                return RefreshIndicator(
                  color: ColorResources.primary,
                  onRefresh: () async {
                    if (IsParentLogedInDetails.isParentLogedIn()) {
                      Provider.of<LiveClassController>(context, listen: false)
                          .getLiveClassDetails(
                              studentID: IsParentLogedInDetails.getStudebtID());

                      return;
                    }
                    Provider.of<LiveClassController>(context, listen: false)
                        .getLiveClassDetails();
                  },
                  child: Padding(
                    padding: pagePadding,
                    child: Column(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            child: Column(
                              children: [
                                StudentTile(
                                  className: snapshot.data?.className ?? "",
                                  name: snapshot.data?.name ?? "",
                                  admissionNumber:
                                      snapshot.data?.admissionNo ?? "",
                                  batch: snapshot.data?.batchName ?? "",
                                  imgUrl: snapshot.data?.image,
                                ),
                                const Gap(15),
                                Consumer<LiveClassController>(
                                    builder: (context, controller, _) {
                                  //log('live class ${controller.liveClassModelFullData?.data?.data?.first.zoomDate.toString().split('').first}${controller.liveClassModelFullData?.data?.data?.first.zoomTime}');
                                  return controller.isLoading
                                      ? const LoadingWidget()
                                      : controller.liveClassModelFullData ==
                                              null
                                          ? const SizedBox()
                                          : Column(
                                              children: [
                                                controller.isLiveClassActive
                                                    ? Container(
                                                        decoration:
                                                            defaultDecoration,
                                                        padding:
                                                            const EdgeInsets
                                                                .all(17),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              'Live class started',
                                                              style: titleMedium
                                                                  .red,
                                                            ),
                                                            controller
                                                                    .isZoomInitilized
                                                                ? const CupertinoActivityIndicator()
                                                                : CupertinoButton(
                                                                    minSize: 0,
                                                                    padding:
                                                                        EdgeInsets
                                                                            .zero,
                                                                    onPressed:
                                                                        () async {
                                                                      if (AppConstants
                                                                              .loggedUser
                                                                              ?.role ==
                                                                          'parent') {
                                                                        SnackBarCustom.success(
                                                                            'Try login as student to join the live class');

                                                                        return;
                                                                      }
                                                                      controller.joinLiveClass(
                                                                          studentBatcName:
                                                                              snapshot.data?.batchName ?? '');
                                                                      // ZoomOptions
                                                                      //     zoomOptions =
                                                                      //     ZoomOptions(
                                                                      //   domain: "zoom.us",
                                                                      //   clientId:
                                                                      //       'k2e4ByVlSRKmEFHCRJdpfg',
                                                                      //   clientSecert:
                                                                      //       'XdhrMtfjCZtoMt0MmjS5OODIKDd1bkW0',
                                                                      // );
                                                                      // var meetingOptions =
                                                                      //     MeetingOptions(
                                                                      //   //  displayName: "YOUR_NAME",
                                                                      //   meetingId:
                                                                      //       "83601944838", //Personal meeting id for join meeting required
                                                                      //   meetingPassword:
                                                                      //       "745702", //Personal meeting password for join meeting required
                                                                      // );

                                                                      // var zoom =
                                                                      //     ZoomAllInOneSdk();
                                                                      // zoom
                                                                      //     .initZoom(
                                                                      //         zoomOptions:
                                                                      //             zoomOptions)
                                                                      //     .then(
                                                                      //         (results) {
                                                                      //   if (results[0] ==
                                                                      //       0) {
                                                                      //     zoom
                                                                      //         .joinMeting(
                                                                      //             meetingOptions:
                                                                      //                 meetingOptions)
                                                                      //         .then(
                                                                      //             (loginResult) {
                                                                      //       log('login result of the meetimg $loginResult');
                                                                      //     });
                                                                      //   }
                                                                      // }).catchError(
                                                                      //         (error) {
                                                                      //   print(
                                                                      //       "[Error Generated] : " +
                                                                      //           error);
                                                                      // });
                                                                      // try {
                                                                      //   if (controller
                                                                      //               .liveClassModelFullData
                                                                      //               ?.data
                                                                      //               ?.data ==
                                                                      //           null &&
                                                                      //       controller
                                                                      //           .liveClassModelFullData!
                                                                      //           .data!
                                                                      //           .data!
                                                                      //           .isEmpty) {
                                                                      //     return;
                                                                      //   }
                                                                      //   final url = Uri
                                                                      //       .parse(controller
                                                                      //               .liveClassModelFullData
                                                                      //               ?.data
                                                                      //               ?.data
                                                                      //               ?.first
                                                                      //               .zoomLink ??
                                                                      //           '');

                                                                      // if (await canLaunchUrl(
                                                                      //     url)) {
                                                                      //   await launchUrl(
                                                                      //       url);
                                                                      // } else {
                                                                      //   SnackBarCustom
                                                                      //       .success(
                                                                      //           'Failed to launch zoom please try again after some time');
                                                                      // }
                                                                      // } catch (e) {
                                                                      //   SnackBarCustom
                                                                      //       .success(
                                                                      //           'Failed to launch zoom please try again after some time');
                                                                      // }
                                                                    },
                                                                    child: Text(
                                                                      'Join Live',
                                                                      style: titleMedium
                                                                          .primary,
                                                                    ),
                                                                  )
                                                          ],
                                                        ),
                                                      )
                                                    : Container(
                                                        decoration:
                                                            defaultDecoration,
                                                        padding:
                                                            const EdgeInsets
                                                                .all(17),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  'Upcoming Live',
                                                                  style:
                                                                      titleMedium
                                                                          .red,
                                                                ),
                                                                const Gap(8),
                                                                Text(
                                                                  formatDate(
                                                                      DateTime
                                                                          .parse(
                                                                    '${controller.getZoomDateTime.year}-${controller.getZoomDateTime.month.toString().padLeft(2, '0')}-${controller.getZoomDateTime.day.toString().padLeft(2, '0')} ${controller.getZoomTime}',
                                                                  )),
                                                                  style:
                                                                      titleSmall
                                                                          .darkBG,
                                                                )
                                                              ],
                                                            ),
                                                            !controller
                                                                    .isNotifimeLoading
                                                                ? CupertinoButton(
                                                                    minSize: 0,
                                                                    padding:
                                                                        EdgeInsets
                                                                            .zero,
                                                                    onPressed: controller
                                                                            .isNotifime
                                                                        ? () {
                                                                            controller.onNotifiyMechnages();

                                                                            // if (AppConstants
                                                                            //         .loggedUser
                                                                            //         ?.role ==
                                                                            //     'parent') {
                                                                            //   SnackBarCustom
                                                                            //       .success(
                                                                            //           'Try login as student to join the live class');

                                                                            //   return;
                                                                            // }

                                                                            SnackBarCustom.success('Notification enabled successfully');
                                                                          }
                                                                        : () {},
                                                                    child: Text(
                                                                      'Notify Me',
                                                                      style: controller.isNotifime
                                                                          ? titleSmall
                                                                              .primary
                                                                          : titleSmall
                                                                              .primary
                                                                              .copyWith(color: ColorResources.primary.withOpacity(0.5)),
                                                                    ),
                                                                  )
                                                                : const CupertinoActivityIndicator()
                                                          ],
                                                        ),
                                                      ),
                                                const Gap(4),
                                                const Gap(12),
                                              ],
                                            );
                                }),
                                FutureBuilder<List<SubjectModel>>(
                                    future: subjectsFuture,
                                    builder: (context, subjectsSnapshot) {
                                      if (subjectsSnapshot.hasError) {
                                        return errorReload(
                                            subjectsSnapshot.error.toString(),
                                            onTap: () {
                                          setState(() {
                                            subjectsFuture = bloc.fetchSubjects(
                                                snapshot.data?.classId,
                                                snapshot.data?.batchId);
                                          });
                                        });
                                      }
                                      switch (
                                          subjectsSnapshot.connectionState) {
                                        case ConnectionState.waiting:
                                          return const LoadingWidget();
                                        case ConnectionState.active:
                                        case ConnectionState.done:
                                          List<SubjectModel> subjectData =
                                              subjectsSnapshot.data ?? [];
                                          return GridView.builder(
                                            shrinkWrap: true,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20),
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            gridDelegate:
                                                const SliverGridDelegateWithFixedCrossAxisCount(
                                              mainAxisExtent: 100,
                                              mainAxisSpacing: 10,
                                              crossAxisSpacing: 12,
                                              crossAxisCount: 2,
                                            ),
                                            itemCount: subjectData.length,
                                            itemBuilder: (context, index) {
                                              return GestureDetector(
                                                onTap: () {
                                                  Navigator.pushNamed(
                                                      context,
                                                      ClassRoomLessonScreen
                                                          .path,
                                                      arguments:
                                                          subjectData[index]);
                                                },
                                                child: SignedImageLoader(
                                                    path: subjectData[index]
                                                        .photoUrl,
                                                    imageBuilder:
                                                        (image, loading) =>
                                                            ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          11),
                                                              child: Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color:
                                                                      ColorResources
                                                                          .BORDER,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                  image:
                                                                      DecorationImage(
                                                                    image: image ??
                                                                        AssetImage(Assets
                                                                            .image
                                                                            .makka
                                                                            .path),
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  ),
                                                                ),
                                                                child: Stack(
                                                                  children: [
                                                                    Positioned
                                                                        .fill(
                                                                      child:
                                                                          Container(
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          gradient:
                                                                              LinearGradient(
                                                                            begin:
                                                                                Alignment.topCenter,
                                                                            end:
                                                                                Alignment.bottomCenter,
                                                                            colors: [
                                                                              const Color(0xffD2F5FF).withOpacity(0),
                                                                              const Color(0xffD2F5FF).withOpacity(0.5),
                                                                              const Color(0xffE9F8FF),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    // Container(
                                                                    //   height:
                                                                    //       50,
                                                                    //   color: Colors
                                                                    //       .amber,
                                                                    // ),
                                                                    Container(
                                                                      width: double
                                                                          .infinity,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        gradient:
                                                                            LinearGradient(
                                                                          begin:
                                                                              Alignment.bottomCenter,
                                                                          end: Alignment
                                                                              .topCenter,
                                                                          colors: [
                                                                            const Color.fromARGB(158, 0, 0, 0).withOpacity(0),
                                                                            Colors.black.withOpacity(0.5),
                                                                            const Color.fromARGB(
                                                                                120,
                                                                                0,
                                                                                0,
                                                                                0),
                                                                            // const Color(0xffD2F5FF).withOpacity(0),
                                                                            // const Color(0xffD2F5FF).withOpacity(0.5),
                                                                            // const Color(0xffE9F8FF),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      // color: Colors
                                                                      //     .black
                                                                      //     .withOpacity(
                                                                      //         0.39),
                                                                      child:
                                                                          Padding(
                                                                        padding: const EdgeInsets
                                                                            .all(
                                                                            8.0),
                                                                        child:
                                                                            Text(
                                                                          subjectData[index].title ??
                                                                              "",
                                                                          style: titleSmall
                                                                              .white
                                                                              .copyWith(fontSize: 14),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Positioned(
                                                                      bottom: 0,
                                                                      left: 0,
                                                                      right: 0,
                                                                      child:
                                                                          Container(
                                                                        height:
                                                                            30,
                                                                        color: const Color(0xffD2F5FF)
                                                                            .withOpacity(0.5),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .all(
                                                                          8.0),
                                                                      child:
                                                                          Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          Text(
                                                                            subjectData[index].title ??
                                                                                "",
                                                                            style:
                                                                                titleSmall.white.copyWith(fontSize: 14),
                                                                          ),
                                                                          Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceBetween,
                                                                            children: [
                                                                              Text(
                                                                                'Lessons',
                                                                                style: titleSmall.copyWith(color: const Color(0xff5FA9FF)),
                                                                              ),
                                                                              Text(
                                                                                'START',
                                                                                style: titleSmall.copyWith(
                                                                                  fontSize: 14,
                                                                                  color: const Color(0xff0BAA56),
                                                                                ),
                                                                              )
                                                                            ],
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            )

                                                    //         Container(
                                                    //   decoration: BoxDecoration(
                                                    //     color:
                                                    //         ColorResources.BORDER,
                                                    //     backgroundBlendMode:
                                                    //         BlendMode.overlay,
                                                    //     image: DecorationImage(
                                                    //       image: image ??
                                                    //           AssetImage(Assets
                                                    //               .image
                                                    //               .makka
                                                    //               .path),
                                                    //       fit: BoxFit.cover,
                                                    //     ),
                                                    //     borderRadius:
                                                    //         BorderRadius.circular(
                                                    //             10),
                                                    //     gradient: LinearGradient(
                                                    //         begin:
                                                    //             Alignment.topCenter,
                                                    //         end: Alignment
                                                    //             .bottomCenter,
                                                    //         colors: [
                                                    //           const Color(
                                                    //                   0xffD2F5FF)
                                                    //               .withOpacity(0),
                                                    //           const Color(
                                                    //                   0xffD2F5FF)
                                                    //               .withOpacity(0),
                                                    //           const Color(
                                                    //               0xffE9F8FF)
                                                    //         ]),
                                                    //   ),
                                                    //   child: Padding(
                                                    //     padding:
                                                    //         const EdgeInsets.all(
                                                    //             8.0),
                                                    //     child: Column(
                                                    //       crossAxisAlignment:
                                                    //           CrossAxisAlignment
                                                    //               .start,
                                                    //       mainAxisSize:
                                                    //           MainAxisSize.max,
                                                    //       mainAxisAlignment:
                                                    //           MainAxisAlignment
                                                    //               .spaceBetween,
                                                    //       children: [
                                                    //         Text(
                                                    //           subjectData[index]
                                                    //                   .title ??
                                                    //               "",
                                                    //           style: titleSmall
                                                    //               .white
                                                    //               .copyWith(
                                                    //                   fontSize: 14),
                                                    //         ),
                                                    //         Row(
                                                    //           mainAxisAlignment:
                                                    //               MainAxisAlignment
                                                    //                   .spaceBetween,
                                                    //           children: [
                                                    //             Text(
                                                    //               'Lessons',
                                                    //               style: titleSmall
                                                    //                   .copyWith(
                                                    //                       color: const Color(
                                                    //                           0xff5FA9FF)),
                                                    //             ),
                                                    //             Text(
                                                    //               'START',
                                                    //               style: titleSmall
                                                    //                   .copyWith(
                                                    //                 fontSize: 14,
                                                    //                 color: const Color(
                                                    //                     0xff0BAA56),
                                                    //               ),
                                                    //             )
                                                    //           ],
                                                    //         )
                                                    //       ],
                                                    //     ),
                                                    //   ),
                                                    // ),

                                                    ),
                                              );
                                            },
                                          );

                                        default:
                                          return Container();
                                      }
                                    }),
                              ],
                            ),
                          ),
                        ),
                        const Gap(10),
                        AppConstants.loggedUser?.role != 'parent'
                            ? GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                      AppConstants
                                          .globalNavigatorKey.currentContext!,
                                      TimeTableScreen.path);
                                },
                                child: Container(
                                  decoration: defaultDecoration,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 5,
                                  ),
                                  child: Row(
                                    children: [
                                      Assets.icon.dailyTask.image(height: 60),
                                      const Gap(14),
                                      Expanded(
                                          child: Text(
                                        'Time Table',
                                        style: titleMedium.secondary,
                                      )),
                                      Assets.svgs.doubleArrow.svg()
                                    ],
                                  ),
                                ),
                              )
                            : const Gap(0)
                      ],
                    ),
                  ),
                );

              default:
                return Container();
            }
          }),
      bottomSheet: AppConstants.loggedUser?.role == 'parent'
          ? Container(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                          AppConstants.globalNavigatorKey.currentContext!,
                          TimeTableScreen.path);
                    },
                    child: Container(
                      decoration: defaultDecoration,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 5,
                      ),
                      child: Row(
                        children: [
                          Assets.icon.dailyTask.image(height: 60),
                          const Gap(14),
                          Expanded(
                              child: Text(
                            'Time Table',
                            style: titleMedium.secondary,
                          )),
                          Assets.svgs.doubleArrow.svg()
                        ],
                      ),
                    ),
                  ),
                  const Gap(10)
                ],
              ),
            )
          : null,
    );
  }
}

class ClassRoomLessonScreen extends StatefulWidget {
  final SubjectModel subjectId;
  const ClassRoomLessonScreen({super.key, required this.subjectId});
  static const String path = '/class-room-lesson-screen';

  @override
  State<ClassRoomLessonScreen> createState() => _ClassRoomLessonScreenState();
}

class _ClassRoomLessonScreenState extends State<ClassRoomLessonScreen> {
  late Future<StudentProfileModel> studentFuture;
  // late Future subjectsFuture;

  MadrasaController bloc = MadrasaController();

  AdmissionBloc admissionBloc = AdmissionBloc();

  @override
  void initState() {
    if (IsParentLogedInDetails.isParentLogedIn()) {
      studentFuture = admissionBloc
          .fetchProfileparentLogin(IsParentLogedInDetails.getStudebtID());

      return;
    }
    studentFuture = admissionBloc.fetchProfile();
    // subjectsFuture = bloc.fetchSubjects(classId, batchId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: const SimpleAppBar(title: 'Classroom'),
      body: FutureBuilder(
          future: studentFuture,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return errorReload(snapshot.error.toString(), onTap: () {
                if (IsParentLogedInDetails.isParentLogedIn()) {
                  setState(() {
                    studentFuture = admissionBloc.fetchProfileparentLogin(
                        IsParentLogedInDetails.getStudebtID());
                  });

                  return;
                }

                setState(() {
                  studentFuture = admissionBloc.fetchProfile();
                });
              });
            }
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return const LoadingWidget();
              case ConnectionState.done:
              case ConnectionState.active:
                return Padding(
                  padding: pagePadding,
                  child: Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          child: Column(
                            children: [
                              StudentTile(
                                className: snapshot.data?.className ?? "",
                                name: snapshot.data?.name ?? "",
                                admissionNumber:
                                    snapshot.data?.admissionNo ?? "",
                                batch: snapshot.data?.batchName ?? "",
                                imgUrl: snapshot.data?.image,
                              ),
                              const Gap(15),
                              // Consumer<LiveClassController>(
                              //     builder: (context, controller, _) {
                              //   return controller.isLoading
                              //       ? const LoadingWidget()
                              //       : Container(
                              //           decoration: defaultDecoration,
                              //           padding: const EdgeInsets.all(17),
                              //           child: Row(
                              //             mainAxisAlignment:
                              //                 MainAxisAlignment.spaceBetween,
                              //             children: [
                              //               Text(
                              //                 'Live class started',
                              //                 style: titleMedium.red,
                              //               ),
                              //               CupertinoButton(
                              //                 onPressed: () async {
                              //                   try {
                              //                     if (controller
                              //                                 .liveClassModelFullData
                              //                                 ?.data
                              //                                 ?.data ==
                              //                             null &&
                              //                         controller
                              //                             .liveClassModelFullData!
                              //                             .data!
                              //                             .data!
                              //                             .isEmpty) {
                              //                       return;
                              //                     }
                              //                     final url = Uri.parse(controller
                              //                             .liveClassModelFullData
                              //                             ?.data
                              //                             ?.data
                              //                             ?.first
                              //                             .zoomLink ??
                              //                         '');

                              //                     if (await canLaunchUrl(url)) {
                              //                       await launchUrl(url);
                              //                     } else {
                              //                       SnackBarCustom.success(
                              //                           'Failed to launch zoom please try again after some time');
                              //                     }
                              //                   } catch (e) {
                              //                     SnackBarCustom.success(
                              //                         'Failed to launch zoom please try again after some time');
                              //                   }
                              //                 },
                              //                 minSize: 0,
                              //                 padding: EdgeInsets.zero,
                              //                 child: Text(
                              //                   'Join Live',
                              //                   style: titleMedium.primary,
                              //                 ),
                              //               )
                              //             ],
                              //           ),
                              //         );
                              // }),
                              const Gap(12),
                              SubjectLessonWidget(
                                batchId: snapshot.data?.batchId,
                                subjectId: widget.subjectId.id,
                                title: widget.subjectId.title,
                                description: widget.subjectId.description,
                              )
                            ],
                          ),
                        ),
                      ),
                      const Gap(10),
                      AppConstants.loggedUser?.role != 'parent'
                          ? GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                    AppConstants
                                        .globalNavigatorKey.currentContext!,
                                    TimeTableScreen.path);
                              },
                              child: Container(
                                decoration: defaultDecoration,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 5,
                                ),
                                child: Row(
                                  children: [
                                    Assets.icon.dailyTask.image(height: 60),
                                    const Gap(14),
                                    Expanded(
                                        child: Text(
                                      'Time Table',
                                      style: titleMedium.secondary,
                                    )),
                                    Assets.svgs.doubleArrow.svg()
                                  ],
                                ),
                              ),
                            )
                          : const Gap(0)
                    ],
                  ),
                );

              default:
                return Container();
            }
          }),
      bottomSheet: AppConstants.loggedUser?.role == 'parent'
          ? Container(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  const Gap(10),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                          AppConstants.globalNavigatorKey.currentContext!,
                          TimeTableScreen.path);
                    },
                    child: Container(
                      decoration: defaultDecoration,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 5,
                      ),
                      child: Row(
                        children: [
                          Assets.icon.dailyTask.image(height: 60),
                          const Gap(14),
                          Expanded(
                              child: Text(
                            'Time Table',
                            style: titleMedium.secondary,
                          )),
                          Assets.svgs.doubleArrow.svg()
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          : null,
    );
  }
}
