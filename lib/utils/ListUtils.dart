import 'package:pafaze/data/enumerators/enum_task_delivery_state.dart';

import '../data/models/list_task_model.dart';

class ListUtils {
  static int compareByDateCreated(ListTaskModel t1, ListTaskModel t2) {
    if (t1.task.taskDeliveryState == TaskDeliveryState.deliveryLate) {
      return -1;
    }

    if (t2.task.taskDeliveryState == TaskDeliveryState.deliveryLate) {
      return 1;
    }

    return t1.task.dateCreated.compareTo(t2.task.dateCreated);
  }

  static int compareByDateToDelivery(ListTaskModel t1, ListTaskModel t2) {
    var t1DeliveryState = t1.task.taskDeliveryState;
    var t2DeliveryState = t2.task.taskDeliveryState;
    var delivery = TaskDeliveryState.delivery;

    if (t1DeliveryState == TaskDeliveryState.deliveryLate) {
      return -1;
    }

    if (t2DeliveryState == TaskDeliveryState.deliveryLate) {
      return 1;
    }

    if (t1DeliveryState != delivery && t2DeliveryState != delivery) {
      return 0;
    } else if (t1DeliveryState == delivery && t2DeliveryState != delivery) {
      return -1;
    } else if (t1DeliveryState != delivery && t2DeliveryState == delivery) {
      return 1;
    }

    return t1.task.dateToDelivery.compareTo(t2.task.dateToDelivery);
  }

  static int compareByTitleAZ(ListTaskModel t1, ListTaskModel t2) {
    if (t1.task.taskDeliveryState == TaskDeliveryState.deliveryLate) {
      return -1;
    }

    if (t2.task.taskDeliveryState == TaskDeliveryState.deliveryLate) {
      return 1;
    }

    return t1.task.title.compareTo(t2.task.title);
  }

  static int compareByTitleZA(ListTaskModel t1, ListTaskModel t2) {
    if (t1.task.taskDeliveryState == TaskDeliveryState.deliveryLate) {
      return -1;
    }

    if (t2.task.taskDeliveryState == TaskDeliveryState.deliveryLate) {
      return 1;
    }

    return t2.task.title.compareTo(t1.task.title);
  }
}
