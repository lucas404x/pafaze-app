import 'package:flutter/material.dart';

import '../data/enumerators/enum_task_delivery_state.dart';
import '../data/models/task_model.dart';
import '../services/task_service.dart';
import '../utils/DateTimeUtils.dart';

class EditTaskViewModel extends ChangeNotifier {
  final String _taskId;

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

  late TaskModel _task;
  TaskModel get task => _task;

  bool _hasError = false;
  bool get hasError => _hasError;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  bool get canEditTask =>
      !_task.isDone &&
      _task.taskDeliveryState != TaskDeliveryState.deliveryLate;

  EditTaskViewModel(this._taskId, this._taskService);

  void setup() async {
    TaskModel? task = await _taskService.getTask(_taskId);
    if (task != null) {
      _task = task;
      _titleController.text = _task.title;
      _descriptionController.text = _task.description;
      _isToDeliveryTask =
          _task.taskDeliveryState != TaskDeliveryState.notDelivery;

      if (_isToDeliveryTask) {
        var date = _task.dateToDelivery.toLocal();
        _deliveryDate = date;
      }
    } else {
      _hasError = true;
      _errorMessage = 'Tarefa não encontrada.';
    }

    notifyListeners();
  }

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

  Future<String?> validateAndUpdateTask() async {
    if (!_formKey.currentState!.validate()) {
      return 'Dados incorretos. Verifique os dados da tarefa e tente novamente.';
    }

    if (!DateTimeUtils.isDeliveryDateValid(_deliveryDate) &&
        _isToDeliveryTask) {
      return 'O horário selecionado não é valído. Compare o horário atual do seu celular com o selecionado.';
    }

    _task.title = _titleController.text;
    _task.description = _descriptionController.text;
    _task.taskDeliveryState = _isToDeliveryTask
        ? TaskDeliveryState.delivery
        : TaskDeliveryState.notDelivery;
    _task.dateToDelivery = _deliveryDate?.toUtc() ?? DateTime.now().toUtc();

    await _taskService.updateTask(_taskId, _task);

    return null;
  }
}
