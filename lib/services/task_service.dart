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

  Future<int> getDoneTasksQuantity(List<ListTaskModel> listTasks) async {
    return listTasks.where((listTask) => listTask.task.isDone).length;
  }

  Future<bool> removeTask(String id) async {
    AlarmModel? alarm = await _storageService.getAlarm(id);
    if (alarm != null) {
      await _alarmManagerService.cancelTaskAlarm(alarm.id);
    }

    await _storageService.removeTask(id);
    return true;
  }

  Future<bool> registerTask(TaskModel task) async {
    String taskId = await _storageService.registerTask(task);
    if (task.taskDeliveryState == TaskDeliveryState.delivery) {
      var date = task.dateToDelivery.toLocal();
      int alarmId = await _alarmManagerService.registerTaskAlarm(date);
      AlarmModel alarm = AlarmModel.init(alarmId, taskId);
      await _storageService.registerAlarm(alarm);
    }

    return true;
  }

  Future<bool> markTaskAsDone(TaskModel task) {
    task.isDone = true;
    return _storageService.updateTask(task.id, task);
  }

  Future<bool> updateTask(String taskId, TaskModel task) async {
    if (await removeTask(taskId)) {
      return await registerTask(task);
    }
    return false;
  }
}
