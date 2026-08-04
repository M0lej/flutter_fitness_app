import 'package:hive_flutter/hive_flutter.dart';

part 'language.g.dart';

@HiveType(typeId: 10)
enum Language {
  @HiveField(0)
  pl,
  @HiveField(1)
  en,
}
