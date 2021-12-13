import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';

import 'notification_service.dart';

class AlarmManagerService {
  AlarmManagerService();

  Future<int> registerTaskAlarm(DateTime timeToDelivery) async {
    int id = _generateRandomAlarmId();

    var date = timeToDelivery.toLocal();
    await AndroidAlarmManager.oneShotAt(date, id, _markTaskAsLateAndNotifyUser,
        alarmClock: true);
    return id;
  }

  static _markTaskAsLateAndNotifyUser(int alarmId) async {
    // var taskBox = await Hive.openBox<TaskModel>('task');
    // var alarmBox = await Hive.openBox<AlarmModel>('alarm');

    // var localTaskRepo = HiveRepository<TaskModel>(taskBox);
    // var localAlarmRepo = HiveRepository<AlarmModel>(alarmBox);

    // var storage = StorageService(localTaskRepo, localAlarmRepo);

    // var alarm = await storage.getAlarm(alarmId);
    // if (alarm == null) {
    //   return;
    // }

    // var task = await storage.getTask(alarm.taskId);
    // if (task == null) {
    //   return;
    // }

    NotificationService.showNotification(
        alarmId, 'Uma tarefa atrasada!', 'Entre no app e tente resolvê-lá', '');
  }

  Future<bool> cancelTaskAlarm(int alarmId) {
    return AndroidAlarmManager.cancel(alarmId);
  }

  int _generateRandomAlarmId() {
    return 0;
  }
}
