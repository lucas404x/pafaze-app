import '../data/models/task_model.dart';

class ListUtils {
  static int compareByDateCreated(TaskModel t1, TaskModel t2) {
    return t1.dateCreated.compareTo(t2.dateCreated);
  }

  static int compareByDateToDelivery(TaskModel t1, TaskModel t2) {
    if (!t1.isToDelivery && !t2.isToDelivery) {
      return 0;
    } else if (t1.isToDelivery && !t2.isToDelivery) {
      return 1;
    } else if (!t1.isToDelivery && t2.isToDelivery) {
      return -1;
    }

    return t1.dateToDelivery.compareTo(t2.dateToDelivery);
  }

  static int compareByTitleAZ(TaskModel t1, TaskModel t2) {
    return t1.title.compareTo(t2.title);
  }

  static int compareByTitleZA(TaskModel t1, TaskModel t2) {
    return t2.title.compareTo(t1.title);
  }
}
