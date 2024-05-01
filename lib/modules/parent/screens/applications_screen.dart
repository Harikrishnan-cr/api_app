import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:samastha/gen/assets.gen.dart';
import 'package:samastha/modules/parent/model/application_model.dart';
import 'package:samastha/modules/student/bloc/admission_bloc.dart';
import 'package:samastha/modules/student/bloc/viva_controller.dart';
import 'package:samastha/modules/student/models/student_register_model.dart';
import 'package:samastha/modules/student/models/viva_call_model.dart';
import 'package:samastha/modules/student/screens/application_started_screen.dart';
import 'package:samastha/modules/student/screens/mcq/mcq_welcome_screen.dart';
import 'package:samastha/modules/student/screens/viva/viva_appoinmet_booking_screen.dart';
import 'package:samastha/theme/color_resources.dart';
import 'package:samastha/theme/t_style.dart';
import 'package:samastha/utils/error_reload.dart';
import 'package:samastha/widgets/app_bars_custom.dart';
import 'package:samastha/widgets/custom_snackbar.dart';
import 'package:samastha/widgets/default_loading_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class MyApplicationsScreen extends StatefulWidget {
  const MyApplicationsScreen({super.key});
  static const String path = '/my-applications';

  @override
  State<MyApplicationsScreen> createState() => _MyApplicationsScreenState();
}

class _MyApplicationsScreenState extends State<MyApplicationsScreen> {
  AdmissionBloc bloc = AdmissionBloc();

  late Future<List<ApplicationModel>> future;

  @override
  void initState() {
    future = bloc.fetchApplications();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SimpleAppBar(title: 'My Applications'),
      body: FutureBuilder<List<ApplicationModel>>(
          future: future,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Assets.image.noApllications.image(width: 150),
                    const Gap(15),
                    Text('There are no applications to show',
                        style: titleLarge.darkBG),
                  ],
                ),
              );
              return errorReload(snapshot.error.toString(), onTap: () {
                setState(() {
                  future = bloc.fetchApplications();
                });
              });
            }
            switch (snapshot.connectionState) {
              case ConnectionState.active:
              case ConnectionState.done:
                return snapshot.data!
                        .where((element) => element.status != 'active')
                        .toList()
                        .isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Assets.image.noApllications.image(width: 150),
                            const Gap(15),
                            Text('There are no applications to show',
                                style: titleLarge.darkBG),
                          ],
                        ),
                      )
                    : RefreshIndicator(
                        onRefresh: () async {
                          future = bloc.fetchApplications();
                          await bloc.fetchApplications();
                          setState(() {});
                        },
                        child: ListView(
                          padding: pagePadding.copyWith(bottom: 20),
                          children: [
                            for (ApplicationModel item in snapshot.data
                                    ?.where(
                                        (element) => element.status != 'active')
                                    .toList() ??
                                [])
                              InkWell(
                                onTap: () async {
                                  print('item.image ${item.image}');
                                  switch (item.status) {
                                    case "pending":
                                      break;
                                    case "exam_pending":
                                      Navigator.pushNamed(
                                        context,
                                        MCQWelcomeScreen.path,
                                        //user id (student id)
                                        arguments: item.id,
                                      );
                                      break;
                                    case 'viva_pending':
                                      Navigator.pushNamed(
                                        context,
                                        AppointmentBookingScreen.path,
                                        arguments: item.id,
                                      );
                                      break;
                                    case 'payment_pending':
                                      //payment link open
                                      Navigator.pushNamed(context,
                                          ApplicationStartedScreen.path,
                                          arguments: StudentRegisterModel(
                                              applicationNumber:
                                                  item.applicationNumber,
                                              isFirstStd: item.isFirstStd,
                                              fkUserId: item.id));
                                      break;
                                    case 'active':
                                      break;
                                    case 'terminated':
                                      break;
                                    case 'supended':
                                      break;
                                    case 'move_to_another_batch':
                                      break;
                                    case 'viva_scheduled':
                                      //check viva call api
                                      try {
                                        VivaController vivaBloc =
                                            VivaController();
                                        VivaCallModel? result = await vivaBloc
                                            .vivaCall(item.id, item.dataId);
                                        if (result != null &&
                                            result.zoomLink != null) {
                                          //open zoom in browser
                                          final Uri url =
                                              Uri.parse(result.zoomLink!);
                                          try {
                                            launchUrl(url).then((value) async {
                                              debugPrint('lauch finished');
                                              Navigator.pop(context);
                                              await vivaBloc.submitViva(
                                                  item.id, item.dataId);
                                            }).onError((error, stackTrace) {
                                              SnackBarCustom.success(
                                                  'Error opening zoom link');
                                              debugPrint('erro: $error');
                                              // return false;
                                            });
                                            //viva submit api call
                                          } catch (e) {
                                            SnackBarCustom.success(
                                                'Error opening zoom link');
                                          }
                                        }
                                      } catch (e) {
                                        SnackBarCustom.success(e.toString());
                                      }

                                      break;
                                    default:
                                  }
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(bottom: 16),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    color: Colors.white,
                                  ),
                                  padding: const EdgeInsets.all(12),
                                  child: Row(
                                    children: [
                                      // item.image == null ?
                                      CircleAvatar(
                                        radius: 58 / 2,
                                        backgroundColor:
                                            ColorResources.PLACEHOLDER,
                                        // child: ImageViewer(path: item.image),
                                        backgroundImage: item.image == null
                                            ? Image.asset(
                                                    Assets.image.user.keyName)
                                                .image
                                            : Image.network(
                                                item.image!,
                                                fit: BoxFit.cover,
                                                errorBuilder: (context, object,
                                                        stackTrace) =>
                                                    Assets.image.user.image(),
                                              ).image, //todo - use ImageProvider here
                                      ),
                                      // : UserAvatar(path: item.image,size: 58),
                                      const Gap(16),
                                      Expanded(
                                          child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            item.name ?? "",
                                            style: titleSmall.darkBG,
                                          ),
                                          const Gap(6),
                                          if (item.status != null &&
                                              item.status!.isNotEmpty)
                                            Text(
                                              toBeginningOfSentenceCase(item
                                                  .status!
                                                  .replaceAll('_', ' '))!,
                                              style: bodyMedium.primary,
                                            ),
                                        ],
                                      ))
                                    ],
                                  ),
                                ),
                              )
                          ],
                        ),
                      );
              case ConnectionState.waiting:
                return const LoadingWidget();
              default:
                return Container();
            }
          }),
    );
  }
}
