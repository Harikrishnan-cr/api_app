import 'dart:developer';

import 'package:intl/intl.dart';

String formatDate(DateTime dateTime) {
  final formatter = DateFormat('MM-dd-yyyy, hh:mm a');
  return formatter.format(dateTime);
}

// String dateStr = 'set-jan-2024';
// String timeStr = '02:15 PM';

DateTime getComabainedDateTime(
    {required String dateStr, required String timeStr}) {
  log('time is $dateStr');

  if (dateStr.split('-').last.toString() == '0001') {
    return DateTime.now();
  }
  List<String> dateParts = dateStr.split('-');
  int month = _getMonthNumber(dateParts[1]);
  int year = int.parse(dateParts[2]);
  DateTime date = DateTime(year, month);

// Parse time string
  DateFormat timeFormat = DateFormat('hh:mm a');
  DateTime time = timeFormat.parse(timeStr);

// Combine date and time

  return DateTime(date.year, date.month, date.day, time.hour, time.minute);
}

int _getMonthNumber(String monthStr) {
  Map<String, int> months = {
    'jan': 1,
    'feb': 2,
    'mar': 3,
    'apr': 4,
    'may': 5,
    'jun': 6,
    'jul': 7,
    'aug': 8,
    'sep': 9,
    'oct': 10,
    'nov': 11,
    'dec': 12
  };

  return months[monthStr.toLowerCase()] ?? 1;
}
