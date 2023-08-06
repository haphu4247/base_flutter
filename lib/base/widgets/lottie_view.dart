import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LottieView extends StatelessWidget {
  const LottieView({
    super.key,
    required this.name,
    this.controller,
    this.onLoaded,
    this.repeat = true,
  });

  final String name;
  final bool repeat;
  final Animation<double>? controller;
  final void Function(LottieComposition)? onLoaded;

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      'assets/lottie/$name.json',
      controller: controller,
      repeat: repeat,
      onLoaded: onLoaded,
    );
  }
}
