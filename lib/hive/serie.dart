import 'package:hive/hive.dart';

part 'serie.g.dart';

@HiveType(typeId: 5)
class Serie {
  @HiveField(0)
  final int reps;

  @HiveField(1)
  final double weight;

  Serie({required this.reps, required this.weight});
}
