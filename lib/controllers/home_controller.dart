import '../data/models/task_model.dart';
import '../services/storage_service.dart';

class HomeController {
  late final StorageService _storageService;

  HomeController(this._storageService);

  Future<List<TaskModel>> getTasks() async {
    var tasks = await _storageService.getTasks();
    return tasks;
  }
}
