import 'package:hive_flutter/hive_flutter.dart';

part 'weight_unit.g.dart';

@HiveType(typeId: 6)
enum WeightUnit {
  @HiveField(1)
  kg,
  @HiveField(2)
  lbs,
}
