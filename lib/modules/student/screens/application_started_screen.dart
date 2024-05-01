import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:samastha/gen/assets.gen.dart';
import 'package:samastha/main.dart';
import 'package:samastha/modules/student/bloc/admission_bloc.dart';
import 'package:samastha/modules/student/models/student_register_model.dart';
import 'package:samastha/modules/student/screens/application_completed_screen.dart';
import 'package:samastha/theme/color_resources.dart';
import 'package:samastha/theme/t_style.dart';
import 'package:samastha/utils/snackbar_utils.dart';
import 'package:samastha/widgets/app_bars_custom.dart';
import 'package:samastha/widgets/custom_form_elements.dart';
import 'package:samastha/widgets/custom_snackbar.dart';
import 'package:share_plus/share_plus.dart';

class ApplicationStartedScreen extends StatelessWidget {
  const ApplicationStartedScreen({super.key, this.model});
  static const String path = '/application-started-screen';
  final StudentRegisterModel? model;

  static List<String> paymentSteps = [
    "Copy application number.",
    "Proceed to payment page.",
    "Add application number",
    "add phone number",
    "Make payment",
    "Click share button, and make direct payment using the link"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SimpleAppBar(title: 'Complete Payment'),
      body: SingleChildScrollView(
        padding: pagePadding,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                // border: Border.all(width: 1, color: Colors.white),
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
                    "Your Application has started",
                    style: headlineLarge.white,
                  ),
                  const Gap(1),
                  Text(
                    'Application Number : ${model?.applicationNumber ?? ''}',
                    style: labelMedium.white,
                  ),
                  const Gap(18),
                  SubmitButton.primary(
                    'Check Payment status',
                    textStyle: button,
                    textColor: ColorResources.secondary,
                    backgroundColor: Colors.white,
                    hasGradient: false,
                    onTap: (loader) {
                      AdmissionBloc()
                          .checkPayment(model?.applicationNumber ?? '')
                          .then((value) {
                        if (value == "completed" || value == "success") {
                          Navigator.popAndPushNamed(
                              context, ApplicationCompletedScreen.path,
                              arguments: model);
                          SnackBarCustom.success('Payment completed');
                        } else {
                          SnackBarCustom.success(
                              'Payment is due for the admission pay in online');
                        }
                      }).onError((error, stackTrace) {
                        showErrorMessage(error.toString());
                      });
                    },
                  ),
                  const Gap(18),
                  Center(
                    child: Text(
                      'OR',
                      style: titleLarge.white,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const Gap(18),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              const Color(0xffD4F6FF).withOpacity(.3),
                              const Color(0xffF0F0F0).withOpacity(.1),
                            ]),
                        border: Border.all(
                            width: 1,
                            color: const Color(0xffD4F6FF).withOpacity(.5)),
                        borderRadius: BorderRadius.circular(12)),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Copy application number',
                                style: labelMedium.white,
                              ),
                              Text(
                                model?.applicationNumber ?? '',
                                style: titleLarge.white,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              )
                            ],
                          ),
                        ),
                        GestureDetector(
                            onTap: () async {
                              if (model?.applicationNumber != null) {
                                await Clipboard.setData(
                                  ClipboardData(
                                      text: model!.applicationNumber!),
                                );
                                SnackBarCustom.success('Copied to clipboard');
                              }
                            },
                            child: Assets.image.copy.image(height: 24)),
                        const Gap(14), 
                        GestureDetector(
                            onTap: () {
                              Share.share(
                                  '${getEnvironment().domainUrl}/userpay/${model?.applicationNumber ?? ""}');
                              //remove this line if any in-app payment issue arises, and share only the application no.
                            },
                            child: Assets.image.share.image(height: 24)),
                      ],
                    ),
                  ),
                  const Gap(16),
                  Text(
                    'Steps',
                    style: titleSmall.white,
                  ),
                  const Gap(8),
                  ...paymentSteps.map((e) => Padding(
                        padding: const EdgeInsets.only(bottom: 6),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${paymentSteps.indexOf(e) + 1}. ',
                              style: bodyMedium.white,
                            ),
                            const Gap(4),
                            Expanded(
                                child: Text(
                              e,
                              style: bodyMedium.white,
                            )),
                          ],
                        ),
                      )),
                  const Gap(9),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
