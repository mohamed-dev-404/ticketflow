// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket_priority.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TicketPriorityAdapter extends TypeAdapter<TicketPriority> {
  @override
  final typeId = 0;

  @override
  TicketPriority read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return TicketPriority.low;
      case 1:
        return TicketPriority.medium;
      case 2:
        return TicketPriority.high;
      default:
        return TicketPriority.low;
    }
  }

  @override
  void write(BinaryWriter writer, TicketPriority obj) {
    switch (obj) {
      case TicketPriority.low:
        writer.writeByte(0);
      case TicketPriority.medium:
        writer.writeByte(1);
      case TicketPriority.high:
        writer.writeByte(2);
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TicketPriorityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
