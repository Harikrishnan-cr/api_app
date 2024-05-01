import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:samastha/modules/courses/controller/course_controller.dart';
import 'package:samastha/modules/courses/models/course_model.dart';
import 'package:samastha/modules/dashboard/widgets/learn_quaran.dart';
import 'package:samastha/modules/dashboard/widgets/popular_courses.dart';
import 'package:samastha/theme/t_style.dart';
import 'package:samastha/utils/error_reload.dart';
import 'package:samastha/widgets/app_bars_custom.dart';

class CoursesSearchScreen extends StatefulWidget {
  const CoursesSearchScreen({super.key});
  static const String path = '/courses-search';

  @override
  State<CoursesSearchScreen> createState() => _CoursesSearchScreenState();
}

class _CoursesSearchScreenState extends State<CoursesSearchScreen> {
  CourseController courseController = CourseController();

  late Future<List<CourseModel>> popularCourseFuture;
  late Future<List<CourseModel>> normalCourseFuture;

  @override
  void initState() {
    normalCourseFuture = courseController.fetchCourses(false);
    popularCourseFuture = courseController.fetchCourses(true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SimpleAppBar(title: 'Courses'),
      body: SingleChildScrollView(
        padding: pagePadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            FutureBuilder<List<CourseModel>>(
                future: popularCourseFuture,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return errorReload(snapshot.error.toString(), onTap: () {
                      setState(() {
                        popularCourseFuture =
                            courseController.fetchCourses(false);
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
                    return const LearnQuraanShimmer(
                      title: 'Popular courses',
                    );
                  }
                }),
            const Gap(43),
            FutureBuilder(
                future: normalCourseFuture,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return errorReload(snapshot.error.toString(), onTap: () {
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
    );
  }
}
