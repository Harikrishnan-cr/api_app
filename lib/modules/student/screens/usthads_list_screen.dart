import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:samastha/core/isparent_loged_in_details.dart';
import 'package:samastha/gen/assets.gen.dart';
import 'package:samastha/modules/madrasa/controller/madrasa_controller.dart';
import 'package:samastha/modules/madrasa/models/usthad_model.dart';
import 'package:samastha/modules/student/screens/usthad_detail_screen.dart';
import 'package:samastha/theme/t_style.dart';
import 'package:samastha/utils/error_reload.dart';
import 'package:samastha/utils/signed_image_viewer.dart';
import 'package:samastha/widgets/app_bars_custom.dart';
import 'package:samastha/widgets/default_loading_widget.dart';
import 'package:samastha/widgets/double_arrow_list_tile.dart';

class UsthadsListScreen extends StatefulWidget {
  const UsthadsListScreen({super.key});
  static const String path = '/usthads-list';

  @override
  State<UsthadsListScreen> createState() => _UsthadsListScreenState();
}

class _UsthadsListScreenState extends State<UsthadsListScreen> {
  MadrasaController bloc = MadrasaController();

  late Future<List<UsthadModel>> future;

  @override
  void initState() {
    if (IsParentLogedInDetails.isParentLogedIn()) {
      future = bloc.fetchMentorsListParent();

      return;
    }
    future = bloc.fetchMentorsList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SimpleAppBar(title: 'Usthad Details'),
      body: FutureBuilder<List<UsthadModel>>(
          future: future,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Assets.svgs.noTutors.svg(),
                    Text('No tutors assigned', style: titleLarge.darkBG),
                    const Gap(50),
                  ],
                ),
              );
              return errorReload(snapshot.error.toString(), onTap: () {
                setState(() {
                  future = bloc.fetchMentorsList();
                });
              });
            }

            switch (snapshot.connectionState) {
              case ConnectionState.done:
                List<UsthadModel> data = snapshot.data ?? [];
                return ListView(
                  padding: pagePadding,
                  children: data.isEmpty
                      ? [
                          Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Assets.svgs.noTutors.svg(),
                                Text('No tutors assigned',
                                    style: titleLarge.darkBG),
                                const Gap(50),
                              ],
                            ),
                          )
                        ]
                      : data.map((e) {
                          return DoubleArrowListTile(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, UsthadDetailScreen.path,
                                  arguments: e.id);
                            },
                            icon: UserAvatar(
                              path: e.photoUrl ?? "",
                              size: 56,
                            ),
                            title: e.name ?? "",
                          );
                        }).toList(),
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
