import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:samastha/gen/assets.gen.dart';
import 'package:samastha/modules/courses/controller/course_controller.dart';
import 'package:samastha/modules/courses/models/my_courses_model.dart';
import 'package:samastha/modules/courses/screens/course_detail_screen.dart';
import 'package:samastha/theme/dimensions.dart';
import 'package:samastha/theme/t_style.dart';
import 'package:samastha/utils/signed_image_viewer.dart';
import 'package:samastha/widgets/app_bars_custom.dart';
import 'package:samastha/widgets/default_loading_widget.dart';

class MyCoursesScreen extends StatefulWidget {
  const MyCoursesScreen({super.key});

  static const String path = '/my-courses-screen';

  @override
  State<MyCoursesScreen> createState() => _MyCoursesScreenState();
}

class _MyCoursesScreenState extends State<MyCoursesScreen> {
  CourseController bloc = CourseController();
  late Future myCoursesFuture;

  @override
  void initState() {
    myCoursesFuture = bloc.fetchPurchasedCourses();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SimpleAppBar(
        title: 'My Courses',
        leadingWidget: Icon(
          Icons.arrow_back,
          color: Colors.transparent,
        ),
      ),
      body: SafeArea(
        child: 1 != 1
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Assets.svgs.kids.comingsoonPoster2.svg(
                      height: MediaQuery.of(context).size.height * 0.5,
                      width: MediaQuery.of(context).size.width * 0.8,
                    ),
                  ),
                  const SizedBox(height: 125)
                ],
              )
            : FutureBuilder(
                future: myCoursesFuture,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Assets.image.noCourses.image(width: 150),
                          const Gap(15),
                          Text('There are no courses to show',
                              style: titleLarge.darkBG),
                        ],
                      ),
                    );

                    // return errorReload(snapshot.error.toString(), onTap: () {
                    //   setState(() {
                    //     myCoursesFuture = bloc.fetchPurchasedCourses();
                    //   });
                    // });
                  }

                  switch (snapshot.connectionState) {
                    case ConnectionState.done:
                      List<MyCourse> myCoursesList = snapshot.data ?? [];

                      debugPrint('my course InstList ${myCoursesList.length}');

                      return myCoursesList.isEmpty
                          ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Assets.image.noCourses.image(width: 150),
                                  const Gap(15),
                                  Text('There are no courses to show',
                                      style: titleLarge.darkBG),
                                ],
                              ),
                            )
                          : ListView.builder(
                              padding: pagePadding,
                              itemCount: myCoursesList.length,
                              itemBuilder: (context, index) => MyCourseWidget(
                                name: myCoursesList[index].title ?? '',
                                title: myCoursesList[index].title ?? '',
                                id: myCoursesList[index].id!,
                                description:
                                    myCoursesList[index].description ?? '',
                                progress: myCoursesList[index].viewed ?? 0,
                                imgUrl: myCoursesList[index].photoUrl,
                              ),
                            );
                    case ConnectionState.waiting:
                      return const Center(child: LoadingWidget());
                    default:
                      return Container();
                  }
                },
              ),
      ),
    );
  }
}

class MyCourseWidget extends StatelessWidget {
  const MyCourseWidget(
      {super.key,
      required this.title,
      required this.id,
      required this.description,
      required this.name,
      required this.progress,
      required this.imgUrl});

  final String title;
  final String name;
  final String description;
  final int id;
  final double progress;
  final String? imgUrl;

  @override
  Widget build(BuildContext context) {
    // log('imgUrl $imgUrl');
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          CourseDetailScreen.path,
          arguments: {'name': title, 'id': id, 'isPurchased': true},
        );
      },
      child: Container(
        padding: const EdgeInsets.only(right: 15),
        margin: const EdgeInsets.only(bottom: 16),
        decoration: defaultDecoration,
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Container(
                width: 128,
                height: 96,
                constraints: const BoxConstraints(minHeight: 96),
                child: imgUrl == null
                    ? Assets.image.videoBg.image(fit: BoxFit.fitHeight)
                    : ImageViewer(
                        path: imgUrl!,
                        fit: BoxFit.cover,
                      ),
              ),
            ),
            const Gap(12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: titleSmall.secondary,
                  ),
                  const Gap(2),
                  Text(
                    description,
                    style: bodyMedium.darkBG,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Gap(4),
                  Text(
                    'Continue',
                    style: titleSmall.primary,
                  ),
                  const Gap(8),
                  Stack(
                    alignment: Alignment.centerLeft,
                    children: [
                      Container(
                        height: 5,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: const Color(0xffE0E1E2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      Container(
                        height: 5,
                        width:
                            MediaQuery.sizeOf(context).width * (progress) / 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          gradient: const LinearGradient(
                            colors: [Color(0xff1696BB), Color(0xff00B707)],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
