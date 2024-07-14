import 'package:epic/cores/activities/task_master/db/db_helper.dart';
import 'package:epic/cores/activities/task_master/model/task_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TaskMasterNotifier with ChangeNotifier {
  List<Task> _taskList = [];

  List<Task> get taskList => _taskList;

  TaskMasterNotifier() {
    getTasks();
  }
  Future<void> addTask({required Task task}) async {
    await DBHelper.insert(task);
    await getTasks();
  }

  Future<void> getTasks() async {
    List<Map<String, dynamic>> tasks = await DBHelper.query();
    _taskList = tasks.map((data) => Task.fromJson(data)).toList();
    notifyListeners();
  }

  Future<void> deleteTask(Task task) async {
    await DBHelper.delete(task);
    await getTasks();

    notifyListeners();
  }

  Future<void> markTaskCompleted(int? id) async {
    await DBHelper.update(id);
    await getTasks();
    notifyListeners();
  }
}

final taskMasterProvider = ChangeNotifierProvider<TaskMasterNotifier>((ref) {
  return TaskMasterNotifier();
});
