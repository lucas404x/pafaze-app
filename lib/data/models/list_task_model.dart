import 'task_model.dart';

class ListTaskModel {
  TaskModel task = TaskModel();
  bool expand = false;

  ListTaskModel(TaskModel model, bool expand) {
    task = model;
    expand = expand;
  }
}
