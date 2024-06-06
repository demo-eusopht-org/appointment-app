import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension DateTimeUtils on DateTime {
  bool get isToday {
    final now = DateTime.now();
    return day == now.day && month == now.month && year == now.year;
  }

  String toPkFormattedDate() {
    return DateFormat('dd-MM-yyyy').format(this);
  }

  String toFormattedDate() {
    return DateFormat('yyyy-MM-dd').format(this);
  }

  String toMonthNameFormat() {
    final DateFormat newFormat = DateFormat('dd MMMM yyyy');
    return newFormat.format(this);
  }

  String convertDateToDay() {
    final dayFormatter = DateFormat('EEEE'); // EEEE for full weekday name
    return dayFormatter.format(this);
  }
}

extension TimeFormat on TimeOfDay {
  String toFormattedTime() {
    final hour = this.hour % 12;
    final minute = this.minute.toString().padLeft(2, '0');

    final period = this.hour >= 12 ? 'PM' : 'AM';
    return '${hour == 0 ? 12 : hour}:$minute:00 $period';
  }
}

extension TimeFormatFromString on String {
  String fromStringtoFormattedTime() {
    try {
      // Parse the time string
      DateFormat originalFormat = DateFormat('HH:mm:ss');
      DateTime time = originalFormat.parse(this);

      // Format the time to AM/PM format
      DateFormat newFormat = DateFormat('hh:mm:ss a');
      return newFormat.format(time);
    } catch (e) {
      return this;
    }
  }

  String getDay() {
    return split(' ')[0];
  }

  String getMonth() {
    return split(' ')[1];
  }

  String getYear() {
    return split(' ')[2];
  }

  String toUpperCaseFirst() {
    return this[0].toUpperCase() + this.substring(1);
  }
}
