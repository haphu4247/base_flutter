import 'package:intl/intl.dart';

enum AppDateFormat { yyyymmdd, yyyyMMdd, ddMMyyyy, EEE, MMMM, HHmm }

class DateTimeUtils {
  static String formatDate(DateTime date, {required AppDateFormat type}) {
    final String dateString = type.format.format(date);
    return dateString;
  }

  static String formatDateyyyyMMdd(DateTime date) {
    return formatDate(date, type: AppDateFormat.yyyyMMdd);
  }
}

extension AppDateFormatExt on AppDateFormat {
  DateFormat get format {
    return DateFormat(_customPattern);
  }

  String get _customPattern {
    switch (this) {
      case AppDateFormat.ddMMyyyy:
        return 'dd/MM/yyyy';
      case AppDateFormat.yyyyMMdd:
        return 'yyyy/MM/dd';
      case AppDateFormat.HHmm:
        return 'HH:mm';
      default:
        return name;
    }
  }
}
