import 'package:flutter/material.dart';

import '../colors/app_colors.dart';

class MyDecoration {
  MyDecoration._();

  static final roundedShadow = BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      boxShadow: [defaultShadowBox]);

  static final roundedShadowCriteria = BoxDecoration(
      color: AppColors.primary30,
      borderRadius: BorderRadius.circular(5),
      boxShadow: [defaultShadowBox]);

  static final defaultShadowBox = BoxShadow(
    color: Colors.black.withOpacity(0.15),
    offset: const Offset(1, 1),
    blurRadius: 5,
  );

  static final topRoundedShadow = BoxDecoration(
      color: AppColors.white,
      boxShadow: [defaultShadowBox],
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ));
}
