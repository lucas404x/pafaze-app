import '../data/repositories/hive_repository.dart';

import '../data/models/task_model.dart';

class StorageService {
  final HiveRepository<TaskModel> _hiveRepository;

  StorageService(this._hiveRepository);

  Future<List<TaskModel>> getTasks() async {
    return await _hiveRepository.getAllAsync();
  }

  Future<bool> registerTask(TaskModel task) async {
    return _hiveRepository.addAsync(task);
  }
}
