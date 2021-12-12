class AddTaskModel {
  late final String title;
  late final String description;
  late final DateTime dateToDelivery;
  late final bool isToDelivery;

  AddTaskModel(
      {required this.title,
      required this.description,
      required this.dateToDelivery,
      required this.isToDelivery});
}
