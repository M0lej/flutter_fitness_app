// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weight_unit.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WeightUnitAdapter extends TypeAdapter<WeightUnit> {
  @override
  final int typeId = 6;

  @override
  WeightUnit read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 1:
        return WeightUnit.kg;
      case 2:
        return WeightUnit.lbs;
      default:
        return WeightUnit.kg;
    }
  }

  @override
  void write(BinaryWriter writer, WeightUnit obj) {
    switch (obj) {
      case WeightUnit.kg:
        writer.writeByte(1);
        break;
      case WeightUnit.lbs:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WeightUnitAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
