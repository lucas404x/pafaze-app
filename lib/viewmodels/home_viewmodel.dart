import 'package:flutter/material.dart';

import '../data/enumerators/enum_task_delivery_state.dart';
import '../data/enumerators/enum_task_sort_mode.dart';
import '../data/models/list_task_model.dart';
import '../data/models/pinned_card_model.dart';
import '../data/models/task_model.dart';
import '../services/task_service.dart';
import '../utils/ListUtils.dart';

class HomeViewModel extends ChangeNotifier {
  final TaskService _taskService;

  final List<ListTaskModel> _tasks = List.empty(growable: true);
  List<ListTaskModel> get tasks => _tasks;

  int _tasksDoneQuantity = 0;

  final List<ListTaskModel> _tasksLate = List.empty(growable: true);
  List<ListTaskModel> get tasksLate => _tasksLate;

  final PinnedCardModel _pinnedCard = PinnedCardModel();
  PinnedCardModel get pinnedCard => _pinnedCard;

  TaskSortMode _cachedMode = TaskSortMode.dateCreated;

  HomeViewModel(this._taskService);

  void updateTasks() async {
    _tasks.addAll(await _taskService.getTasks());
    _tasksDoneQuantity = await _taskService.getDoneTasksQuantity(_tasks);
    _tasksLate.addAll(await _taskService.getOnlyLateTasks(_tasks));
    _updatePinnedCard();
    sortTasks(TaskSortMode.dateCreated);
    notifyListeners();
  }

  void _updatePinnedCard() {
    if (_tasks.isNotEmpty) {
      var taskDonePercent = _calculateTasksDonePercent();
      _pinnedCard.tasksDonePercent = taskDonePercent;
      _pinnedCard.progressValue = taskDonePercent / 100;
      _pinnedCard.totalTasksQuantity = _tasks.length;
      _pinnedCard.tasksDoneQuantity = _tasksDoneQuantity;
    }
  }

  int _calculateTasksDonePercent() {
    return _tasksDoneQuantity * 100 ~/ _tasks.length;
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
      listTask.task.isDone = true;
      _tasksDoneQuantity++;
      _updatePinnedCard();
      notifyListeners();
    }
  }

  void onTaskRemove(ListTaskModel listTask) async {
    await _taskService.removeTask(listTask.task.id);
    _tasks.remove(listTask);
    _updatePinnedCard();
    notifyListeners();
  }
}
