import 'package:flutter/material.dart';

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
    _tasks.sort(ListUtils.compareByDateCreated);
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

  void onTaskDone(ListTaskModel listTask) {}

  void onTaskEdit(ListTaskModel listTask) {}

  void onTaskRemove(ListTaskModel listTask) async {
    await _taskService.removeTask(listTask.task.id);
    _tasks.remove(listTask);
    notifyListeners();
  }
}
