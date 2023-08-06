import 'package:base_flutter/base/base_screen/view/base_stateful_screen.dart';
import 'package:base_flutter/base/widgets/lottie_view.dart';
import 'package:flutter/material.dart';

import 'splash_controller.dart';

class SplashScreen extends BaseStatefulScreen<SplashController> {
  SplashScreen({super.key})
      : super(
          controller: SplashController(),
          withTicker: true,
        );

  @override
  Widget buildView(BuildContext context) {
    controller.context = context;
    return Scaffold(
      body: Center(
        child: LottieView(
          name: 'anim_splash',
          repeat: false,
          controller: controller.anim,
          onLoaded: controller.onLoaded,
        ),
      ),
    );
  }
}
