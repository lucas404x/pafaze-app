import 'task_model.dart';

class ListTaskModel {
  TaskModel task = TaskModel();
  bool visible = true;
  bool expand = false;

  ListTaskModel(TaskModel model, bool visible, bool expand) {
    task = model;
    expand = expand;
  }
}
