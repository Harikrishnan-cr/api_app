import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:samastha/theme/color_resources.dart';
import 'package:samastha/theme/t_style.dart';
import 'package:samastha/widgets/app_bars_custom.dart';
import 'package:samastha/widgets/custom_form_elements.dart';

class QuizSolutionsScreen extends StatelessWidget {
  const QuizSolutionsScreen({super.key, required this.solutions});
  static const String path = '/solutions-screen';
  final String solutions;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(title: 'Solution', trailing: [
        IconButton(onPressed: () {}, icon: const Icon(Icons.add))
      ]),
      bottomNavigationBar: Padding(
        padding: pagePadding.copyWith(bottom: 20),
        child: CustomOutlineButton('Go Back', onTap: (loader) {
          Navigator.pop(context);
        }, textColor: Colors.white, bgColor: ColorResources.secondary),
      ),
      body: Builder(builder: (context) {
        if (solutions.isEmpty) {
          return const Center(
            child: Text('No Solutions'),
          );
        }
        return SingleChildScrollView(
          padding: pagePadding.copyWith(bottom: 20),
          child: Html(
            data: solutions,
          ),
        );
      }),
    );
  }
}
