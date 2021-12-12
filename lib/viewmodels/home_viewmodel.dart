import 'package:flutter/material.dart';
import 'package:pafaze/data/enumerators/enum_task_sort_mode.dart';
import 'package:pafaze/data/models/list_task_model.dart';
import 'package:pafaze/services/storage_service.dart';
import 'package:pafaze/utils/ListUtils.dart';
import '../data/models/task_model.dart';

class HomeViewModel extends ChangeNotifier {
  final StorageService _storageService;
  List<ListTaskModel> _tasks = List.empty(growable: true);

  List<ListTaskModel> get tasks => _tasks;

  TaskSortMode _cachedMode = TaskSortMode.dateCreated;

  HomeViewModel(this._storageService);

  void updateTasks() async {
    var storageTasks = await _storageService.getTasks();
    _tasks = _convertFromTaskToListTask(storageTasks);
    _tasks.sort(ListUtils.compareByDateCreated);
    notifyListeners();
  }

  List<ListTaskModel> _convertFromTaskToListTask(List<TaskModel> tasks) {
    return tasks
        .map((task) => ListTaskModel(task, false))
        .toList(growable: true);
  }

  void sortTasks(TaskSortMode mode) {
    if (_tasks.isEmpty || _cachedMode == mode) {
      return;
    }

    switch (mode) {
      case TaskSortMode.dateCreated:
        _tasks.sort(ListUtils.compareByDateCreated);
        break;
      case TaskSortMode.dateToDelivery:
        _tasks.sort(ListUtils.compareByDateToDelivery);
        break;
      case TaskSortMode.ascendingTitle:
        _tasks.sort(ListUtils.compareByTitleAZ);
        break;
      case TaskSortMode.descendingTitle:
        _tasks.sort(ListUtils.compareByTitleZA);
        break;
    }

    _cachedMode = mode;
    notifyListeners();
  }

  void openPageAndUpdateTasksWhenComeBack(
      BuildContext context, String route, Object? arguments) async {
    var shouldRetriveTasksAgain =
        await Navigator.of(context).pushNamed(route, arguments: arguments);

    if (shouldRetriveTasksAgain != null) {
      updateTasks();
    }
  }

  void switchExpandState(int taskPosition) {
    _tasks[taskPosition].expand = !_tasks[taskPosition].expand;
    notifyListeners();
  }

  void onTaskDone(ListTaskModel listTask) {}

  void onTaskEdit(ListTaskModel listTask) {}

  void onTaskRemove(ListTaskModel listTask) async {
    await _storageService.removeTask(listTask.task.id);
    _tasks.remove(listTask);
    notifyListeners();
  }
}
