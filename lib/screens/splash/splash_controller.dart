import 'package:base_flutter/base/base_screen/controller/base_stateful_controller.dart';
import 'package:base_flutter/routes/app_pages.dart';
import 'package:base_flutter/shared/utils/my_log.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

class SplashController extends BaseStatefulController {
  AnimationController? anim;

  @override
  void dispose() {
    anim?.removeStatusListener(_onchanged);
    anim?.dispose();
  }

  @override
  void initState(TickerProvider? vsync) {
    if (vsync != null) {
      anim = AnimationController(vsync: vsync);

      anim!.addStatusListener(_onchanged);
    }
  }

  void onLoaded(LottieComposition composition) {
    anim!
      ..duration = composition.duration
      ..forward();
  }

  void _onchanged(AnimationStatus status) {
    MyLogger.console(this, status);
    if (status == AnimationStatus.completed) {
      context.replaceNamed(Routes.home);
    }
  }
}
