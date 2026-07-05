import 'package:flutter/material.dart';
import 'package:gym_app/hive/data_model.dart';
import 'package:gym_app/hive/plan.dart';
import 'package:gym_app/hive/workout_log.dart';
import 'package:hive/hive.dart';

class DataProvider extends ChangeNotifier {
  // get box
  Box<DataModel> get _box => Hive.box('data');

  // get all plans
  List<Plan> get plans => _box.get('data')?.plans ?? [];

  // get all workout logs
  List<WorkoutLog> get workoutLogs => _box.get('data')?.workoutLogs ?? [];

  // create new data model with updated list of plans and notify listeners
  void addPlan(Plan plan) async {
    _box.put(
      'data',
      DataModel(plans: [...plans, plan], workoutLogs: workoutLogs),
    );
    notifyListeners();
  }

  // same as above
  void removePlan(Plan plan) async {
    List<Plan> changedPlans = plans
        .where((Plan storedPlan) => storedPlan != plan)
        .toList();

    _box.put('data', DataModel(plans: changedPlans, workoutLogs: workoutLogs));
    notifyListeners();
  }

  void editPlan(Plan plan) async {
    List<Plan> changedPlans = plans
        .where((Plan storedPlan) => storedPlan.id != plan.id)
        .toList();

    changedPlans.add(plan);

    _box.put('data', DataModel(plans: changedPlans, workoutLogs: workoutLogs));
    notifyListeners();
  }

  // create new data model with updated list of workout logs and notify listeners
  void addLog(Plan plan) async {
    WorkoutLog workoutLog = WorkoutLog(plan: plan, dateTime: DateTime.now());

    // print(plan.name);
    // print(plans.map((p) => p.name).toList());

    _box.put(
      'data',
      DataModel(plans: plans, workoutLogs: [...workoutLogs, workoutLog]),
    );
    notifyListeners();
  }

  // same as above
  void removeLog(WorkoutLog workoutLog) async {
    List<WorkoutLog> changedWorkoutLogs = workoutLogs
        .where((WorkoutLog storedWorkoutLog) => storedWorkoutLog != workoutLog)
        .toList();

    _box.put('data', DataModel(plans: plans, workoutLogs: changedWorkoutLogs));
    notifyListeners();
  }

  // get list of workout logs completed this week
  List<WorkoutLog> getWorkoutLogsFromThisWeek() {
    DateTime now = DateTime.now();

    // get week start date
    DateTime weekStart = DateTime(
      now.year,
      now.month,
      now.day - (now.weekday - 1),
    );

    // get week end date
    DateTime weekEnd = weekStart.add(
      Duration(days: 6, hours: 23, minutes: 59, seconds: 59, milliseconds: 999),
    );

    // return workout logs which dateTime is between weekStart and weekEnd
    return workoutLogs
        .where(
          (WorkoutLog workoutLog) =>
              workoutLog.dateTime.compareTo(weekStart) >= -1 &&
              workoutLog.dateTime.compareTo(weekEnd) <= 1,
        )
        .toList();
  }

  // get next workout plan depended on already completed plans this week
  Plan? getNextWorkoutPlan() {
    // get workout logs from this week
    List<WorkoutLog> workoutLogsThisWeek = getWorkoutLogsFromThisWeek();

    // check which plans have been already realized and remove duplicates
    Set<Plan> realizedPlansThisWeek = workoutLogsThisWeek
        .map((WorkoutLog workoutLog) => workoutLog.plan)
        .toSet();

    // get plans that have not been realized this week and return the first plan in the list

    List<Plan> notRealizedPlansThisWeek = plans
        .where((Plan plan) => !realizedPlansThisWeek.contains(plan))
        .toList();

    // print(notRealizedPlansThisWeek.map((p) => p.name).toList());

    if (notRealizedPlansThisWeek.isEmpty) {
      return null;
    }
    return notRealizedPlansThisWeek.first;
  }
}
