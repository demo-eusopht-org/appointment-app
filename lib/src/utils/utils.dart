import 'package:intl/intl.dart';

class utils {
  static pkFormatDate(String date, String type) {
    DateTime originalDate = DateTime.parse(date);
    if (type == 'onlyDate') {
      return DateFormat('dd-MM-yyyy').format(originalDate);
    } else {
      return '';
    }
  }

  static formatDate(String date, String type) {
    DateTime originalDate = DateTime.parse(date);
    if (type == 'onlyDate') {
      return DateFormat('yyyy-MM-dd').format(originalDate);
    } else {
      return '';
    }
  }

  static DateTime parseIntoDate(String date, String type) {
    if (type == 'onlyDate') {
      return DateFormat('dd-MM-yyyy').parse('${date}');
    } else {
      final date = DateTime.now();
      return DateFormat('dd-MM-yyyy')
          .parse('${date.day}-${date.month}-${date.year}');
    }
  }
}
