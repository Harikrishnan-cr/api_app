import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:samastha/theme/color_resources.dart';

class HomeCarousal extends StatefulWidget {
  const HomeCarousal({super.key, required this.image});
  final List<Widget> image;

  @override
  State<HomeCarousal> createState() => _HomeCarousalState();
}

class _HomeCarousalState extends State<HomeCarousal> {
  int current = 0;

  PageController pageController = PageController();

  // Timer? _timer;

  @override
  void initState() {
    // _timer =
    Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      if (current < widget.image.length - 1) {
        current++;
      } else {
        current = 0;
      }

      pageController.animateToPage(
        current,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeIn,
      );
    });
    pageController.addListener(() {
      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 150,
          child: PageView(
            controller: pageController,
            children: widget.image,
          ),
        ),
        const Gap(8),
        if (pageController.hasClients)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: widget.image.asMap().entries.map((entry) {
              return GestureDetector(
                child: Container(
                  width: 8.0,
                  height: 8.0,
                  margin: const EdgeInsets.symmetric(
                      vertical: 4.0, horizontal: 4.0),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: (pageController.page?.toInt() == entry.key
                              ? ColorResources.primary
                              : ColorResources.PLACEHOLDER)
                          .withOpacity(pageController.page?.toInt() == entry.key
                              ? 0.9
                              : 0.4)),
                ),
              );
            }).toList(),
          ),
      ],
    );
  }
}
