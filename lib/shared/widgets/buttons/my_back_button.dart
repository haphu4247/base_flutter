import 'package:flutter/material.dart';

import '../../../routes/app_navigation.dart';
import '../../colors/app_colors.dart';

class MyBackButton extends StatelessWidget {
  const MyBackButton({Key? key, this.btnClose = false}) : super(key: key);
  factory MyBackButton.btnClose() {
    return const MyBackButton(
      btnClose: true,
    );
  }
  final bool btnClose;
  @override
  Widget build(BuildContext context) {
    if (btnClose) {
      return CloseButton(
        color: AppColors.white,
        onPressed: () => AppNavigation.back(context: context),
      );
    }
    return BackButton(
      color: AppColors.white,
      onPressed: () => AppNavigation.back(context: context),
    );
  }
}
