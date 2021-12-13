import '../data/enumerators/enum_task_delivery_state.dart';
import '../data/models/alarm_model.dart';
import '../data/models/list_task_model.dart';
import '../data/models/task_model.dart';
import 'alarm_service.dart';
import 'storage_service.dart';

class TaskService {
  final StorageService _storageService;
  final AlarmManagerService _alarmManagerService;

  TaskService(this._storageService, this._alarmManagerService);

  Future<TaskModel?> getTask(String taskId) async {
    return await _storageService.getTask(taskId);
  }

  Future<List<ListTaskModel>> getTasks() async {
    var tasks = await _storageService.getTasks();
    return tasks
        .map((task) => ListTaskModel(task, false))
        .toList(growable: true);
  }

  Future<bool> removeTask(String id) async {
    AlarmModel? alarm = await _storageService.getAlarm(id);
    if (alarm != null) {
      _storageService.removeTask(alarm.taskId);
      _alarmManagerService.cancelTaskAlarm(alarm.id);
      return true;
    }

    return false;
  }

  Future<bool> registerTask(TaskModel task) async {
    String taskId = await _storageService.registerTask(task);
    if (task.taskDeliveryState == TaskDeliveryState.delivery) {
      int alarmId = await _alarmManagerService
          .registerTaskAlarm(task.dateToDelivery.toLocal());

      AlarmModel alarm = AlarmModel.init(alarmId, taskId);
      _storageService.registerAlarm(alarm);
    }

    return true;
  }

  Future<bool> updateTask(String taskId, TaskModel task) {
    return _storageService.updateTask(taskId, task);
  }
}
