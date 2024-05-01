// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:samastha/core/app_constants.dart';
import 'package:samastha/gen/assets.gen.dart';
import 'package:samastha/modules/courses/controller/course_controller.dart';
import 'package:samastha/modules/courses/screens/courses_search_screen.dart';
import 'package:samastha/modules/dashboard/controller/home_controller.dart';
import 'package:samastha/modules/dashboard/models/banner_model.dart';
import 'package:samastha/modules/courses/models/course_model.dart';
import 'package:samastha/modules/dashboard/widgets/home_carousal.dart';
import 'package:samastha/modules/dashboard/widgets/home_search_bar.dart';
import 'package:samastha/modules/dashboard/widgets/learn_quaran.dart';
import 'package:samastha/modules/dashboard/widgets/popular_courses.dart';
import 'package:samastha/modules/madrasa/controller/live_class_controller.dart';
import 'package:samastha/modules/madrasa/screens/regular_class_screen.dart';
import 'package:samastha/modules/parent/screens/parent_module_login.dart';
import 'package:samastha/modules/student/bloc/student_controller.dart';
import 'package:samastha/modules/student/models/student_login_model.dart';
import 'package:samastha/modules/student/screens/student_module_login.dart';
import 'package:samastha/theme/color_resources.dart';
import 'package:samastha/theme/t_style.dart';
import 'package:samastha/utils/error_reload.dart';
import 'package:samastha/utils/signed_image_viewer.dart';
import 'package:samastha/widgets/custom_form_elements.dart';
import 'package:samastha/widgets/custom_snackbar.dart';
import 'package:samastha/widgets/ongoing_live_class.dart';
import 'package:samastha/widgets/rect_box_vert_lines.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const path = '/home-screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin<HomeScreen> {
  HomeController bloc = HomeController();

  CourseController courseController = CourseController();

  late Future<List<BannerModel>> bannerFuture;

  late Future<List<CourseModel>> popularCourseFuture;
  late Future<List<CourseModel>> normalCourseFuture;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // liveClassPlaying();
    });

    //call banner api

    bannerFuture = bloc.fetchBanners();

    normalCourseFuture = courseController.fetchCourses(false);
    popularCourseFuture = courseController.fetchCourses(true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(


      floatingActionButton: AppConstants.loggedUser?.role == "student"
          ? Consumer<LiveClassController>(builder: (context, controller, _) {
              return controller.isLiveClassActive
                  ? Container(
                      margin: const EdgeInsets.only(bottom: 80),
                      child: FloatingActionButton(
                        backgroundColor: ColorResources.secondary,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100)),
                        onPressed: () {
                          liveClassPlaying();
                        },
                        child: Assets.svgs.navbar.floatingbar.svg(),
                      ),
                    )
                  : const SizedBox();
            })
          : const SizedBox(),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              // image
              const RectBoxWithVertLines(),

              SafeArea(
                top: true,
                child: PaddedColumn(
                  padding: pagePadding,
                  children: [
                    // search bar
                    FutureBuilder(
                        future: normalCourseFuture,
                        builder: (context, snapshot) {
                          List<CourseModel> datalist = [];
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            datalist = snapshot.data ?? [];
                            return HomeSearchBar(
                              courseList: datalist,
                              //   onPressed: () {
                              //   Navigator.push(
                              //       AppConstants.globalNavigatorKey.currentContext!,
                              //       MaterialPageRoute(
                              //         builder: (context) => SearchCourseScreen(),
                              //       ));
                              // }
                            );
                          } else {
                            return const HomeSearchBar();
                          }
                        }),
                    const Gap(18),
                    FutureBuilder<List<BannerModel>>(
                      future: bannerFuture,
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return const Text('could not load the banners!');
                        }
                        switch (snapshot.connectionState) {
                          // case ConnectionState.active:
                          case ConnectionState.done:
                            return HomeCarousal(
                              image: List.generate(
                                snapshot.data!.length,
                                (index) => ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: snapshot.data![index].image == null
                                        ? null
                                        : ImageViewer(
                                            path: snapshot
                                                    .data![index].imageUrl ??
                                                "",
                                            fit: BoxFit.cover,
                                            height: 142,
                                          )),
                              ),
                            );

                          default:
                            return Container();
                        }
                      },
                    ),

                    const Gap(24),
                    Row(
                      children: [
                        // online madrasa
                        Expanded(
                            child: GestureDetector(
                          onTap: () async {
                            if (AppConstants.loggedUser?.role == "student") {
                              if (await StudentController().checkPin()) {
                                // StudentLoginModel? result =
                                await StudentController()
                                    .login('121212')
                                    .then((value) {
                                  Navigator.pushNamed(context,
                                      OnlineMadrasaRegularClassScreen.path,
                                      arguments: {
                                        'studnetId': value?.id,
                                        'isParent': false
                                      });
                                });
                                // Navigator.pushNamed(
                                //     context, StudentModuleLogin.path);
                              } else {
                                await StudentController()
                                    .setPin('121212')
                                    .then((value) async {
                                  if (value) {
                                    await StudentController()
                                        .login('121212')
                                        .then((value) {
                                      Navigator.pushNamed(context,
                                          OnlineMadrasaRegularClassScreen.path,
                                          arguments: {
                                            'studnetId': value?.id,
                                            'isParent': false
                                          });
                                    });
                                  } else {
                                    SnackBarCustom.success(
                                        'something went wrong please try again after sometime');
                                  }
                                });
                                // Navigator.pushNamed(
                                //     context, StudentModuleSetPassword.path,
                                //     arguments: false);
                              }
                            } else {
                              return SnackBarCustom.success(
                                  'You do not have provision to enter as a student');
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(18),
                                border: Border.all(
                                    width: 1, color: ColorResources.BORDER),
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 20,
                                      offset: const Offset(
                                        0,
                                        8,
                                      ),
                                      spreadRadius: 0,
                                      color: Colors.black.withOpacity(.1))
                                ]),
                            child: Assets.image.onlinemadrasabutton.image(),
                          ),
                        )),
                        const Gap(16),
                        // find courses
                        Expanded(
                            child: GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                                context, CoursesSearchScreen.path);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(18),
                                border: Border.all(
                                    width: 1, color: ColorResources.BORDER),
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 20,
                                      offset: const Offset(
                                        0,
                                        8,
                                      ),
                                      spreadRadius: 0,
                                      color: Colors.black.withOpacity(.1))
                                ]),
                            child: Assets.image.findCourseButton.image(),
                          ),
                        )),
                        const Gap(16),
                        // parent module
                        Expanded(
                            child: GestureDetector(
                          onTap: () {
                            if (AppConstants.loggedUser?.role == null) {
                              return SnackBarCustom.success(
                                  'No role assigned for the user. contact admin');
                            }
                            if (AppConstants.loggedUser?.role == 'student') {
                              return SnackBarCustom.success(
                                  'You do not have provision to enter as a parent');
                            } else if (AppConstants.loggedUser?.role ==
                                'guest') {
                              Navigator.pushNamed(
                                  context, ParentModuleSetPassword.path,
                                  arguments: false);
                            } else {
                              Navigator.pushNamed(
                                context,
                                ParentModuleLogin.path,
                              );
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(18),
                                border: Border.all(
                                    width: 1, color: ColorResources.BORDER),
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 20,
                                      offset: const Offset(
                                        0,
                                        8,
                                      ),
                                      spreadRadius: 0,
                                      color: Colors.black.withOpacity(.1))
                                ]),
                            child: Assets.image.parentModuleButton.image(),
                          ),
                        )),
                      ],
                    ),
                    const Gap(32),
                    FutureBuilder<List<CourseModel>>(
                        future: popularCourseFuture,
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return errorReload(snapshot.error.toString(),
                                onTap: () {
                              setState(() {
                                popularCourseFuture =
                                    courseController.fetchCourses(true);
                              });
                            });
                          }
                          if (snapshot.hasData) {
                            return (snapshot.data?.isEmpty ?? false)
                                ? Container()
                                : CoursesWidget(
                                    title: 'Popular Courses',
                                    listModel: snapshot.data ?? [],
                                  );
                          } else {
                            //return const LearnQuraanShimmer();
                            return const LearnQuraanShimmer();
                          }
                        }),

                    const Gap(43),
                    FutureBuilder(
                        future: normalCourseFuture,
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return errorReload(snapshot.error.toString(),
                                onTap: () {
                              setState(() {
                                normalCourseFuture =
                                    courseController.fetchCourses(false);
                              });
                            });
                          }
                          if (snapshot.hasData) {
                            return (snapshot.data?.isEmpty ?? false)
                                ? Container()
                                : CoursesWidget(
                                    title: 'Courses',
                                    listModel: snapshot.data ?? [],
                                  );
                          } else {
                            return const LearnQuraanShimmer();
                          }
                        }),
                    const Gap(32),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  void liveClassPlaying() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 26),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: const OngoingLiveClass()),
    );
  }
}
