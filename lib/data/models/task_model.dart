import 'package:hive/hive.dart';
import '../enumerators/enum_task_priority.dart';

part 'task_model.g.dart';

@HiveType(typeId: 0)
class TaskModel {
  @HiveField(0)
  late String id;

  @HiveField(1)
  late String title;

  @HiveField(2)
  late String description;

  @HiveField(3)
  late bool isDone;

  @HiveField(4)
  late DateTime dateCreated;

  @HiveField(5)
  late TaskPriority priority;
}
