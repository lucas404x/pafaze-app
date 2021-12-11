import 'package:flutter/material.dart';

class AddTaskViewModel extends ChangeNotifier {
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

  Future<bool> validateAndUploadTask() async {
    if (!_formKey.currentState!.validate()) {
      return false;
    }

    return true;
  }
}
