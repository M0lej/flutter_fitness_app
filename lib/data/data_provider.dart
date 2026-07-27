import 'package:flutter/material.dart';
import 'package:gym_app/hive/data_model.dart';
import 'package:gym_app/hive/plan.dart';
import 'package:gym_app/hive/workout_log.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

class DataProvider extends ChangeNotifier {
  // get box
  Box<DataModel> get _box => Hive.box('data');

  // get all plans
  List<Plan> get plans => _box.get('data')?.plans ?? [];

  // get all workout logs
  List<WorkoutLog> get workoutLogs => _box.get('data')?.workoutLogs ?? [];

  // get active workout plan
  WorkoutLog? get activeWorkout => _box.get('data')?.activeWorkout;

  // create new data model with updated list of plans and notify listeners
  void addPlan(Plan plan) async {
    await _box.put(
      'data',
      DataModel(
        plans: [...plans, plan],
        workoutLogs: workoutLogs,
        activeWorkout: activeWorkout,
      ),
    );
    notifyListeners();
  }

  // same as above
  void removePlan(Plan plan) async {
    List<Plan> changedPlans = plans
        .where((Plan storedPlan) => storedPlan != plan)
        .toList();

    await _box.put(
      'data',
      DataModel(
        plans: changedPlans,
        workoutLogs: workoutLogs,
        activeWorkout: activeWorkout,
      ),
    );
    notifyListeners();
  }

  void editPlan(Plan plan) async {
    int index = plans.indexWhere((Plan storedPlan) => storedPlan.id == plan.id);

    List<Plan> changedPlans = plans
        .where((Plan storedPlan) => storedPlan.id != plan.id)
        .toList();

    changedPlans.insert(index, plan);

    await _box.put(
      'data',
      DataModel(
        plans: changedPlans,
        workoutLogs: workoutLogs,
        activeWorkout: activeWorkout,
      ),
    );
    notifyListeners();
  }

  // create new data model with updated list of workout logs and notify listeners
  void addLog(Plan plan) async {
    if (activeWorkout == null) {
      throw Exception("There isn't an active workout to log.");
    }
    await _box.put(
      'data',
      DataModel(
        plans: plans,
        workoutLogs: [
          ...workoutLogs,
          activeWorkout!.copyWith(end: DateTime.now()),
        ],
        activeWorkout: activeWorkout,
      ),
    );
    removeActiveWorkout();
    notifyListeners();
  }

  // update existing workout log
  void editLog(WorkoutLog workoutLog) async {
    int index = workoutLogs.indexWhere(
      (WorkoutLog storedWorkoutLog) => storedWorkoutLog.id == workoutLog.id,
    );

    List<WorkoutLog> changedLogs = workoutLogs
        .where(
          (WorkoutLog storedWorkoutLog) => storedWorkoutLog.id != workoutLog.id,
        )
        .toList();

    changedLogs.insert(index, workoutLog);

    await _box.put(
      'data',
      DataModel(
        plans: plans,
        workoutLogs: changedLogs,
        activeWorkout: activeWorkout,
      ),
    );
    notifyListeners();
  }

  // same as above
  void removeLog(WorkoutLog workoutLog) async {
    List<WorkoutLog> changedWorkoutLogs = workoutLogs
        .where((WorkoutLog storedWorkoutLog) => storedWorkoutLog != workoutLog)
        .toList();

    await _box.put(
      'data',
      DataModel(
        plans: plans,
        workoutLogs: changedWorkoutLogs,
        activeWorkout: activeWorkout,
      ),
    );
    notifyListeners();
  }

  // add new active workout
  void addActiveWorkout(Plan plan) async {
    if (activeWorkout != null) {
      throw Exception("Cannot replace active workout.");
    }

    await _box.put(
      'data',
      DataModel(
        plans: plans,
        workoutLogs: workoutLogs,
        activeWorkout: WorkoutLog(
          plan: plan,
          start: DateTime.now(),
          end: null,
          id: Uuid().v1().toString(),
        ),
      ),
    );
    notifyListeners();
  }

  void updateActiveWorkout(Plan updatedPlan) async {
    if (activeWorkout == null) {
      throw Exception("Active workout cannot be null");
    }

    await _box.put(
      'data',
      DataModel(
        plans: plans,
        workoutLogs: workoutLogs,
        activeWorkout: WorkoutLog(
          plan: updatedPlan,
          start: activeWorkout!.start,
          end: activeWorkout!.end,
          id: activeWorkout!.id,
        ),
      ),
    );
    notifyListeners();
  }

  void removeActiveWorkout() async {
    await _box.put(
      'data',
      DataModel(plans: plans, workoutLogs: workoutLogs, activeWorkout: null),
    );
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
              workoutLog.end!.compareTo(weekStart) >= -1 &&
              workoutLog.end!.compareTo(weekEnd) <= 1,
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
        .where(
          (Plan plan) =>
              realizedPlansThisWeek.toList().indexWhere(
                (Plan realizedPlan) => realizedPlan.id == plan.id,
              ) ==
              -1,
        )
        .toList();

    if (notRealizedPlansThisWeek.isEmpty) {
      return null;
    }
    return notRealizedPlansThisWeek.first;
  }
}
