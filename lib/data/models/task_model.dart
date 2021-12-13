import 'package:hive/hive.dart';
import '../enumerators/enum_task_delivery_state.dart';

import 'add_task_model.dart';

part 'task_model.g.dart';

@HiveType(typeId: 0)
class TaskModel {
  @HiveField(0)
  late String id = '';

  @HiveField(1)
  late String title = '';

  @HiveField(2)
  late String description = '';

  @HiveField(3)
  late bool isDone = false;

  @HiveField(4)
  late DateTime dateCreated = DateTime.now().toUtc();

  @HiveField(5)
  late DateTime dateToDelivery = DateTime.now().toUtc();

  @HiveField(6)
  late TaskDeliveryState taskDeliveryState = TaskDeliveryState.notDelivery;

  TaskModel();

  TaskModel.fromAddTaskModel(AddTaskModel model) {
    title = model.title;
    description = model.description;
    dateToDelivery = model.dateToDelivery;
    taskDeliveryState = model.deliveryState;
  }
}
