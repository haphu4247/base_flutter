import 'package:flutter/material.dart';

import '../colors/app_colors.dart';
import 'buttons/my_back_button.dart';

class MyAppbar extends AppBar {
  MyAppbar({
    Key? key,
    final Widget? title,
    final Widget? leading,
    final List<Widget>? actions,
    final bool btnClose = false,
  }) : super(
          key: key,
          title: title,
          leading: leading ??
              MyBackButton(
                btnClose: btnClose,
              ),
          actions: actions,
          centerTitle: true,
        );

  factory MyAppbar.title({
    required String title,
    Widget? leading,
    bool btnClose = false,
  }) {
    return MyAppbar(
      title: Text(
        title,
        style: const TextStyle(color: AppColors.white),
      ),
      btnClose: btnClose,
      leading: leading,
    );
  }
}
