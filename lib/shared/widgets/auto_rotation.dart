import 'dart:async';

import 'package:flutter/material.dart';

class AutoRotation extends StatefulWidget {
  const AutoRotation({Key? key, required this.child}) : super(key: key);
  final Widget child;
  @override
  State<AutoRotation> createState() => _AutoRotationState();
}

class _AutoRotationState extends State<AutoRotation>
    with SingleTickerProviderStateMixin {
  late AnimationController _rotationController;
  Timer? _timer;
  @override
  void initState() {
    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
      upperBound: 0.5,
    );

    // _animation = Tween(begin: 0.0, end: .5).animate(
    //     CurvedAnimation(parent: _rotationController, curve: Curves.easeOut));
    _startTimer();
    super.initState();
  }

  void _startTimer() {
    _timer = new Timer.periodic(
      const Duration(milliseconds: 2000),
      (Timer timer) {
        _timer = timer;
        if (!_rotationController.isAnimating) {
          setState(() {
            _rotationController.repeat();
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: Tween(begin: 0.0, end: 1.0).animate(_rotationController),
      child: widget.child,
    );
  }

  @override
  void dispose() {
    _rotationController.dispose();
    _timer?.cancel();
    super.dispose();
  }
}
