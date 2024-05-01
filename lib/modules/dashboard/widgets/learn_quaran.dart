import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:samastha/core/app_constants.dart';
import 'package:samastha/gen/assets.gen.dart';
import 'package:samastha/theme/t_style.dart';
import 'package:shimmer/shimmer.dart';


class LearnQuraanShimmer extends StatelessWidget {
  const LearnQuraanShimmer({
    super.key, this.title,
  });
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.black12,
      highlightColor: Colors.white,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title??'Courses',
                style: titleMedium.black,
              ),
              TextButton(
                  onPressed: () {},
                  child: Text(
                    "See All",
                    style: bodyMedium.primary,
                  ))
            ],
          ),
          const Gap(12),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  2,
                  1,
                  4,
                  3,
                ]
                    .map((e) => Container(
                          height: 282,
                          width: 282,
                          margin: const EdgeInsets.only(right: 20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(22),
                            image: DecorationImage(
                              image: AssetImage(
                                Assets.image.makka.path,
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                          alignment: Alignment.bottomLeft,
                          child: Stack(
                            alignment: Alignment.bottomLeft,
                            children: [
                              Container(
                                height: double.infinity,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(22),
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      const Color(0xffD1F5FF).withOpacity(0),
                                      e.isEven
                                          ? const Color(0xffDFFFCC)
                                          : const Color(0xffD4F4FF),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 16),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Fiqh',
                                      style: titleSmall.secondary,
                                    ),
                                    const Gap(4),
                                    Text(
                                      'Lorem Ipsum Dolor Sit amet Lorem Ipsum Dolor',
                                      style: bodyMedium.darkBG,
                                    ),
                                    const Gap(4),
                                    Row(
                                      children: [
                                        Text(
                                          '${AppConstants.rupeeSign} 1000',
                                          style: titleLarge.primary,
                                        ),
                                        const Spacer(),
                                        Row(
                                          children: [
                                            Assets.svgs.clock.svg(),
                                            const Gap(5),
                                            Text(
                                              '01 h 30 m',
                                              style: titleSmall.secondary,
                                            )
                                          ],
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ))
                    .toList()),
          )
        ],
      ),
    );
  }
}
