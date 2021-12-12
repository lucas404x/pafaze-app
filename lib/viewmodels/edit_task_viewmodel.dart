import 'package:flutter/material.dart';
import 'package:pafaze/utils/DateTimeUtils.dart';
import '../data/models/task_model.dart';
import '../services/storage_service.dart';

class EditTaskViewModel extends ChangeNotifier {
  final String _taskId;

  final StorageService _storageService;

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

  EditTaskViewModel(this._taskId, this._storageService);

  void setup() async {
    TaskModel? task = await _storageService.getTask(_taskId);
    if (task != null) {
      _task = task;
      _titleController.text = _task.title;
      _descriptionController.text = _task.description;
      _isToDeliveryTask = _task.isToDelivery;
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
    _task.isToDelivery = _isToDeliveryTask;
    _task.dateToDelivery = _deliveryDate?.toUtc() ?? DateTime.now().toUtc();

    await _storageService.updateTask(_taskId, _task);

    return null;
  }
}
