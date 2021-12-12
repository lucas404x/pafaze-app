import 'package:flutter/cupertino.dart';
import 'package:pafaze/data/enumerators/enum_task_sort_mode.dart';
import 'package:pafaze/services/storage_service.dart';
import 'package:pafaze/utils/ListUtils.dart';
import '../data/models/task_model.dart';

class HomeViewModel extends ChangeNotifier {
  final StorageService _storageService;
  List<TaskModel> _tasks = List.empty(growable: true);

  List<TaskModel> get tasks => _tasks;

  TaskSortMode _cachedMode = TaskSortMode.dateCreated;

  HomeViewModel(this._storageService);

  void updateTasks() async {
    _tasks = await _storageService.getTasks();
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
}
