import 'package:flutter/material.dart';

extension LocaleExt on Locale {
  String get originalText {
    switch (languageCode) {
      case 'vi':
        return 'Tiếng Việt';
      case 'ko':
        return '한국인';
      case 'ja':
        return '日本';
      case 'en':
        return 'English';
      default:
        return 'English';
    }
  }

  String get flag {
    switch (languageCode) {
      case 'vi':
        return 'flag_vietnam.png';
      case 'ko':
        return 'flag_south_korea.png';
      case 'ja':
        return 'flag_japan.png';
      case 'en':
        return 'flag_enlish.png';
      default:
        return 'flag_uk.png';
    }
  }
}
