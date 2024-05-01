import 'package:flutter/material.dart';

class DashedLine extends StatelessWidget {
  final double height;
  final double heightContainer;
  final Color color;

  const DashedLine(
      {super.key, this.height = 3, this.color = Colors.black, this.heightContainer = 70});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: heightContainer,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final boxHeight = constraints.constrainHeight();
          const dashWidth = 10.0;
          final dashHeight = height;
          final dashCount = (boxHeight / (2 * dashHeight)).floor();
          return Flex(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            direction: Axis.horizontal,
            children: List.generate(dashCount, (_) {
              return SizedBox(
                width: dashWidth,
                height: dashHeight,
                child: DecoratedBox(
                  decoration: BoxDecoration(color: color),
                ),
              );
            }),
          );
        },
      ),
    );
  }
}
