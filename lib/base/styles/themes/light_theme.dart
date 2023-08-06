import 'package:flutter/material.dart';

import '../../../shared/colors/app_colors.dart';
import '../fonts/app_fonts.dart';
import 'text_theme.dart';

ThemeData appLightTheme = ThemeData(
  brightness: Brightness.light,
  fontFamily: AppFonts.Roboto.name,
  primaryColor: AppColors.primary,
  primaryColorDark: AppColors.primaryColorDark,
  primaryColorLight: AppColors.primaryColorLight,
  primaryIconTheme: const IconThemeData(color: AppColors.black),
  scaffoldBackgroundColor: AppColors.white,
  hoverColor: AppColors.hoverColor,
  splashColor: AppColors.splashColor,
  highlightColor: AppColors.highlightColor,
  indicatorColor: AppColors.primary,
  appBarTheme: const AppBarTheme(
    elevation: 0,
    color: AppColors.primary,
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    showSelectedLabels: false,
    showUnselectedLabels: false,
    selectedItemColor: AppColors.primary,
    unselectedItemColor: AppColors.lightGrey,
    selectedLabelStyle: TextStyle(
      color: AppColors.transparent,
      fontSize: 12,
      fontWeight: FontWeight.w600,
    ),
    unselectedLabelStyle: TextStyle(
      color: AppColors.transparent,
      fontSize: 12,
      fontWeight: FontWeight.w400,
    ),
  ),
  textTheme: myTextTheme(AppColors.black),
  primaryTextTheme: myTextTheme(AppColors.primary),
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: AppColors.black,
  ),
  // colorScheme: ColorScheme(
  //   background: AppColors.lightGrey,
  //   brightness: Brightness.light,
  //   error: AppColors.warning,
  // ),
);
