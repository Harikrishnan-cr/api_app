import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:samastha/core/app_constants.dart';
import 'package:samastha/gen/assets.gen.dart';
import 'package:samastha/modules/kids/modules/dashboard/screen/kids_bg.dart';
import 'package:samastha/modules/kids/modules/test_and_assignments/screen/kids_test_and_assignments_screen.dart';
import 'package:samastha/modules/madrasa/screens/class_room_screen.dart';
import 'package:samastha/modules/student/bloc/admission_bloc.dart';
import 'package:samastha/modules/student/screens/leader_board.dart';

class KidsHomeScreen extends StatefulWidget {
  const KidsHomeScreen({super.key});
  static const String path = '/kids-home-screen';

  @override
  State<KidsHomeScreen> createState() => _KidsHomeScreenState();
}

class _KidsHomeScreenState extends State<KidsHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      alignment: Alignment.center,
      children: [
        const KidsBg(isHomeScreen: true),
        Positioned(
          top: 0,
          bottom: 0,
          left: 0,
          right: 0,
          child: ListView(shrinkWrap: true, children: [
            FutureBuilder(
                future: AdmissionBloc().fetchProfile(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Container();
                    // return errorReload(snapshot.error.toString(), onTap: () {
                    //   setState(() {
                    //     AdmissionBloc().fetchProfile();
                    //   });
                    // });
                  }
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                    // return const LoadingWidget();
                    case ConnectionState.done:
                    case ConnectionState.active:
                      AppConstants.studentID = snapshot.data?.id;
                      return Stack(
                        alignment: Alignment.bottomLeft,
                        children: [
                          Container(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height * 0.1488,
                            decoration: const BoxDecoration(
                                // color: Colors.amber,
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(30),
                                    bottomRight: Radius.circular(30)),
                                image: DecorationImage(
                                    image: AssetImage(
                                      'assets/image/kids/mosque_home_header_kids.png',
                                    ),
                                    fit: BoxFit.cover)),
                          ),
                          //Assets.image.kids.mosqueHomeHeaderKids.image(),
                          Positioned(
                            left: 24,
                            top: 49,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Assets.image.kids.usthadKids
                                    .image(height: 56, width: 56),
                                const Gap(10),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Assalamu Alaikum',
                                      style: GoogleFonts.inter(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        height: 0.11,
                                      ),
                                    ),
                                    const Gap(5),
                                    Text(
                                      '${snapshot.data?.name}',
                                      style: GoogleFonts.inter(
                                        color: const Color(0xFF001319),
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                        height: 0,
                                      ),
                                    ),
                                    // Text('Assalamu Alaikum'),
                                    // Text('Rashaad Khalifa'),
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      );

                    default:
                      return Container();
                  }
                }),
            Column(
              children: [
                const Gap(30), //135

                _KidsCardItem(
                  headText: 'Classroom',
                  descrText: 'Go to Online class room',
                  imagePath: Assets.image.kids.classroomCardBg.path,
                  onTap: () =>
                      Navigator.pushNamed(context, ClassRoomScreen.path),
                ),

                _KidsCardItem(
                  headText: 'Test & Assignments',
                  descrText: 'Find all your tests',
                  imagePath: Assets.image.kids.testAndAssignmentsCardBg.path,
                  onTap: () => Navigator.pushNamed(
                      context, KidsTestAndAssignmentsScreen.path),
                ),

                _KidsCardItem(
                  headText: 'Leaderboad',
                  descrText: 'Find your position in class',
                  imagePath: Assets.image.kids.leaderboardCardBg.path,
                  onTap: () => Navigator.pushNamed(
                      AppConstants.globalNavigatorKey.currentContext!,
                      LeaderBoardScreen.path,
                      arguments: {"isKid": true}),
                ),
              ],
            ),
          ]),
        )
      ],
    ));
  }
}

class _KidsCardItem extends StatelessWidget {
  const _KidsCardItem(
      {required this.headText,
      required this.descrText,
      required this.imagePath,
      this.onTap});
  final String headText;
  final String descrText;
  final String imagePath;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 150,
        width: 310,
        decoration: BoxDecoration(
            image: DecorationImage(
          image: Image.asset(
            imagePath,
            fit: BoxFit.cover,
          ).image,
        )),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.white,
                    blurRadius: 30,
                    spreadRadius: 8,
                  )
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    headText,
                    style: GoogleFonts.inter(
                      color: const Color(0xFF285029),
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      height: 0,
                    ),
                  ),
                  const Gap(3),
                  Text(
                    descrText,
                    style: GoogleFonts.inter(
                      color: const Color(0xFF447D46),
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      height: 0,
                    ),
                  ),
                ],
              ),
            ),
            const Gap(15),
          ],
        ),
      ),
    );
  }
}
