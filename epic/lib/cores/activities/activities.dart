import 'package:epic/cores/activities/task_master/pages/task_master.dart';
import 'package:flutter/material.dart';

enum Activity {
  taskMaster(
    'Task Master',
    TaskMaster(),
    Icons.task
  );

  final String name;
  final Widget activityWidget;
  final IconData icon;

  const Activity(this.name, this.activityWidget,this.icon);

  get activityName => name;
  get activity => activityWidget;
  get activityIcon => icon;
}
