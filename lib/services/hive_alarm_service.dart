import 'package:hive_flutter/hive_flutter.dart';

import '../data/enumerators/enum_task_delivery_state.dart';
import '../data/models/alarm_model.dart';
import '../data/models/task_model.dart';

class HiveAlarmService {
  static late final Box<TaskModel> _taskBox;
  static late final Box<AlarmModel> _alarmBox;

  static Future<void> initialize() async {
    await Hive.initFlutter();
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(TaskModelAdapter());
    }

    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(AlarmModelAdapter());
    }

    if (!Hive.isAdapterRegistered(2)) {
      Hive.registerAdapter(TaskDeliveryStateAdapter());
    }

    if (!Hive.isBoxOpen('alarm')) {
      _alarmBox = await Hive.openBox<AlarmModel>('alarm');
    }

    if (!Hive.isBoxOpen('task')) {
      _taskBox = await Hive.openBox<TaskModel>('task');
    }
  }

  static Future<AlarmModel?> getAlarm(int alarmId) async =>
      _alarmBox.get(alarmId);

  static Future<TaskModel?> getTask(String taskId) async =>
      _taskBox.get(taskId);

  static Future<void> removeAlarm(int alarmId) async =>
      await _alarmBox.delete(alarmId);

  static Future<bool> setTaskAsLate(String taskId, TaskModel taskModel) async {
    taskModel.taskDeliveryState = TaskDeliveryState.deliveryLate;
    await _taskBox.put(taskId, taskModel);
    return true;
  }
}
