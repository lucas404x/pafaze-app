import 'package:intl/intl.dart';

class DateTimeUtils {
  static String formatDate(DateTime? date) {
    return DateFormat().format(date ?? DateTime.now());
  }

  static bool isDeliveryDateValid(DateTime? date) {
    if (date == null) {
      return false;
    }

    return date.isAfter(DateTime.now());
  }
}
