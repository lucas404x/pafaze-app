import 'package:flutter/cupertino.dart';
import 'package:pafaze/services/storage_service.dart';
import '../data/models/task_model.dart';

class HomeViewModel extends ChangeNotifier {
  List<TaskModel> tasks = List.empty(growable: true);
  final StorageService _storageService;

  HomeViewModel(this._storageService);

  void updateTasks() async {
    tasks = await _storageService.getTasks();
    notifyListeners();
  }
}
