import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';

import '../../base/flavour/environment.dart';
import '../../base/flavour/flavour.dart';

class MyLogger {
  static final _logger = Logger();

  MyLogger._internal();

  static bool get isDebug => kDebugMode;

  static void console(dynamic tag, dynamic e) {
    if (kDebugMode) {
      log('$tag: ==>> $e');
    }
  }

  static void d(dynamic tag, dynamic e) {
    if (kDebugMode) {
      _logger.d('${tag.runtimeType} : $e');
    }
  }

  static void e(dynamic tag, dynamic e) {
    if (kDebugMode) {
      _logger.e('${tag.runtimeType}', error: e);
    }
  }

  static void consoleToast(dynamic tag, String msg) {
    if (kDebugMode || Environment.instance.config.env != Flavour.prod) {
      log('$tag: ==>> $msg');
      Fluttertoast.showToast(
          msg: msg,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 14);
    }
  }
}
