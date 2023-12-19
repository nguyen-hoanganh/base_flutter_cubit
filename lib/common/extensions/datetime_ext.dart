import 'package:intl/intl.dart';

extension DateTimeExt on DateTime {
  DateTime plus({
    int? year,
    int? month,
    int? day,
    int? week,
  }) {
    return DateTime(
      this.year + (year ?? 0),
      this.month + (month ?? 0),
      this.day + (day ?? 0) + (week ?? 0) * 7,
    );
  }

  bool isSameDay(DateTime compare) {
    return day == compare.day && month == compare.month && year == compare.year;
  }
}

extension DateTimeFormatExt on DateTime {
  String format(
    DateTimeFormatPattern pattern, {
    String? customPattern,
    String? locale,
  }) {
    switch (pattern) {
      case DateTimeFormatPattern.customPattern:
        if (customPattern == null) return toIso8601String();

        return DateFormat(customPattern, locale).format(this);
      default:
        return DateFormat(pattern.pattern, locale).format(this);
    }
  }
}

enum DateTimeFormatPattern {
  customPattern(""),
  // ignore: constant_identifier_names
  HHmmddMMyyyy("HH:mm - dd/MM/yyyy");

  final String pattern;
  const DateTimeFormatPattern(this.pattern);
}

extension DateTimeLookup<E> on DateFormat {
  DateTime? tryParse(String dateTimeStr) {
    try {
      return parse(dateTimeStr);
    } on FormatException {
      return null;
    }
  }
}
