// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket_status.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TicketStatusAdapter extends TypeAdapter<TicketStatus> {
  @override
  final typeId = 2;

  @override
  TicketStatus read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return TicketStatus.open;
      case 1:
        return TicketStatus.inProgress;
      case 2:
        return TicketStatus.closed;
      default:
        return TicketStatus.open;
    }
  }

  @override
  void write(BinaryWriter writer, TicketStatus obj) {
    switch (obj) {
      case TicketStatus.open:
        writer.writeByte(0);
      case TicketStatus.inProgress:
        writer.writeByte(1);
      case TicketStatus.closed:
        writer.writeByte(2);
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TicketStatusAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
