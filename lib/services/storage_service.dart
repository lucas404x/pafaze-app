import 'package:nanoid/nanoid.dart';

import '../data/repositories/hive_repository.dart';

import '../data/models/task_model.dart';

class StorageService {
  final HiveRepository<TaskModel> _hiveRepository;

  StorageService(this._hiveRepository);

  Future<List<TaskModel>> getTasks() async {
    return await _hiveRepository.getAllAsync();
  }

  Future<bool> registerTask(TaskModel task) async {
    var id = nanoid();
    task.id = id;
    return _hiveRepository.addAsync(id, task);
  }

  Future<bool> removeTask(String id) {
    return _hiveRepository.deleteAsync(id);
  }
}
