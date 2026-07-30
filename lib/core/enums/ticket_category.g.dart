// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket_category.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TicketCategoryAdapter extends TypeAdapter<TicketCategory> {
  @override
  final typeId = 1;

  @override
  TicketCategory read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return TicketCategory.technical;
      case 1:
        return TicketCategory.billing;
      case 2:
        return TicketCategory.general;
      default:
        return TicketCategory.technical;
    }
  }

  @override
  void write(BinaryWriter writer, TicketCategory obj) {
    switch (obj) {
      case TicketCategory.technical:
        writer.writeByte(0);
      case TicketCategory.billing:
        writer.writeByte(1);
      case TicketCategory.general:
        writer.writeByte(2);
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TicketCategoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
