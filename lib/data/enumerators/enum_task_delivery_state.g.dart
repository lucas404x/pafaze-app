// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'enum_task_delivery_state.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskDeliveryStateAdapter extends TypeAdapter<TaskDeliveryState> {
  @override
  final int typeId = 2;

  @override
  TaskDeliveryState read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return TaskDeliveryState.notDelivery;
      case 1:
        return TaskDeliveryState.delivery;
      case 2:
        return TaskDeliveryState.deliveryLate;
      default:
        return TaskDeliveryState.notDelivery;
    }
  }

  @override
  void write(BinaryWriter writer, TaskDeliveryState obj) {
    switch (obj) {
      case TaskDeliveryState.notDelivery:
        writer.writeByte(0);
        break;
      case TaskDeliveryState.delivery:
        writer.writeByte(1);
        break;
      case TaskDeliveryState.deliveryLate:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskDeliveryStateAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
