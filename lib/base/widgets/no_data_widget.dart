import 'package:base_flutter/base/widgets/lottie_view.dart';
import 'package:flutter/material.dart';

class NoDataView extends StatelessWidget {
  const NoDataView({super.key, this.name = 'anim_no_data'});
  final String name;
  factory NoDataView.page404() => const NoDataView(name: 'anim_404');
  @override
  Widget build(BuildContext context) {
    return LottieView(name: name);
  }
}
