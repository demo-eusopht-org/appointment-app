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
}

extension TimeFormat on TimeOfDay {
  String toFormattedTime() {
    final hour = this.hour % 12;
    final minute = this.minute.toString().padLeft(2, '0');

    final period = this.hour >= 12 ? 'PM' : 'AM';
    return '${hour == 0 ? 12 : hour}:$minute $period';
  }
}
