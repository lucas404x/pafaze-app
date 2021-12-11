import 'package:intl/intl.dart';

class DateTimeUtils {
  static String formatDate(DateTime? date) {
    return DateFormat().format(date ?? DateTime.now());
  }
}
