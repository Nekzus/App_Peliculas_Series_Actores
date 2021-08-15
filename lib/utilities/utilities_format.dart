import 'package:intl/intl.dart';

class UtilidadFecha {
  static String formatDate(String date, String format) {
    try {
      DateTime? dateTime = DateTime.parse(date);
      var formatter = DateFormat(format);
      return formatter.format(dateTime);
    } on FormatException {
      return '---';
    }
  }
}
