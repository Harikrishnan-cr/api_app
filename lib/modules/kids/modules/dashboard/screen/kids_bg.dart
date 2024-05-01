import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:samastha/gen/assets.gen.dart';

class KidsBg extends StatelessWidget {
  const KidsBg({super.key, this.isHomeScreen, this.isEnableNav});
  final bool? isHomeScreen;
  final bool? isEnableNav;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                height: double.maxFinite,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.fromARGB(255, 255, 255, 255),
                      Color.fromARGB(255, 255, 255, 255),
                      Color.fromARGB(255, 255, 255, 255),
                      Color.fromARGB(255, 255, 255, 255),
                      Color(0xffC5E4CF),
                      Color(0xff75D9C7),
                      Color(0xff75D9C7),
                    ],
                  ),
                ),
              ),
              // Image at the bottom
              Positioned(
                bottom: 0,
                child: Padding(
                  padding: EdgeInsets.only(
                      bottom: (isHomeScreen ?? true) ? 91.0 : 0.0),
                  child: Assets.image.kids.mosqueWithoutBg.image(),
                  // child: Assets.svgs.kids.mosque.svg(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
