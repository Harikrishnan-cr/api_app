import 'package:flutter/material.dart';
import 'package:samastha/gen/assets.gen.dart';

import '../../../theme/color_resources.dart';

import '../../../widgets/custom_form_elements.dart';
import '../../general/bloc/core_bloc.dart';

class SplashScreen extends StatefulWidget {
  static const String path = "/splash-screen";
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Future.delayed(const Duration(seconds: 2), () {
        CoreBloc().findLandingPage(context);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.primary,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(),
            child: Center(
              child: Hero(
                tag: 'logo',
                child: Assets.image.logoLandscape
                    .image(color: Colors.white, height: 43),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 50.0),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: stoppedAnimationProgress(),
            ),
          ),
        ],
      ),
    );
  }
}
