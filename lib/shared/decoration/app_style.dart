import 'package:flutter/material.dart';

import '../colors/app_colors.dart';

class AppStyles {
  AppStyles._();

  // static final hintText = TextStyle(
  //   fontSize: 14,
  //   fontWeight: FontWeight.w400,
  //   color: AppColors.color_231f20,
  // );

  static const error = TextStyle(
    fontSize: 12,
    height: 1.17,
    fontWeight: FontWeight.w400,
    color: AppColors.primary,
  );

  static const hintText = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.grey,
  );
}
