import 'package:flutter/material.dart';

import '../data/enumerators/enum_task_delivery_state.dart';
import '../data/models/add_task_model.dart';
import '../data/models/task_model.dart';
import '../services/task_service.dart';
import '../utils/DateTimeUtils.dart';

class AddTaskViewModel extends ChangeNotifier {
  final TaskService _taskService;

  final _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> get formKey => _formKey;

  final _titleController = TextEditingController();
  TextEditingController get titleController => _titleController;

  final _descriptionController = TextEditingController();
  TextEditingController get descriptionController => _descriptionController;

  bool _isToDeliveryTask = false;
  bool get isToDeliveryTask => _isToDeliveryTask;

  DateTime? _deliveryDate;
  DateTime? get deliveryDate => _deliveryDate;

  AddTaskViewModel(this._taskService);

  String? titleValidator(String? title) {
    if (title == null || title.trim().isEmpty) {
      return 'O título não pode ser vázio.';
    }

    return null;
  }

  void switchDeliveryState(bool newState) {
    _isToDeliveryTask = newState;
    notifyListeners();
  }

  void updateDeliveryDate(DateTime selectedDate) {
    _deliveryDate = selectedDate;
    notifyListeners();
  }

  Future<String?> validateAndUploadTask() async {
    if (!_formKey.currentState!.validate()) {
      return 'Dados incorretos. Verifique os dados da tarefa e tente novamente.';
    }

    if (!DateTimeUtils.isDeliveryDateValid(_deliveryDate) &&
        _isToDeliveryTask) {
      return 'O horário selecionado não é valído. Compare o horário atual do seu celular com o selecionado.';
    }

    var model = AddTaskModel(
        title: _titleController.text,
        description: _descriptionController.text,
        dateToDelivery: _deliveryDate?.toUtc() ?? DateTime.now().toUtc(),
        deliveryState: _isToDeliveryTask
            ? TaskDeliveryState.delivery
            : TaskDeliveryState.notDelivery);

    await _taskService.registerTask(TaskModel.fromAddTaskModel(model));

    return null;
  }
}
