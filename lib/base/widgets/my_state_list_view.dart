import 'package:base_flutter/base/widgets/loading_view.dart';
import 'package:base_flutter/base/widgets/no_data_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MyStateListView<T extends Iterable<T>?> extends StatelessWidget {
  const MyStateListView(
      {super.key,
      required this.listener,
      required this.child,
      this.empty = const NoDataView()});
  final ValueListenable<T> listener;
  final Widget Function(T model) child;
  final Widget empty;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<T>(
      valueListenable: listener,
      builder: (context, value, _) {
        if (value != null) {
          if (value.isNotEmpty) {
            return child(value);
          } else {
            return empty;
          }
        }
        return const LoadingView();
      },
    );
  }
}
