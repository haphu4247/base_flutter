import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sprintf/sprintf.dart';

import '../../base/flavour/environment.dart';

class UtilsString {
  UtilsString._internal();

  static String parse(dynamic msg) {
    if (msg != null) {
      return msg.toString();
    }
    return '';
  }

  static String twoDigits(int n) => n.toString().padLeft(2, '0');

  static String format(String s, List<dynamic> list) {
    return sprintf(s, list);
  }

  static String currency(int total) {
    final Locale locale = Environment.instance.selectedLocales;

    // final country = locale.countryCode;
    final currency = NumberFormat.simpleCurrency(
      locale: locale.toString(),
    );

    return currency.format(total);
  }

  static String parseCurrency(String? source) {
    if (source != null) {
      final amount = int.tryParse(source);
      if (amount != null) {
        return currency(amount);
      }
    }
    return '0';
  }

  static String parseUtf8(String? text) {
    if (text?.isEmpty == true) {
      return '';
    }
    return utf8.decode(text!.runes.toList(), allowMalformed: true);
  }
}

extension StringExt on String {
  bool isValidEmail() {
    if (isEmpty) {
      return false;
    }
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(this);
  }

  String get trs {
    return '';
  }

  bool equalsIgnoreCase(String? other) {
    return toLowerCase() == other?.toLowerCase();
  }

  bool containIgnoreCase(String other) {
    return toLowerCase().contains(other.toLowerCase());
  }
}
