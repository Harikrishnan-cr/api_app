import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:samastha/core/app_constants.dart';
import 'package:samastha/core/web_view_common.dart';
import 'package:samastha/gen/assets.gen.dart';
import 'package:samastha/main.dart';
import 'package:samastha/modules/authentication/bloc/auth_bloc.dart';
import 'package:samastha/modules/authentication/model/user_details_model.dart';
import 'package:samastha/modules/parent/bloc/user_bloc.dart';
import 'package:samastha/modules/parent/screens/certificates_list_screen.dart';
import 'package:samastha/modules/parent/screens/parent_profile_edit_screen.dart';
import 'package:samastha/modules/parent/screens/rewards_screen.dart';
import 'package:samastha/modules/parent/screens/user_profile_edit_screen.dart';
import 'package:samastha/modules/parent/screens/video_saved_screen.dart';
import 'package:samastha/modules/student/bloc/admission_bloc.dart';
import 'package:samastha/modules/student/models/student_profile_model.dart';
import 'package:samastha/modules/student/screens/fee_payment_summary.dart';
import 'package:samastha/theme/color_resources.dart';
import 'package:samastha/theme/t_style.dart';
import 'package:samastha/utils/image_picker.dart';
import 'package:samastha/utils/signed_image_viewer.dart';
import 'package:samastha/widgets/alert_box_widgets.dart';
import 'package:samastha/widgets/app_bars_custom.dart';
import 'package:samastha/widgets/custom_snackbar.dart';
import 'package:share_plus/share_plus.dart';
import 'package:webview_flutter/webview_flutter.dart';



class MyProfileScreen extends StatefulWidget {
  static const String path = '/my-profile';
  const MyProfileScreen({super.key});

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  List<ProfileMenu> menu = [];
  AdmissionBloc bloc = AdmissionBloc();
  UserBloc userbloc = UserBloc();
  late Future profileFuture;
  late Future userFuture;
  bool isStudent = AppConstants.loggedUser?.role == 'student';

  @override
  void initState() {
    profileFuture = bloc.fetchProfile();
    userFuture = userbloc.viewProfile(AppConstants.loggedUser!.id!);
    menu.addAll([
      ProfileMenu(
        title: (AppConstants.loggedUser?.role == 'parent')
            ? 'Edit Profile'
            : 'View Profile',
        icon: Assets.image.editProfile.svg(),
        onTap: () {
          if (AppConstants.loggedUser?.role == 'parent') {
            Navigator.pushNamed(
              AppConstants.globalNavigatorKey.currentContext!,
              ParentProfileEditScreen.path,
            );
            // Navigator.pushNamed(AppConstants.globalNavigatorKey.currentContext!,
            //     ProfileEditScreen.path,
            //     arguments: true);

            return;
          }
          // Navigator.pushNamed(AppConstants.globalNavigatorKey.currentContext!,
          //     ProfileEditScreen.path,
          //     arguments: true);

          Navigator.pushNamed(
            AppConstants.globalNavigatorKey.currentContext!,
            StudentprofileViewScrenn.path,
          );
        },
      ),
      if (!(1 == 1))
        ProfileMenu(
            title: 'Fee Payment',
            icon: Assets.image.feePayment.svg(),
            onTap: () {
              Navigator.pushNamed(context, FeePaymentSummary.path,
                  arguments: 'Fee Payment');
            }),
      ProfileMenu(
        title: 'About',
        icon: Assets.image.about.svg(),
        onTap: () {
          Navigator.push(
              AppConstants.globalNavigatorKey.currentContext!,
              MaterialPageRoute(
                builder: (context) => WebViewScreen(
                  controller: WebViewController()
                    ..setJavaScriptMode(JavaScriptMode.unrestricted)
                    ..setBackgroundColor(const Color(0xFFFFFFFF))
                    ..loadRequest(
                        Uri.parse('${getEnvironment().domainUrl}/#about')),
                  showAppbar: true,
                  title: 'About',
                ),
              ));
          // launchUrl(Uri.parse('${getEnvironment().domainUrl}/#about'));
          // Navigator.pushNamed(context, AboutScreen.path);
        },
      ),
      ProfileMenu(
        title: 'FAQ',
        icon: Assets.image.faq.svg(),
        onTap: () {
          Navigator.push(
              AppConstants.globalNavigatorKey.currentContext!,
              MaterialPageRoute(
                builder: (context) => WebViewScreen(
                  controller: WebViewController()
                    ..setJavaScriptMode(JavaScriptMode.unrestricted)
                    ..setBackgroundColor(const Color(0xFFFFFFFF))
                    ..loadRequest(
                        Uri.parse('${getEnvironment().domainUrl}/#faq')),
                  showAppbar: true,
                  title: 'FAQ',
                ),
              ));
          // Navigator.pushNamed(context, FaqScreen.path);
          // launchUrl(Uri.parse('${getEnvironment().domainUrl}/#faq'));
        },
      ),
      ProfileMenu(
        title: 'Rewards',
        icon: Assets.image.reward.svg(),
        onTap: () {
          if (AppConstants.loggedUser?.role == 'student' ||
              AppConstants.loggedUser?.role == 'kid') {
            Navigator.pushNamed(context, RewardsScreen.path);
          } else {
            SnackBarCustom.success(
                'You do not have provision to enter as a parent');
          }
        },
      ),
      ProfileMenu(
        title: 'Certificates',
        icon: Assets.image.certificate.svg(),
        onTap: () async {
          Navigator.pushNamed(
            AppConstants.globalNavigatorKey.currentContext!,
            CertificatesListScreen.path,
          );
          // /  final DioClient dioClient = di.sl<DioClient>();

          // try {
          //   await dioClient
          //       .get(
          //     Urls.rewardsUrl,
          //   )
          //       .then((value) async {
          //     if (await canLaunchUrl(Uri.parse(''))) {
          //       await launchUrl(Uri.parse(''));
          //     } else {
          //       SnackBarCustom.success('Failed to load certificate');
          //     }
          //   });
          // } catch (e) {
          //   SnackBarCustom.success('Failed to load certificate');
          // }
        },
      ),
      ProfileMenu(
        title: 'Downloads',
        icon: SvgPicture.asset('assets/image/downloads_svg_sam.svg'),
        onTap: () {
          // Navigator.pushNamed(
          //   context,
          //   SavedVideoScreen.path,
          // );

          Navigator.pushNamed(
            AppConstants.globalNavigatorKey.currentContext!,
            SavedVideoScreen.path,
          );
        },
      ),
      ProfileMenu(
          title: 'Share with friends',
          icon: Assets.image.shareProfile.svg(),
          onTap: () async {
            Share.share('Samastha download link');
          }),
      ProfileMenu(
        title: 'Support',
        icon: Assets.image.support.svg(),
        onTap: () {
    
          Navigator.push(
              AppConstants.globalNavigatorKey.currentContext!,
              MaterialPageRoute(
                builder: (context) => WebViewScreen(
                  controller: WebViewController()
                    ..setJavaScriptMode(JavaScriptMode.unrestricted)
                    ..setBackgroundColor(const Color(0xFFFFFFFF))
                    ..loadRequest(
                        Uri.parse('${getEnvironment().domainUrl}/#contact')),
                  showAppbar: true,
                  title: 'Support',
                ),
              ));


      
        
        // launchUrl(Uri.parse('${getEnvironment().domainUrl}/#contact'));
        },
      ),
      // ProfileMenu(
      //   title: 'Cart',
      //   icon: Assets.image.support.svg(),
      //   onTap: () {
      //     Navigator.pushNamed(context, CartScreen.path);
      //   },
      // ),
      ProfileMenu(
        title: 'Delete account',
        icon: Assets.svgs.kids.deleteAccountIcon.svg(),
        onTap: () {
          AlertBoxWidgets.deleteAccount(
            'Delete Account ?',
            'Are you sure that you want to delete this account ? This process \ncan’t be undone',
            'Delete',
            context,
            onTap: (loader) async {
              // var response = await bloc.deleteAccount();
              // showErrorMessage(response.message ?? '');
              // Navigator.pop(context);
              //  if (response.status ?? false) {
              AuthBloc().logout();
              //}
            },
          );
        },
      ),
      ProfileMenu(
          title: 'Logout',
          icon: Assets.image.logout.svg(),
          onTap: () {
            AlertBoxWidgets.logout(
                "Logout",
                'You are logging out from\nsamastha e-learning app',
                'فى أمان الله',
                context);
          }),
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log('role on the app is ${AppConstants.loggedUser?.role}');
    return Scaffold(
      bottomNavigationBar: Container(
        // padding: EdgeInsets.only(bottom: MediaQuery.paddingOf(context).bottom),
        height: 139,
        color: const Color(0xff1696BB),
        alignment: Alignment.topCenter,
        child: Padding(
          padding: const EdgeInsets.only(top: 12.0, bottom: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'V 1.3.0',
                style: labelMedium.white.copyWith(fontWeight: FontWeight.bold),
              ),
              const Gap(5),
              const SizedBox(
                height: 20,
                child: VerticalDivider(
                  color: Colors.white,
                  thickness: 1,
                ),
              ),
              const Gap(5),
              Text(
                'Samastha E-Learning',
                style: labelMedium.white,
              ),
              const Gap(5),
              const SizedBox(
                height: 20,
                child: VerticalDivider(
                  color: Colors.white,
                  thickness: 1,
                ),
              ),
              const Gap(5),
              Text(
                'SKIMVB',
                style: labelMedium.white,
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Assets.image.myProfileBg
                .image(fit: BoxFit.cover, width: double.infinity),
            SafeArea(
              top: true,
              child: Column(
                children: [
                  // search bar
                  SimpleAppBar(
                    title: 'My Profile',
                    bgColor: Colors.transparent,
                    textStyle: titleLarge.white,
                    leadingWidget: const Icon(
                      Icons.arrow_back,
                      color: Colors.transparent,
                    ),
                    // InkWell(
                    //   onTap: () => Navigator.pop(context),
                    //   child: Padding(
                    //     padding: const EdgeInsets.all(16).copyWith(right: 0),
                    //     child: Assets.svgs.arrrowBack.svg(
                    //       color: ColorResources.WHITE,
                    //     ),
                    //   ),
                    // ),
                  ),

                  Column(
                    children: [
                      Padding(
                        padding: pagePadding.copyWith(top: 0, bottom: 30),
                        child: Column(
                          children: [
                            // const Gap(17),
                            FutureBuilder(
                                future: isStudent ? profileFuture : userFuture,
                                builder: (context, snapshot) {
                                  StudentProfileModel? studentModel =
                                      isStudent ? snapshot.data : null;
                                  UserDetailsModel? userModel =
                                      isStudent ? null : snapshot.data;
                                  var imageUrl = isStudent
                                      ? studentModel?.image
                                      : userModel?.image;
                                  // AppConstants.appTitle;
                                  return Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () async {
                                          ImageSource? source =
                                              await AlertBoxWidgets.getSource(
                                                  context);
                                          if (source != null) {
                                            File? file = await pickImage(
                                              source,
                                              enableCrop: true,
                                            );

                                            if (file != null) {
                                              bloc
                                                  .updateProfilePic(file.path)
                                                  .then((value) {
                                                if (value.status ?? false) {
                                                  setState(() {
                                                    profileFuture =
                                                        bloc.fetchProfile();
                                                    userFuture =
                                                        userbloc.viewProfile(
                                                            AppConstants
                                                                .loggedUser!
                                                                .id!);
                                                    // photoFile = file;
                                                  });
                                                }
                                              });
                                            }
                                          }
                                        },
                                        child: Stack(
                                          alignment: Alignment.bottomCenter,
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  bottom: 10),
                                              height: 148,
                                              width: 148,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: const Color.fromRGBO(
                                                      217, 217, 217, 1),
                                                  border: Border.all(
                                                      color: Colors.white,
                                                      width: 2)),
                                              child: imageUrl != null
                                                  ? UserAvatar(
                                                      path: imageUrl, size: 138)
                                                  : Assets.image.user.image(),
                                            ),
                                            Assets.image.profileCamera
                                                .image(height: 32)
                                          ],
                                        ),
                                      ),
                                      Text(
                                        !(isStudent)
                                            ? (userModel?.name ?? '')
                                            : (studentModel?.name ?? ''),
                                        style: button.darkBG,
                                        textAlign: TextAlign.center,
                                      ),
                                      const Gap(9),
                                      if (isStudent)
                                        Text(
                                          'Batch : ${studentModel?.batchName ?? ''}',
                                          style: labelMedium.primary,
                                          textAlign: TextAlign.center,
                                        ),
                                    ],
                                  );
                                }),
                            const Gap(40),
                            ...menu.map(
                              (e) => GestureDetector(
                                onTap: e.onTap,
                                child: Container(
                                  decoration: const BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              width: 1,
                                              color: Color(0xffE6E6E6)))),
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 18),
                                  child: Row(
                                    children: [
                                      e.icon,
                                      const Gap(16),
                                      Text(
                                        e.title,
                                        style: labelSmall.copyWith(
                                          fontSize: 16,
                                          color: ColorResources.GREY1,
                                        ),
                                      ),
                                      const Spacer(),
                                      RotatedBox(
                                          quarterTurns: 2,
                                          child: Assets.svgs.arrrowBack.svg(
                                            height: 16,
                                            color: ColorResources.GREY1,
                                          ))
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
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
    );
  }
}

class ProfileMenu {
  final String title;
  final SvgPicture icon;
  final Function()? onTap;

  ProfileMenu({required this.title, required this.icon, this.onTap});
}
