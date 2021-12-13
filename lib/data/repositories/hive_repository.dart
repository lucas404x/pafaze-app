import 'package:hive/hive.dart';

import '../interfaces/repository_interface.dart';

class HiveRepository<T> implements IRepository<T> {
  late final Box<T> _box;

  HiveRepository(this._box);

  @override
  Future<List<T>> getAllAsync() async {
    return _box.values.toList();
  }

  @override
  Future<T?> getAsync(id) async {
    return _box.get(id);
  }

  @override
  Future<bool> addAsync(id, T data) async {
    await _box.put(id, data);
    return true;
  }

  @override
  Future<bool> deleteAsync(id) async {
    await _box.delete(id);
    return true;
  }

  @override
  Future<bool> editAsync(id, data) async {
    await _box.put(id, data);
    return true;
  }
}
