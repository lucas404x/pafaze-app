import '../models/task_model.dart';

abstract class IStorageService {
  Future<TaskModel> getTask(String id);

  Future<bool> deleteTask(String id);

  Future<String> saveTask(TaskModel task);

  Future<bool> editTask(TaskModel task);
}
