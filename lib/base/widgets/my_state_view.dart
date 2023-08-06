import 'package:base_flutter/base/widgets/loading_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MyStateView<T> extends StatelessWidget {
  const MyStateView({
    super.key,
    required this.listener,
    required this.child,
  });
  final ValueListenable<T> listener;
  final Widget Function(T model) child;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<T>(
      valueListenable: listener,
      builder: (context, value, _) {
        if (value != null) {
          return child(value);
        }
        return const LoadingView();
      },
    );
  }
}
