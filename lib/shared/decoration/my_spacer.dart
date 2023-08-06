import 'dart:math';

import 'package:flutter/material.dart';

const spacer5 = SizedBox(height: 5, width: 5);
const spacer8 = SizedBox(height: 8, width: 8);
const spacer10 = SizedBox(height: 10, width: 10);
const spacer15 = SizedBox(height: 15, width: 15);
const spacer20 = SizedBox(height: 20, width: 20);
const spacer25 = SizedBox(height: 25, width: 25);
const spacer30 = SizedBox(height: 30, width: 30);
const spacer40 = SizedBox(height: 40, width: 40);

class SafeAreaBottomSpacer extends StatelessWidget {
  const SafeAreaBottomSpacer({Key? key, this.preservedPadding = 15})
      : super(key: key);
  final double preservedPadding;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height:
            max(0, MediaQuery.of(context).padding.bottom - preservedPadding));
  }
}

mixin SafeAreaBottom<T extends StatefulWidget> on State<T> {
  double getSafeAreaSpacing({double preservedPadding = 15}) {
    return max(0, MediaQuery.of(context).padding.bottom - preservedPadding);
  }
}
