import 'package:hive/hive.dart';

part 'alarm_model.g.dart';

@HiveType(typeId: 1)
class AlarmModel {
  @HiveField(0)
  late int id = -1;

  @HiveField(1)
  late String taskId = '';

  AlarmModel();

  AlarmModel.init(this.id, this.taskId);
}
