import 'package:flutter/material.dart';
import 'package:pafaze/data/enumerators/enum_task_delivery_state.dart';
import '../data/models/task_model.dart';

import '../data/enumerators/enum_task_sort_mode.dart';
import '../data/models/list_task_model.dart';
import '../services/task_service.dart';
import '../utils/ListUtils.dart';

class HomeViewModel extends ChangeNotifier {
  final TaskService _taskService;
  List<ListTaskModel> _tasks = List.empty(growable: true);
  List<ListTaskModel> get tasks => _tasks;

  TaskSortMode _cachedMode = TaskSortMode.dateCreated;

  HomeViewModel(this._taskService);

  void updateTasks() async {
    _tasks = await _taskService.getTasks();
    sortTasks(TaskSortMode.dateCreated);
    notifyListeners();
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

  bool canEditTask(TaskModel task) =>
      !task.isDone && task.taskDeliveryState != TaskDeliveryState.deliveryLate;

  void onTaskDone(ListTaskModel listTask) async {
    if (await _taskService.markTaskAsDone(listTask.task)) {
      notifyListeners();
    }
  }

  void onTaskRemove(ListTaskModel listTask) async {
    await _taskService.removeTask(listTask.task.id);
    _tasks.remove(listTask);
    notifyListeners();
  }
}
