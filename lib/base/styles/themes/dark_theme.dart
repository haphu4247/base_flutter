import 'package:flutter/material.dart';

import '../../../shared/colors/app_colors.dart';
import '../fonts/app_fonts.dart';
import 'text_theme.dart';

ThemeData appDarkTheme = ThemeData(
  brightness: Brightness.dark,
  fontFamily: AppFonts.Roboto.name,
  primaryColor: AppColors.primary,
  primaryColorDark: AppColors.primaryColorLight,
  primaryColorLight: AppColors.primaryColorDark,
  primaryIconTheme: const IconThemeData(color: AppColors.white),
  scaffoldBackgroundColor: AppColors.black,
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
  textTheme: myTextTheme(AppColors.white),
  primaryTextTheme: myTextTheme(AppColors.primary),
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: AppColors.black,
  ),
  // colorScheme: ColorScheme(
  //   background: AppColors.black,
  // ),
);
