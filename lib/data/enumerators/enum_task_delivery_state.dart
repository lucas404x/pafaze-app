import 'package:hive/hive.dart';

part 'enum_task_delivery_state.g.dart';

@HiveType(typeId: 2)
enum TaskDeliveryState {
  @HiveField(0)
  notDelivery,
  @HiveField(1)
  delivery,
  @HiveField(2)
  deliveryLate
}
