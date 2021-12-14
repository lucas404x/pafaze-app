import 'dart:math';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:hive/hive.dart';

import '../data/models/alarm_model.dart';
import '../data/models/task_model.dart';
import 'hive_alarm_service.dart';
import 'notification_service.dart';

class AlarmManagerService {
  AlarmManagerService();

  Future<int> registerTaskAlarm(DateTime dateToNotify) async {
    int id = _generateRandomAlarmId();

    await AndroidAlarmManager.oneShotAt(dateToNotify, id, _notifyUserAboutTask,
        allowWhileIdle: true);

    return id;
  }

  int _generateRandomAlarmId() {
    return Random(DateTime.now().millisecondsSinceEpoch)
        .nextInt(0x7FFFFFFF - 1);
  }

  static _notifyUserAboutTask(int alarmId) async {
    try {
      await HiveAlarmService.initialize();
    } on HiveError {
      // ignore
    }

    AlarmModel? alarmModel = await HiveAlarmService.getAlarm(alarmId);

    if (alarmModel == null) {
      return;
    }

    TaskModel? taskModel = await HiveAlarmService.getTask(alarmModel.taskId);

    if (taskModel == null) {
      return;
    }

    NotificationService.showNotification(alarmId, 'Uma tarefa atrasada!',
        'A "${taskModel.title}" era para ser entregue hoje.', '');

    await HiveAlarmService.removeAlarm(alarmId);
    await HiveAlarmService.setTaskAsLate(taskModel.id, taskModel);
  }

  Future<bool> cancelTaskAlarm(int alarmId) {
    return AndroidAlarmManager.cancel(alarmId);
  }
}
