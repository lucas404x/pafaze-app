import '../data/models/list_task_model.dart';

class ListUtils {
  static int compareByDateCreated(ListTaskModel t1, ListTaskModel t2) {
    return t1.task.dateCreated.compareTo(t2.task.dateCreated);
  }

  static int compareByDateToDelivery(ListTaskModel t1, ListTaskModel t2) {
    if (!t1.task.isToDelivery && !t2.task.isToDelivery) {
      return 0;
    } else if (t1.task.isToDelivery && !t2.task.isToDelivery) {
      return -1;
    } else if (!t1.task.isToDelivery && t2.task.isToDelivery) {
      return 1;
    }

    return t1.task.dateToDelivery.compareTo(t2.task.dateToDelivery);
  }

  static int compareByTitleAZ(ListTaskModel t1, ListTaskModel t2) {
    return t1.task.title.compareTo(t2.task.title);
  }

  static int compareByTitleZA(ListTaskModel t1, ListTaskModel t2) {
    return t2.task.title.compareTo(t1.task.title);
  }
}
