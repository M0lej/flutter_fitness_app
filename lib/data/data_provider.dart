import 'package:flutter/material.dart';
import 'package:gym_app/hive/data_model.dart';
import 'package:gym_app/hive/exercise.dart';
import 'package:gym_app/hive/exercise_stats.dart';
import 'package:gym_app/hive/month_stats.dart';
import 'package:gym_app/hive/plan.dart';
import 'package:gym_app/hive/weight_unit.dart';
import 'package:gym_app/hive/workout_log.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
import 'package:collection/collection.dart';

class DataProvider extends ChangeNotifier {
  final Box<DataModel> _box = Hive.box('data');

  late DataModel _data;

  DataProvider() {
    _data = _box.get('data') ?? DataModel.empty();
  }

  DataModel get data => _data;

  // get all plans
  List<Plan> get plans => _data.plans;

  // get all workout logs
  List<WorkoutLog> get workoutLogs => _data.workoutLogs;

  // get active workout plan
  WorkoutLog? get activeWorkout => _data.activeWorkout;

  // get custom exercises
  List<Exercise> get customExercises => _data.customExercises;

  // get months stats
  List<MonthStats> get monthsStats => _data.monthsStats;

  // get completed workouts count
  int get completedWorkoutsCount => _data.completedWorkoutsCount;

  Future<void> _save() async {
    await _box.put('data', _data);
    notifyListeners();
  }

  // create new data model with updated list of plans and notify listeners
  Future<void> addPlan(Plan plan) async {
    _data.plans.add(plan);

    await _save();
  }

  // same as above
  Future<void> removePlan(Plan plan) async {
    List<Plan> changedPlans = plans
        .where((Plan storedPlan) => storedPlan != plan)
        .toList();

    _data.plans = changedPlans;
    await _save();
  }

  Future<void> editPlan(Plan plan) async {
    int index = plans.indexWhere((Plan storedPlan) => storedPlan.id == plan.id);

    if (index == -1) return;

    List<Plan> changedPlans = plans
        .where((Plan storedPlan) => storedPlan.id != plan.id)
        .toList();

    changedPlans.insert(index, plan);

    _data.plans = changedPlans;
    await _save();
  }

  // create new data model with updated list of workout logs and notify listeners
  // also clears old logs
  Future<void> addLog(Plan plan) async {
    if (activeWorkout == null) {
      throw Exception("There isn't an active workout to log.");
    }

    List<WorkoutLog> modifiedWorkoutLogs = workoutLogs;

    // if there are more that 10 workout logs stored then remove ones that are older than 30 days to save space
    if (modifiedWorkoutLogs.length >= 10) {
      modifiedWorkoutLogs = modifiedWorkoutLogs
          .where(
            (WorkoutLog workoutLog) =>
                DateTime.now().difference(workoutLog.end!).inDays >= 30,
          )
          .toList();
    }

    MonthStats currentMonthStats =
        monthsStats.firstWhereOrNull(
          (MonthStats monthStats) =>
              monthStats.date.month == DateTime.now().month,
        ) ??
        MonthStats.empty();

    currentMonthStats.update(plan.exercises);

    _data.workoutLogs = [
      ...modifiedWorkoutLogs,
      activeWorkout!.copyWith(end: DateTime.now()),
    ];
    _data.activeWorkout = null;
    _data.monthsStats = [
      ...monthsStats.where(
        (MonthStats monthsStats) =>
            monthsStats.date.month != currentMonthStats.date.month,
      ),
      currentMonthStats,
    ];
    _data.completedWorkoutsCount += 1;

    await _save();
  }

  // update existing workout log
  Future<void> editLog(WorkoutLog workoutLog) async {
    int index = workoutLogs.indexWhere(
      (WorkoutLog storedWorkoutLog) => storedWorkoutLog.id == workoutLog.id,
    );

    if (index == -1) return;

    List<WorkoutLog> changedLogs = workoutLogs
        .where(
          (WorkoutLog storedWorkoutLog) => storedWorkoutLog.id != workoutLog.id,
        )
        .toList();

    changedLogs.insert(index, workoutLog);

    _data.workoutLogs = changedLogs;
    _data.monthsStats = getUpdatedMonthsStatsList(workoutLog);

    await _save();
  }

  // same as above
  Future<void> removeLog(WorkoutLog workoutLog) async {
    if (!workoutLogs.contains(workoutLog)) return;

    List<WorkoutLog> changedWorkoutLogs = workoutLogs
        .where((WorkoutLog storedWorkoutLog) => storedWorkoutLog != workoutLog)
        .toList();

    _data.workoutLogs = changedWorkoutLogs;
    _data.completedWorkoutsCount = changedWorkoutLogs.length;
    _data.monthsStats = getUpdatedMonthsStatsList(workoutLog);

    await _save();
  }

  // add new active workout
  Future<void> addActiveWorkout(Plan plan) async {
    if (activeWorkout != null) {
      throw Exception("Cannot replace active workout.");
    }

    _data.activeWorkout = WorkoutLog(
      plan: plan,
      start: DateTime.now(),
      end: null,
      id: Uuid().v1().toString(),
    );

    await _save();
  }

  Future<void> removeActiveWorkout() async {
    _data.activeWorkout = null;

    await _save();
  }

  Future<void> updateActiveWorkout(Plan updatedPlan) async {
    if (activeWorkout == null) {
      throw Exception("Active workout cannot be null");
    }

    _data.activeWorkout = WorkoutLog(
      plan: updatedPlan,
      start: activeWorkout!.start,
      end: activeWorkout!.end,
      id: activeWorkout!.id,
    );

    await _save();
  }

  // add new exercise
  Future<void> addExercise(
    String name,
    String equipment,
    List<String> primaryMuscles,
    List<String> secondaryMuscles,
  ) async {
    Exercise newExercise = Exercise(
      name: name,
      force: null,
      level: null,
      mechanic: null,
      equipment: equipment,
      primaryMuscles: primaryMuscles,
      secondaryMuscles: secondaryMuscles,
      instructions: null,
      category: "custom",
      workoutSets: [],
      weightUnit: WeightUnit.kg,
      images: [],
      id: Uuid().v1().toString(),
    );

    _data.customExercises.add(newExercise);

    await _save();
  }

  List<MonthStats> getUpdatedMonthsStatsList(WorkoutLog workoutLog) {
    MonthStats monthStats =
        monthsStats.firstWhereOrNull(
          (MonthStats monthStats) =>
              monthStats.date.month == workoutLog.end!.month,
        ) ??
        MonthStats.empty();

    List<MonthStats> updatedMonthsStats = monthsStats
        .where((MonthStats m) => m != monthStats)
        .toList();

    monthStats.update(workoutLog.plan.exercises);

    return updatedMonthsStats;
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
