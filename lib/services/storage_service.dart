import 'package:nanoid/nanoid.dart';

import '../data/models/alarm_model.dart';
import '../data/models/task_model.dart';
import '../data/repositories/hive_repository.dart';

class StorageService {
  final HiveRepository<TaskModel> _localTaskRepository;
  final HiveRepository<AlarmModel> _localAlarmRepository;

  StorageService(this._localTaskRepository, this._localAlarmRepository);

  Future<TaskModel?> getTask(String id) {
    return _localTaskRepository.getAsync(id);
  }

  Future<List<TaskModel>> getTasks() async {
    return await _localTaskRepository.getAllAsync();
  }

  Future<String> registerTask(TaskModel task) async {
    var id = nanoid();
    task.id = id;
    await _localTaskRepository.addAsync(id, task);
    return id;
  }

  Future<bool> removeTask(String id) {
    return _localTaskRepository.deleteAsync(id);
  }

  Future<bool> updateTask(String id, TaskModel task) {
    return _localTaskRepository.editAsync(id, task);
  }

  Future<bool> registerAlarm(AlarmModel alarm) async {
    _localAlarmRepository.addAsync(alarm.id, alarm);
    _localAlarmRepository.addAsync(alarm.taskId, alarm);
    return true;
  }

  Future<AlarmModel?> getAlarm(id) async {
    return await _localAlarmRepository.getAsync(id);
  }
}
