import '../data/interfaces/storage_service_interface.dart';
import '../data/models/task_model.dart';
import '../data/repositories/repository_task.dart';

class StorageHiveService implements IStorageService {
  late final RepositoryTask _repositoryTask;

  StorageHiveService(this._repositoryTask);

  @override
  Future<TaskModel> getTask(String id) {
    // TODO: implement getTask
    throw UnimplementedError();
  }

  @override
  Future<bool> deleteTask(String id) {
    // TODO: implement deleteTask
    throw UnimplementedError();
  }

  @override
  Future<bool> editTask(TaskModel task) {
    // TODO: implement editTask
    throw UnimplementedError();
  }

  @override
  Future<String> saveTask(TaskModel task) {
    // TODO: implement saveTask
    throw UnimplementedError();
  }
}
