import 'dart:async';

import 'package:flutter/material.dart';

class DeboundcedButton extends StatelessWidget {
  const DeboundcedButton({
    Key? key,
    required this.child,
    required this.onTap,
    this.duration = const Duration(milliseconds: 200),
  }) : super(key: key);

  final Widget child;
  final Function onTap;
  final Duration duration;

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<bool> isEnabled = ValueNotifier<bool>(true);
    Timer? timer;
    return ValueListenableBuilder<bool>(
      valueListenable: isEnabled,
      child: child,
      builder: (context, enabled, child) => InkWell(
        onTap: () {
          if (enabled) {
            isEnabled.value = false;
            onTap.call();
            timer = Timer(duration, () {
              isEnabled.value = true;
              timer?.cancel();
            });
          }
        },
        child: Container(
          margin: const EdgeInsets.only(right: 8),
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: child,
        ),
      ),
    );
  }
}
