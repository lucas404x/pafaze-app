import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';

class AlarmManagerService {
  AlarmManagerService();

  Future<int> registerTaskAlarm(DateTime timeToDelivery) async {
    int id = _generateRandomAlarmId();

    var date = timeToDelivery.toLocal();
    await AndroidAlarmManager.oneShotAt(date, id, _callback, alarmClock: true);
    return id;
  }

  Future<bool> cancelTaskAlarm(int alarmId) {
    return AndroidAlarmManager.cancel(alarmId);
  }

  int _generateRandomAlarmId() {
    return 0;
  }
}

void _callback(int alarmId) {
  print(alarmId);
}
