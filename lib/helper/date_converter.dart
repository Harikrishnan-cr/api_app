import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension DateConverter on DateTime {
  static String formatDate(DateTime dateTime) =>
      DateFormat('dd MMM yyyy hh:mm aa', 'en-IN').format(dateTime);

  static String dateWithMonth(DateTime dateTime) {
    return DateFormat('dd MMMM yyyy').format(dateTime);
  }

  static durationToTime(Duration d) => d.toString().split('.').first.padLeft(8, "0");

  static String estimatedDate(DateTime dateTime) {
    return DateFormat('dd/MM/yyyy').format(dateTime);
  }

  static String infoGraphDate(DateTime dateTime) {
    return DateFormat('dd/MM').format(dateTime);
  }

  static String weekName(DateTime dateTime) {
    return DateFormat('E').format(dateTime);
  }

  String get monthName => DateFormat('MMMM').format(this);
  String get monthYearName => DateFormat('MMMM yyyy').format(this);
  String get monthNameShort => DateFormat('MMM').format(this);

  static String paymentHistory(DateTime dateTime) {
    return DateFormat('MM-dd-yyyy').format(dateTime);
  }

  String get yyyymmdd => DateFormat('yyyy-MM-dd').format(this);

  static DateTime convertStringToDatetime(String dateTime) {
    return DateFormat("yyyy-MM-ddTHH:mm:ss.SSS").parse(dateTime);
  }

  static DateTime isoStringToLocalDate(String dateTime) {
    return DateFormat('yyyy-MM-ddTHH:mm:ss.SSS')
        .parse(dateTime, true)
        .toLocal();
  }

  static String isoStringToLocalTimeOnly(String dateTime) {
    return DateFormat('hh:mm aa').format(isoStringToLocalDate(dateTime));
  }

  static String isoStringToLocalAMPM(String dateTime) {
    return DateFormat('a').format(isoStringToLocalDate(dateTime));
  }

  static String isoStringToLocalDateOnly(DateTime dateTime) {
    return DateFormat('dd MMM yyyy').format(dateTime);
  }

  String get jsonDateString {
    return DateFormat('yyyy-MM-dd').format(this);
  }

  String get jsonTimeString {
    return DateFormat('HH:mm:ss.SSS').format(this);
  }

  static String convertTimeToTime(String time) {
    return DateFormat('hh:mm a').format(DateFormat('hh:mm:ss').parse(time));
  }

  static DateTime timeStringToDateTime(String time) {
    DateTime now = DateTime.now();
    List<String> timeParts = time.split(':');
    int hours = int.parse(timeParts[0]);
    int minutes = int.parse(timeParts[1]);
    int seconds = int.parse(timeParts[2]);

    DateTime dateTime =
        DateTime(now.year, now.month, now.day, hours, minutes, seconds);
    return dateTime;
  }

  static String time(DateTime dateTime) =>
      DateFormat('hh:mm:ss aa', 'en-IN').format(dateTime);

 static String getDaySuffix(int day) {
    if (day >= 11 && day <= 13) {
      return 'th';
    }
    switch (day % 10) {
      case 1:
        return 'st';
      case 2:
        return 'nd';
      case 3:
        return 'rd';
      default:
        return 'th';
    }
  }
}

extension TimeOfDayExt on TimeOfDay {
  String get format12H {
    final h = hour <= 12 ? hour : hour % 12;

    final amPM = hour >= 12 ? 'PM' : 'AM';

    String time = '$h:${minute < 10 ? '0$minute' : minute} $amPM';

    return time;
  }

  // String get jsonTimeString {
  //   return this.format12H;
  //   // return DateFormat('HH:mm:ss.SSS').format(this);
  //   // return MaterialLocalizations.of(context).formatTimeOfDay(timeOfDay)
  // }
}


String formatHHMMSS(int seconds) {
  int hours = (seconds / 3600).truncate();
  seconds = (seconds % 3600).truncate();
  int minutes = (seconds / 60).truncate();

  String hoursStr = (hours).toString().padLeft(2, '0');
  String minutesStr = (minutes).toString().padLeft(2, '0');
  String secondsStr = (seconds % 60).toString().padLeft(2, '0');

  if (hours == 0) {
    return secondsStr;
  }

  return "$hoursStr:$minutesStr:$secondsStr";
}
