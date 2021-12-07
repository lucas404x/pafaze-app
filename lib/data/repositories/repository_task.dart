import 'package:hive/hive.dart';
import 'repository_interface.dart';

class RepositoryTask<TaskModel> implements IRepository {
  late final Box<TaskModel> _taskBox;

  RepositoryTask(this._taskBox);

  @override
  Future<List<TaskModel>> getAllAsync() async {
    return _taskBox.values.toList();
  }

  @override
  Future<TaskModel?> getAsync(String id) async {
    return _taskBox.get(id);
  }

  @override
  Future<bool> addAsync(data) async {
    await _taskBox.add(data);
    return true;
  }

  @override
  Future<bool> deleteAsync(String id) async {
    await _taskBox.delete(id);
    return true;
  }

  @override
  Future<bool> editAsync(String id, data) async {
    await _taskBox.put(id, data);
    return true;
  }
}
