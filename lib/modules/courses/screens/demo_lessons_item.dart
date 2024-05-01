import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:samastha/core/app_constants.dart';
import 'package:samastha/modules/courses/models/course_chapters_model.dart';
import 'package:samastha/theme/color_resources.dart';
import 'package:samastha/theme/t_style.dart';

class DemoLessonsItem extends StatelessWidget {
  const DemoLessonsItem( {
    super.key, required this.lesson,
  });
  final Lesson lesson;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            width: 1,
            color: const Color(0xffD7D7D7),
          )),
      child: Row(
        children: [
          Container(
            height: 22,
            width: 22,
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: ColorResources.primary),
            child: const Icon(
              Icons.play_arrow,
              color: ColorResources.WHITE,
              size: 16,
            ),
          ),
          const Gap(13),
          Expanded(
              child: Text(
            lesson.materialDetails ?? AppConstants.lorem,
            maxLines: 1,
            style: labelMedium.grey1,
          )),
          Text(
           lesson.courseDuration ?? '02:10',
            style: labelMedium.secondary,
          )
        ],
      ),
    );
  }
}
