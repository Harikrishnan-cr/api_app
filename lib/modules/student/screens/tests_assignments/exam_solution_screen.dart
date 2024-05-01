import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:samastha/modules/student/bloc/exam_controller.dart';
import 'package:samastha/theme/color_resources.dart';
import 'package:samastha/theme/t_style.dart';
import 'package:samastha/utils/error_reload.dart';
import 'package:samastha/widgets/app_bars_custom.dart';
import 'package:samastha/widgets/custom_form_elements.dart';
import 'package:samastha/widgets/default_loading_widget.dart';

class ExamSolutionScreen extends StatefulWidget {
  const ExamSolutionScreen({super.key, required this.questionId});

  static const String path = '/exam-solution-screen';
  final int questionId;
  @override
  State<ExamSolutionScreen> createState() => _ExamSolutionScreenState();
}

class _ExamSolutionScreenState extends State<ExamSolutionScreen> {
  late Future<String> future;
  ExamController bloc = ExamController();

  @override
  void initState() {
    future = bloc.examQuestionSolution(widget.questionId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(title: 'Solution', trailing: [
        IconButton(
            onPressed: () {
              setState(() {
                future = bloc.examQuestionSolution(widget.questionId);
              });
            },
            icon: const Icon(Icons.add))
      ]),
      bottomNavigationBar: Padding(
        padding: pagePadding.copyWith(bottom: 20),
        child: CustomOutlineButton('Go Back', onTap: (loader) {
          Navigator.pop(context);
        }, textColor: Colors.white, bgColor: ColorResources.secondary),
      ),
      body: FutureBuilder<String>(
          future: future,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return errorReload(snapshot.error.toString(), onTap: () {
                setState(() {
                  future = bloc.examQuestionSolution(widget.questionId);
                });
              });
            }
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return const LoadingWidget();
              case ConnectionState.done:
              case ConnectionState.active:
                return SingleChildScrollView(
                  padding: pagePadding.copyWith(bottom: 20),
                  child: Html(
                    data: snapshot.data ?? '',
                  ),
                );
              default:
                return Container();
            }
          }),
    );
  }
}
