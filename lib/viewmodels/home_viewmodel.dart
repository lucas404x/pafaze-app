import 'package:flutter/cupertino.dart';
import 'package:pafaze/services/storage_service.dart';
import '../data/models/task_model.dart';

class HomeViewModel extends ChangeNotifier {
  final StorageService _storageService;
  List<TaskModel> _tasks = List.empty(growable: true);

  List<TaskModel> get tasks => _tasks;

  HomeViewModel(this._storageService);

  void updateTasks() async {
    _tasks = await _storageService.getTasks();
    notifyListeners();
  }
}
