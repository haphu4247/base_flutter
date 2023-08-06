import 'package:flutter/material.dart';

//screen size in figma
const _screenHeight = 812;
const _screenWidth = 375;

class Utils {
  Utils._internal();
  static double _heightPercent(double size) {
    return size / _screenHeight;
  }

  static double _widthPercent(double size) {
    return size / _screenWidth;
  }

  static double height(BuildContext context, double size) {
    return MediaQuery.of(context).size.height * _heightPercent(size);
  }

  static double width(BuildContext context, double size) {
    return MediaQuery.of(context).size.width * _widthPercent(size);
  }

  static double heightWithStatusBar(
      BuildContext context, double inputFigmaSize) {
    var statusbarHeight = MediaQuery.of(context).viewPadding.top;
    var h = height(context, inputFigmaSize) - statusbarHeight;
    if (h < 0) {
      h = 0;
    }
    return h;
  }

  static EdgeInsets padding(BuildContext context,
      {double horizontal = 16, double vertical = 16}) {
    return EdgeInsets.symmetric(
        horizontal: width(context, horizontal),
        vertical: height(context, vertical));
  }

  static EdgeInsets paddingAll(BuildContext context, {double padding = 16}) {
    return Utils.padding(context, horizontal: padding, vertical: padding);
  }

  static EdgeInsets paddingOnly(BuildContext context,
      {double left = 0.0,
      double right = 0.0,
      double top = 0.0,
      double bottom = 0.0}) {
    return EdgeInsets.only(
        left: width(context, left),
        right: width(context, right),
        top: height(context, top),
        bottom: height(context, bottom));
  }

  static EdgeInsets paddingHorizontal(BuildContext context,
      {double padding = 16}) {
    return EdgeInsets.symmetric(horizontal: width(context, padding));
  }

  static EdgeInsets paddingVertical(BuildContext context,
      {double padding = 16}) {
    return EdgeInsets.symmetric(vertical: height(context, padding));
  }

  static Radius radius(BuildContext context, double r) {
    return Radius.circular(width(context, r));
  }
}
