import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:samastha/gen/assets.gen.dart';
import 'package:samastha/modules/student/bloc/admission_bloc.dart';
import 'package:samastha/modules/student/models/instruction_model.dart';
import 'package:samastha/modules/student/screens/high_class_join_registration_form.dart';
import 'package:samastha/theme/color_resources.dart';
import 'package:samastha/theme/t_style.dart';
import 'package:samastha/utils/error_reload.dart';
import 'package:samastha/widgets/app_bars_custom.dart';
import 'package:samastha/widgets/custom_form_elements.dart';
import 'package:samastha/widgets/default_loading_widget.dart';

class JoinHigherClassWelcomeScreen extends StatefulWidget {
  static const String path = '/join-higher-class-welcome-screen';
  const JoinHigherClassWelcomeScreen({super.key});

  @override
  State<JoinHigherClassWelcomeScreen> createState() =>
      _JoinHigherClassWelcomeScreenState();
}

class _JoinHigherClassWelcomeScreenState
    extends State<JoinHigherClassWelcomeScreen> {
  bool showWithTCIns = false;
  bool showWithOutTCIns = false;

  bool joinWithoutTCTermsAccepted = false;
  bool joinWithTCTermsAccepted = false;

  AdmissionBloc bloc = AdmissionBloc();

  late Future<List<List<String>?>> future =
      bloc.getAdmissionInstructionsList('join_tc');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SimpleAppBar(title: 'Join to a Higher class'),
      body: RefreshIndicator(
        onRefresh: () {
          return future = bloc.getAdmissionInstructionsList('join_tc');
        },
        child: FutureBuilder<List<List<String>?>>(
            future: future,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return errorReload(snapshot.error.toString(), onTap: () {
                  future = bloc.getAdmissionInstructionsList('join_tc');
                });
              }

              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return const LoadingWidget();

                case ConnectionState.done:
                  List<List<String>?> data = snapshot.data ?? [];
                  return SingleChildScrollView(
                    padding: pagePadding,
                    child: Column(
                      children: [
                        const Gap(25),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            // border: Border.all(width: 1, color: Colors.white),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 12,
                                offset: const Offset(0, 8),
                                spreadRadius: 0,
                                color: Colors.black.withOpacity(.1),
                              ),
                            ],
                            gradient: const LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Color(0xff1696BB),
                                  Color(0xff2FC5F0),
                                ]),
                            borderRadius: BorderRadius.circular(16),
                            image: DecorationImage(
                                image: AssetImage(
                                  Assets.image.curvedLines.path,
                                ),
                                opacity: .2,
                                fit: BoxFit.cover),
                          ),
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Join with TC',
                                // data.first?[0] ?? '', //title
                                style: headlineLarge.white,
                              ),
                              const Gap(1),
                              Text(
                                'from Madrasa Under SKIMVB',
                                // data.first?[0] ?? '', //subtitle
                                style: labelMedium.white,
                              ),
                              const Gap(12),
                              const Divider(
                                color: Colors.white,
                              ),
                              const Gap(12),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    showWithTCIns = !showWithTCIns;
                                  });
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Instructions',
                                      style: GoogleFonts.inter(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white),
                                    ),
                                    RotatedBox(
                                        quarterTurns: showWithTCIns ? 4 : 2,
                                        child: Assets.svgs.dropdown.svg(
                                            color: Colors.white, width: 12))
                                  ],
                                ),
                              ),
                              const Gap(12),
                              if (showWithTCIns)
                                ...data.first!.map((e) => Html(
                                      data: e,
                                      style: {
                                        "body": Style(color: Colors.white),
                                      },
                                    ))
                              // Padding(
                              //       padding: const EdgeInsets.only(
                              //           bottom: 3),
                              //       child: Text(
                              //         e.content.toString(),
                              //         style: bodyMedium.white,
                              //       ),
                              //     ))
                              ,
                              const Gap(9),
                              CupertinoButton(
                                onPressed: () {
                                  setState(() {
                                    joinWithTCTermsAccepted =
                                        !joinWithTCTermsAccepted;
                                  });
                                },
                                child: Row(
                                  children: [
                                    joinWithTCTermsAccepted
                                        ? Assets.svgs.boxChecked.svg(height: 12)
                                        : Assets.svgs.checkboxInactive.svg(),
                                    const Gap(8),
                                    Text(
                                      // data:
                                      "I have read & accept all instructions",
                                      // shrinkWrap: true,
                                      style: bodyMedium.white,
                                    )
                                  ],
                                ),
                              ),
                              const Gap(11),
                              if (joinWithTCTermsAccepted)
                                SubmitButton.primary(
                                  'continue',
                                  textStyle: button,
                                  textColor: ColorResources.secondary,
                                  backgroundColor: Colors.white,
                                  hasGradient: false,
                                  onTap: (loader) {
                                    Navigator.pushNamed(context,
                                        HighClassJoinRegistrationForm.path,
                                        arguments: true);
                                  },
                                ),
                            ],
                          ),
                        ),
                        const Gap(24),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 12,
                                  offset: const Offset(0, 8),
                                  spreadRadius: 0,
                                  color: Colors.black.withOpacity(.1))
                            ],
                            gradient: const LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Color(0xff129782),
                                  Color(0xff2BDDC1),
                                ]),
                            color: ColorResources.primary,
                            borderRadius: BorderRadius.circular(16),
                            image: DecorationImage(
                                image: AssetImage(
                                  Assets.image.curvedLines.path,
                                ),
                                opacity: .2,
                                fit: BoxFit.cover),
                          ),
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Join without TC',
                                // data.last?[0] ?? '', //title
                                style: headlineLarge.white,
                              ),
                              const Gap(1),
                              Text(
                                'from Offline Madrasa Under SKIMVB',
                                // data.last?[0] ?? '', //subtitle
                                style: labelMedium.white,
                              ),
                              const Gap(12),
                              const Divider(
                                color: Colors.white,
                              ),
                              const Gap(12),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    showWithOutTCIns = !showWithOutTCIns;
                                  });
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Instructions',
                                      style: GoogleFonts.inter(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white),
                                    ),
                                    RotatedBox(
                                        quarterTurns: showWithOutTCIns ? 4 : 2,
                                        child: Assets.svgs.dropdown.svg(
                                            color: Colors.white, width: 12))
                                  ],
                                ),
                              ),
                              const Gap(12),
                              if (showWithOutTCIns)
                                ...data.last!.map((e) => Html(
                                      data: e,
                                      style: {
                                        "body": Style(color: Colors.white),
                                      },
                                    ))
                              // Padding(
                              //       padding:
                              //           const EdgeInsets.only(bottom: 3),
                              //       child: Text(
                              //         '${e.content}',
                              //         style: bodyMedium.white,
                              //       ),
                              //     ))
                              ,
                              const Gap(9),
                              CupertinoButton(
                                onPressed: () {
                                  setState(() {
                                    joinWithoutTCTermsAccepted =
                                        !joinWithoutTCTermsAccepted;
                                  });
                                },
                                child: Row(
                                  children: [
                                    joinWithoutTCTermsAccepted
                                        ? Assets.svgs.boxChecked.svg(height: 12)
                                        : Assets.svgs.checkboxInactive.svg(),
                                    const Gap(8),
                                    Text(
                                      "I have read & accept all instructions",
                                      style: bodyMedium.white,
                                    )
                                  ],
                                ),
                              ),
                              const Gap(11),
                              if (joinWithoutTCTermsAccepted)
                                SubmitButton.primary(
                                  'continue',
                                  textStyle: button,
                                  textColor: ColorResources.secondary,
                                  backgroundColor: Colors.white,
                                  hasGradient: false,
                                  onTap: (loader) async {
                                    Navigator.pushNamed(context,
                                        HighClassJoinRegistrationForm.path,
                                        arguments: false);
                                  },
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );

                default:
                  return Container();
              }
            }),
      ),
    );
  }
}
