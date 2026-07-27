import 'package:gym_app/extensions/double_extensions.dart';
import 'package:gym_app/hive/weight_unit.dart';

extension WeightParsing on double {
  double convertWeight(WeightUnit currentWeightUnit, WeightUnit weightUnit) {
    if (currentWeightUnit == weightUnit) return this;

    switch (weightUnit) {
      case WeightUnit.kg:
        return (this * 2.2046226218).toFixed(2);
      case WeightUnit.lbs:
        return (this * 0.45359237).toFixed(2);
    }
  }
}
