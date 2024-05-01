import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:samastha/core/isparent_loged_in_details.dart';
import 'package:samastha/helper/service_locator.dart' as di;
import 'package:samastha/gen/assets.gen.dart';
import 'package:samastha/modules/kids/modules/home/screen/kids_home_parent.dart';
import 'package:samastha/modules/madrasa/screens/regular_class_screen.dart';
import 'package:samastha/modules/parent/bloc/user_bloc.dart';
import 'package:samastha/modules/parent/model/kids_model.dart';
import 'package:samastha/modules/student/screens/join_higher_class_welcome_screen.dart';
import 'package:samastha/modules/student/screens/new_join_registration_form.dart';
import 'package:samastha/theme/t_style.dart';
import 'package:samastha/utils/error_reload.dart';
import 'package:samastha/utils/signed_image_viewer.dart';
import 'package:samastha/widgets/app_bars_custom.dart';
import 'package:samastha/widgets/custom_snackbar.dart';
import 'package:samastha/widgets/default_loading_widget.dart';
import 'package:samastha/widgets/user_avatar_grid_item.dart';

class MyKidsListScreen extends StatefulWidget {
  static const path = '/my-kids-list';
  const MyKidsListScreen({super.key});

  @override
  State<MyKidsListScreen> createState() => _MyKidsListScreenState();
}

class _MyKidsListScreenState extends State<MyKidsListScreen> {
  UserBloc bloc = UserBloc();

  late Future<List<KidsModel>> future;

  @override
  void initState() {
    future = bloc.fetchKids();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SimpleAppBar(title: 'My Kids'),
      body:FutureBuilder<List>(
          future: future,
          builder: (context, snapshot) {
            
            if (snapshot.hasError) {
              errorReload(snapshot.error.toString());
            }

            switch (snapshot.connectionState) {
  
              case ConnectionState.waiting:
                return const LoadingWidget();
              case ConnectionState.done:
              case ConnectionState.active:
                var data = snapshot.data ?? [];
                return RefreshIndicator(
                  onRefresh: () async {
                    setState(() {
                      future = bloc.fetchKids();
                    });
                  },
                  child: GridView(
                      padding:
                          pagePadding.copyWith(top: 30, left: 30, right: 30),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1,
                      ),
                      children: <Widget>[
                            for (KidsModel item in data)
                              GestureDetector(
                                onTap: () async {
                                  // final DioClient dioClient =
                                  //     di.sl<DioClient>();
                                  // // log('current snapshot data ${data}');

                                  // final response =
                                  //     await dioClient.get(Urls.kidsList);
                                  // var datasss = response.data['data']['data']['admissionNumber'];  
                                  log('usermodel data is Data ${item.id} name is ${item.role} ${IsParentLogedInDetails.getStudebtID()}');

                                  if (item.admissionNumber == null) {
                                    SnackBarCustom.success(
                                        'Try continue again after payment');

                                    return;
                                  }

                                  if (item.role == 'student') {
                                    Navigator.pushNamed(context,
                                        OnlineMadrasaRegularClassScreen.path,
                                        arguments: {
                                          'studnetId': item.id,
                                          'isParent': true
                                        });

                                    return;
                                  }

                                  Navigator.pushNamed(
                                      context, KidsHomeParentScreen.path,
                                      arguments: {
                                        'studnetId': item.id,
                                        'isParent': true
                                      });

                                  // final DioClient dioClient =
                                  //     di.sl<DioClient>();
                                  // final response = await dioClient.get(
                                  //     Urls.fetchStudentProfile,
                                  //     queryParameters: {'student_id': 103});

                                  //     queryParameters: {'studnet_id': 103}
                                  //  await dioClient.get(
                                  //   '${Urls.user}/$userId',
                                  // );
                                },
                                // onTap: () async {
                                //   StudentLoginModel? result = StudentLoginModel(
                                //       id: 169,
                                //       name: 'Kaka',
                                //       email: 'kaka@br.cm',
                                //       phoneNumber: null,
                                //       isActive: 1,
                                //       isLogin: 0,
                                //       otp: "1111",
                                //       username: "SGM0012",
                                //       status: "approved",
                                //       isParent: 0,
                                //       isStudent: 0,
                                //       isRegularUser: 0,
                                //       pins: "12345",
                                //       roleId: 6,
                                //       roleName: "student",
                                //       roles: [
                                //         Role(
                                //             id: 6,
                                //             name: "student",
                                //             guardName: "api",
                                //             createdBy: 1,
                                //             updatedBy: 1,
                                //             pivot: Pivot(
                                //                 modelType: 'App/Models/User',
                                //                 modelId: 169,
                                //                 roleId: 6))
                                //       ]);
                                //   // await StudentController()
                                //   //     .login('12345');
                                //   if (result != null) {
                                //     AppConstants.studentID = 169;
                                //     Navigator.pushNamed(context,
                                //         OnlineMadrasaRegularClassScreen.path,
                                //         arguments: result);
                                //   }
                                // },
                                child: UserAvatarGridItem(
                                  icon: item.image == null
                                      ? SizedBox(
                                          height: 84,
                                          width: 84,
                                          child: Assets.image.user.image())
                                      : _Icon(imageUrl: item.imageUrl!),
                                  title: item.name,
                                ),
                              ),
                          ] +
                          [
                            const NewAdmission(),
                          ]),
                );

              default:
                return Container();
            }
          }),
    );
  }
}

class NewAdmission extends StatelessWidget {
  const NewAdmission({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return UserAvatarGridItem(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => Dialog(
            elevation: 0,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            insetPadding: const EdgeInsets.symmetric(horizontal: 26),
            child: SizedBox(
              height: 172,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.popAndPushNamed(
                            context, NewJoinRegistrationForm.path);
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Assets.svgs.joinFirst.svg(),
                          const Gap(14),
                          Text(
                            'Admission to\nFirst standard',
                            style: bodyMedium.darkBG,
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                    ),
                  ),
                  const VerticalDivider(),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.popAndPushNamed(
                            context, JoinHigherClassWelcomeScreen.path);
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Assets.svgs.joinHigher.svg(),
                          const Gap(14),
                          Text(
                            'Join to\nHigher class',
                            style: bodyMedium.darkBG,
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      icon: Container(
          height: 84,
          width: 84,
          decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
            BoxShadow(
                blurRadius: 16,
                spreadRadius: 0,
                offset: const Offset(0, 8),
                color: const Color(0xff000000).withOpacity(.15)),
          ]),
          child: Assets.svgs.addFriend.svg()),
      title: 'New Admission',
    );
  }
}

class _Icon extends StatelessWidget {
  const _Icon({
    required this.imageUrl,
  });

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 84,
      width: 84,
      decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
        BoxShadow(
            blurRadius: 16,
            spreadRadius: 0,
            offset: const Offset(0, 8),
            color: const Color(0xff000000).withOpacity(.15)),
      ]),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: ImageViewer(path: imageUrl),
        // ImageViewer(
        //  path: imageUrl,
        //   fit: BoxFit.cover,

        // ),
        // child: CachedNetworkImage(
        //   imageUrl: imageUrl,
        //   fit: BoxFit.cover,
        //   placeholder: (context, url) {
        //     return CircleAvatar(
        //       backgroundColor: ColorResources.PLACEHOLDER,
        //     );
        //   },
        // ),
      ),
    );
  }
}
