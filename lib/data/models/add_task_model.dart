import '../enumerators/enum_task_delivery_state.dart';

class AddTaskModel {
  late final String title;
  late final String description;
  late final DateTime dateToDelivery;
  late final TaskDeliveryState deliveryState;

  AddTaskModel(
      {required this.title,
      required this.description,
      required this.dateToDelivery,
      required this.deliveryState});
}
