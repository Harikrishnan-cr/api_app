import 'dart:developer';
import 'dart:io';
import 'dart:ui';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart' hide Image;
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:get_storage/get_storage.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:samastha/core/app_constants.dart';
import 'package:samastha/core/update_fcm.dart';
import 'package:samastha/core/video_local_storage.dart';
import 'package:samastha/modules/authentication/bloc/auth_bloc.dart';
import 'package:samastha/modules/parent/controller/get_local_videos_controller.dart';
import 'package:samastha/widgets/custom_snackbar.dart';

import '../gen/assets.gen.dart';
import '../theme/color_resources.dart';
import '../theme/t_style.dart';
import 'custom_form_elements.dart';

class AlertBoxWidgets {
  void openDialog(BuildContext context, Widget content,
          {Alignment? alignment}) =>
      showDialog(
          barrierColor: const Color.fromRGBO(
            0,
            0,
            0,
            0.5,
          ),
          context: context,
          builder: (context) => BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Dialog(
                  insetPadding: const EdgeInsets.symmetric(horizontal: 17),
                  alignment: alignment,
                  elevation: 0.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)),
                  backgroundColor: Colors.white,
                  child: SingleChildScrollView(child: content))));

  static confirmationDialog(
      String title, String content, String okButtonText, BuildContext context,
      {void Function()? onTap, Color? okButtonColor}) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(title,
                textAlign: TextAlign.center, style: headlineLarge.black),
            const SizedBox(height: 15),
            const Divider(),
            Text(content,
                textAlign: TextAlign.center, style: headlineLarge.black),
            const SizedBox(height: 15),
            const Divider(),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context, ConditionalType.no);
                  },
                  child: Container(
                    color: Colors.white,
                    width: 100,
                    alignment: Alignment.center,
                    child: Text(
                      "Cancel",
                      style: headlineLarge.black,
                    ),
                  ),
                ),
                InkWell(
                  onTap: onTap ??
                      () async {
                        Navigator.pop(context, ConditionalType.yes);
                      },
                  child: Container(
                    color: Colors.white,
                    width: 100,
                    alignment: Alignment.center,
                    child: Text(
                      okButtonText,
                      style:
                          headlineLarge.primary.copyWith(color: okButtonColor),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  static deleteAccount(
      String title, String content, String okButtonText, BuildContext context,
      {void Function(void Function({bool? isLoading}))? onTap}) {
    return showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(title,
                  textAlign: TextAlign.center, style: headlineLarge.darkBG),
              const SizedBox(height: 15),
              // const Divider(),
              Text(content,
                  textAlign: TextAlign.center,
                  style: bodyMedium.grey1.copyWith(fontSize: 14)),
              const SizedBox(height: 15),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomOutlineButton(
                    'Cancel',
                    width: 120,
                    height: 42,
                    borderColor: ColorResources.primary,
                    textColor: ColorResources.primary,
                    textStyle: button.copyWith(fontSize: 16),
                    onTap: (val) {
                      Navigator.pop(context);
                      // AuthBloc().logout();
                    },
                  ),
                  const Gap(12),
                  SubmitButton(
                    'Delete',
                    width: 120,
                    height: 42,
                    hasGradient: false,
                    backgroundColor: ColorResources.RED,
                    textColor: ColorResources.WHITE,
                    textStyle: button.copyWith(fontSize: 16),
                    onTap: onTap,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  static deleteLocalVideo(
      String title, String content, String okButtonText, BuildContext context,
      {void Function(void Function({bool? isLoading}))? onTap,
      int? materialID,
      File? dleteFileLocal}) {
    return showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(title,
                  textAlign: TextAlign.center, style: headlineLarge.darkBG),
              const SizedBox(height: 15),
              // const Divider(),
              Text(content,
                  textAlign: TextAlign.center,
                  style: bodyMedium.grey1.copyWith(fontSize: 14)),
              const SizedBox(height: 15),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomOutlineButton(
                    'Cancel',
                    width: 120,
                    height: 42,
                    borderColor: ColorResources.primary,
                    textColor: ColorResources.primary,
                    textStyle: button.copyWith(fontSize: 16),
                    onTap: (val) {
                      Navigator.pop(context);
                      // AuthBloc().logout();
                    },
                  ),
                  const Gap(12),
                  SubmitButton(
                    'Delete',
                    width: 120,
                    height: 42,
                    hasGradient: false,
                    backgroundColor: ColorResources.RED,
                    textColor: ColorResources.WHITE,
                    textStyle: button.copyWith(fontSize: 16),
                    onTap: (loader) async {
                      try {
                        log('path is ${dleteFileLocal?.path}');
                        dleteFileLocal?.delete().then((value) async {
                          await VideoDownlaodLocalClass.deleteLocalVidoe(
                                  materialID ?? 0)
                              .whenComplete(() {
                            Provider.of<GetLocalVideoController>(context,
                                    listen: false)
                                .getLoaclVideos();
                            SnackBarCustom.success(
                                'video deleted successfully');
                            Navigator.pop(context);
                          });
                        });
                      } catch (e) {
                        Navigator.pop(context);
                        SnackBarCustom.success(
                            'Error occurred while deleting the video please try again after some times');
                      }
                      // try {
                      //   await dleteFileLocal?.delete().whenComplete(() {
                      //     Navigator.pop(context);

                      //     SnackBarCustom.success('video deleted successfully');
                      //   });
                      // } catch (e) {
                      //   Navigator.pop(context);

                      //   SnackBarCustom.success(
                      //       'something went wrong please try again after some time');
                      // }
                      // final resp =
                      //   Navigator.pop(context);
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  static logout(
      String title, String content, String okButtonText, BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(title,
                  textAlign: TextAlign.center, style: headlineLarge.grey1),
              const SizedBox(height: 15),
              const Divider(),
              Text(content,
                  textAlign: TextAlign.center, style: bodyMedium.grey1),
              const SizedBox(height: 15),
              const SizedBox(height: 15),
              SubmitButton(
                okButtonText,
                onTap: (val) async {
                  await Provider.of<FcmTokenProvider>(context).deleteFcmToken();
                  final box = GetStorage();
                  box.write(AppConstants.isParentLogedIn, false);
                  AuthBloc().logout();
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  static welcomeNote(BuildContext context) {
    var assalamualaikum = 'السلام عليكم';
    var waalaikumussalam = 'وعليكم السلام ورحمة الله';
    bool isClickedOnce = false;
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => Dialog(
        // backgroundColor: Colors.amber,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: StatefulBuilder(builder: (context, state) {
          if (isClickedOnce) {
            // AppConstants.loggedUser?.role == ''
            Future.delayed(const Duration(milliseconds: 500))
                .whenComplete(() => Navigator.pop(context));
          }
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 20),
                Image.asset(
                  'assets/image/salam_png.png',
                  height: 150,
                ),
                // Assets.image.handshake.image(height: 150),
                const SizedBox(height: 20),
                !isClickedOnce
                    ? SubmitButton(
                        isClickedOnce ? waalaikumussalam : assalamualaikum,
                        onTap: (val) {
                          if (isClickedOnce) {
                            Navigator.pop(context);
                          } else {
                            // final fcmToken =
                            // //     await FirebaseMessaging.instance.getToken();
                            // // log(fcmToken.toString());
                            state(
                              () {
                                isClickedOnce = true;
                              },
                            );
                          }
                        },
                      )
                    : SizedBox(
                        child: Text(
                          waalaikumussalam,
                          style: button.copyWith(color: ColorResources.primary),
                        ),
                      )
              ],
            ),
          );
        }),
      ),
    );
  }

  upgradePlan(
    BuildContext context,
  ) {
    return openDialog(
      context,
      Container(
        padding: const EdgeInsets.all(16).copyWith(bottom: 0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Upgrade Your Plan",
                  style: bodySmall.black,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  // child: Assets.icon.ciCloseBig.svg()
                )
              ],
            ),
            const Gap(57),
            //  Assets.icon.upgradePlan.svg(),
            const Gap(24),
            Text(
              'You are using free account, it will ends in 7 days please purchase our membership for full feature',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: ColorResources.grey),
            ),
            const Gap(31),
            SizedBox(
                width: double.infinity,
                child: SubmitButton(
                  'Purchase',
                  onTap: (value) {},
                )),
            const Gap(20)
          ],
        ),
      ),
      alignment: Alignment.bottomCenter,
    );
  }

  static modalBottomSheet(
      {required BuildContext context,
      required Widget Function(
        BuildContext,
      ) builder,
      // required Widget Function(BuildContext, void Function(void Function()))
      //     builder,
      String? title,
      VoidCallback? callback}) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      enableDrag: true,
      builder: (context) => SingleChildScrollView(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            decoration: const BoxDecoration(
                color: ColorResources.WHITE,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8), topRight: Radius.circular(8))),
            constraints: BoxConstraints(
              maxHeight:
                  MediaQuery.of(context).size.height - kToolbarHeight * 2,
            ),
            child: ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  if (title != null) ...[
                    Padding(
                      padding: pagePadding.copyWith(bottom: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            title,
                            style: bodySmall.black,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Icon(Icons.close),
                          )
                        ],
                      ),
                    ),
                    const Divider(),
                  ],
                  Builder(
                    builder: builder,
                  ),
                ]),
          )
          // }),
          ),
    );
  }

  static Future<DateTime?> openDatePicker(BuildContext context,
      DateTime initialDate, bool pickFromFuture, String hintText,
      {bool enableAllDays = false,
      DateTime? firstDate,
      DateTime? lastDate}) async {
    DateTime oldDate = DateTime.parse('1900-01-01');
    DateTime futureDate = DateTime.now().add(const Duration(days: 365 * 4));
    return await showDatePicker(
      context: context,
      initialDate: initialDate,
      locale: const Locale('en', 'IN'),
      firstDate: firstDate ??
          (enableAllDays
              ? oldDate
              : (pickFromFuture ? DateTime.now() : oldDate)),
      lastDate: lastDate ??
          (enableAllDays
              ? futureDate
              : (pickFromFuture ? futureDate : DateTime.now())),
      helpText: hintText,
      builder: (context, child) {
        return Theme(
          data: ColorResources.datePickerTheme,
          child: child!,
        );
      },
    );
  }

  static Future<DateTimeRange?> openDateRangePicker(BuildContext context,
      DateTime initialDate, bool pickFromFuture, String hintText,
      {bool enableAllDays = false}) async {
    DateTime oldDate = DateTime.parse('1900-01-01');
    DateTime futureDate = DateTime.now().add(const Duration(days: 365 * 4));
    return await showDateRangePicker(
      context: context,
      currentDate: initialDate,
      locale: const Locale('en', 'IN'),
      firstDate:
          enableAllDays ? oldDate : (pickFromFuture ? DateTime.now() : oldDate),
      lastDate: enableAllDays
          ? futureDate
          : (pickFromFuture ? futureDate : DateTime.now()),
      helpText: hintText,
      builder: (context, child) {
        return Theme(
          data: ColorResources.datePickerTheme,
          child: child!,
        );
      },
    );
  }

  static Future<ImageSource?> getSource(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (context) => Dialog(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        insetPadding: const EdgeInsets.symmetric(horizontal: 26),
        child: SizedBox(
          height: 120,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    return Navigator.pop(context, ImageSource.camera);
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.camera_alt_rounded,
                        size: 48,
                      ),
                      // const Gap(14),
                      Text(
                        'Camera',
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
                    return Navigator.pop(context, ImageSource.gallery);
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.photo_library_sharp,
                        size: 48,
                      ),
                      // const Gap(14),
                      Text(
                        'Gallery',
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
  }
}

enum ConditionalType { yes, no }
