import 'package:flutter/material.dart';

import '../const/colors.dart';
import '../data/enumerators/enum_task_delivery_state.dart';
import '../data/enumerators/enum_task_sort_mode.dart';
import '../data/models/list_task_model.dart';
import '../data/models/pinned_card_model.dart';
import '../services/task_service.dart';
import '../utils/ListUtils.dart';

class HomeViewModel extends ChangeNotifier {
  final String _enableTaskDoneTxt = 'Exibir tarefas concluidas';
  final String _disableTaskDoneTxt = 'Ocultar tarefas concluídas';

  Color get labelBgColor => _showTasksDone
      ? ColorsApp.disableTaskDoneBgColor
      : ColorsApp.enableTaskDoneBgColor;

  Color get labelTxtColor => _showTasksDone
      ? ColorsApp.disableTaskDoneTxtColor
      : ColorsApp.enableTaskDoneTxtColor;

  String get labelTxt =>
      _showTasksDone ? _disableTaskDoneTxt : _enableTaskDoneTxt;

  bool _showTasksDone = false;
  bool get showTasksDone => _showTasksDone;

  int _tasksDoneQuantity = 0;
  bool get taskDoneExist => _tasksDoneQuantity > 0;

  final TaskService _taskService;

  final List<ListTaskModel> _tasks = List.empty(growable: true);
  List<ListTaskModel> get tasks => _tasks;

  final List<ListTaskModel> _tasksLate = List.empty(growable: true);
  List<ListTaskModel> get tasksLate => _tasksLate;

  final PinnedCardModel _pinnedCard = PinnedCardModel();
  PinnedCardModel get pinnedCard => _pinnedCard;

  TaskSortMode _cachedMode = TaskSortMode.ascendingTitle;

  HomeViewModel(this._taskService);

  void updateTasks() async {
    _tasks.clear();
    _tasks.addAll(await _taskService.getTasks());
    _tasksDoneQuantity = await _taskService.getDoneTasksQuantity(_tasks);
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

  void switchAllowTaskDoneState() {
    _showTasksDone = !_showTasksDone;

    if (_showTasksDone) {
    } else {}

    notifyListeners();
  }

  void switchExpandState(int taskPosition) {
    _tasks[taskPosition].expand = !_tasks[taskPosition].expand;
    notifyListeners();
  }

  void onTaskDone(ListTaskModel listTask) async {
    if (await _taskService.markTaskAsDone(listTask.task)) {
      listTask.task.isDone = true;
      _tasksDoneQuantity++;
      _updatePinnedCard();
      notifyListeners();
    }
  }

  void onTaskRemove(ListTaskModel listTask) async {
    if (await _taskService.removeTask(listTask.task.id)) {
      _tasks.remove(listTask);
      _updatePinnedCard();
      notifyListeners();
    }
  }
}
