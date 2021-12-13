import 'package:intl/intl.dart';

import '../data/enumerators/enum_task_delivery_state.dart';
import '../data/models/task_model.dart';

class DateTimeUtils {
  static String formatDate(DateTime? date) {
    return DateFormat().format(date ?? DateTime.now());
  }

  static String formatDateToShort(DateTime? date) {
    return DateFormat.yMd().format(date ?? DateTime.now());
  }

  static bool isDeliveryDateValid(DateTime? date) {
    if (date == null) {
      return false;
    }

    return date.isAfter(DateTime.now());
  }

  static bool isDeliveryDateLate(TaskModel task) {
    return task.isDone &&
        task.dateToDelivery.isBefore(DateTime.now()) &&
        task.taskDeliveryState != TaskDeliveryState.notDelivery;
  }
}
