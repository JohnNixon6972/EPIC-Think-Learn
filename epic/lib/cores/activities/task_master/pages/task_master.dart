import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:epic/cores/activities/task_master/model/task_model.dart';
import 'package:epic/cores/activities/task_master/pages/add_task_page.dart';
import 'package:epic/cores/activities/task_master/repository/notification_notifier.dart';
import 'package:epic/cores/activities/task_master/repository/task_master_notifier.dart';
import 'package:epic/cores/activities/task_master/widgets/size_config.dart';
import 'package:epic/cores/activities/task_master/widgets/task_tile.dart';
import 'package:epic/cores/app_constants.dart';
import 'package:epic/cores/screens/error_page.dart';
import 'package:epic/cores/screens/loader.dart';
import 'package:epic/features/account/pages/my_profile.dart';
import 'package:epic/features/auth/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class TaskMaster extends StatefulWidget {
  const TaskMaster({super.key});

  @override
  State<TaskMaster> createState() => _TaskMasterState();
}

class _TaskMasterState extends State<TaskMaster> {
  DateTime _selectedDate = DateTime.parse(DateTime.now().toString());

  bool animate = false;

  double left = 630;
  double top = 900;

  @override
  void initState() {
    super.initState();

    Timer(const Duration(microseconds: 500), () {
      setState(() {
        animate = true;
        left = 30;
        top = top / 3;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Consumer(
      builder: (context, ref, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppConstants.primaryColor,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded,
                  size: 25, color: AppConstants.primaryTextColor),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: const Text(
              "Task Master",
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: AppConstants.primaryTextColor),
            ),
            actions: [
              Consumer(
                builder: (context, ref, child) {
                  return ref.watch(currentUserProvider).when(
                      data: (currentUser) => Padding(
                            padding: const EdgeInsets.only(right: 12.0),
                            child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const MyProfile()),
                                  );
                                },
                                child: CircleAvatar(
                                  radius: 18,
                                  backgroundColor: Colors.grey,
                                  backgroundImage: CachedNetworkImageProvider(
                                      currentUser.profilePic),
                                )),
                          ),
                      error: (error, stackTrace) =>
                          ErrorPage(message: error.toString()),
                      loading: () => const Loader());
                },
              ),
            ],
          ),
          backgroundColor: AppConstants.primaryBackgroundColor,
          body: Column(
            children: [
              _addTaskBar(),
              _dateBar(),
              const SizedBox(
                height: 12,
              ),
              _showTasks(),
            ],
          ),
        );
      },
    );
  }

  _dateBar() {
    return Container(
      margin: const EdgeInsets.only(bottom: 10, left: 20),
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
        child: DatePicker(
          DateTime.now(),
          height: 100.0,
          width: 80,
          initialSelectedDate: DateTime.now(),
          selectionColor: AppConstants.primaryColor,
          //selectedTextColor: primaryClr,
          selectedTextColor: Colors.white,
          dateTextStyle: GoogleFonts.lato(
            textStyle: const TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w600,
              color: Colors.grey,
            ),
          ),
          dayTextStyle: GoogleFonts.lato(
            textStyle: const TextStyle(
              fontSize: 16.0,
              color: Colors.grey,
            ),
          ),
          monthTextStyle: GoogleFonts.lato(
            textStyle: const TextStyle(
              fontSize: 10.0,
              color: Colors.grey,
            ),
          ),

          onDateChange: (date) {
            setState(
              () {
                _selectedDate = date;
              },
            );
          },
        ),
      ),
    );
  }

  _addTaskBar() {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat.yMMMMd().format(DateTime.now()),
                style: AppConstants.subHeadingTextStyle,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Today",
                style: AppConstants.headingTextStyle,
              ),
            ],
          ),
          GestureDetector(
            onTap: () async {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const AddTaskPage()));
            },
            child: Container(
              height: 50,
              width: 130,
              decoration: BoxDecoration(
                color: AppConstants.primaryColor,
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Center(
                child: Text(
                  "+ Add Task",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  _showTasks() {
    return Consumer(
      builder: (context, ref, child) {
        final taskController = ref.watch(taskMasterProvider);
        final notifyProvider = ref.watch(notificationProvider);
        return Expanded(
            child: taskController.taskList.isEmpty
                ? _noTaskMsg()
                : ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: taskController.taskList.length,
                    itemBuilder: (context, index) {
                      Task task = taskController.taskList[index];
                      if (task.repeat == 'Daily') {
                        try {
                          DateFormat format = DateFormat("hh:mm a");

                          // Parse the time string to a DateTime object
                          DateTime dateTime = format.parse(task.startTime!);

                          // Extract hour and minute as integers
                          int hour = dateTime.hour; // 24-hour format
                          int minute = dateTime.minute;

                          notifyProvider.scheduledNotification(
                              hour, minute, task);
                          debugPrint("Scheduled notification");
                        } on FormatException {
                          debugPrint(
                              "Error parsing date: Invalid format - ${task.startTime}");
                        }

                        return AnimationConfiguration.staggeredList(
                          position: index,
                          duration: const Duration(milliseconds: 1375),
                          child: SlideAnimation(
                            horizontalOffset: 300.0,
                            child: FadeInAnimation(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                      onTap: () {
                                        showModalBottomSheet(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return showBottomSheet(context,
                                                  task, taskController);
                                            });
                                      },
                                      child: TaskTile(task)),
                                ],
                              ),
                            ),
                          ),
                        );
                      }
                      if (task.date == DateFormat.yMd().format(_selectedDate)) {
                        return AnimationConfiguration.staggeredList(
                          position: index,
                          duration: const Duration(milliseconds: 1375),
                          child: SlideAnimation(
                            horizontalOffset: 300.0,
                            child: FadeInAnimation(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                      onTap: () {
                                        showModalBottomSheet(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return showBottomSheet(context,
                                                  task, taskController);
                                            });
                                      },
                                      child: TaskTile(task)),
                                ],
                              ),
                            ),
                          ),
                        );
                      } else {
                        return Container();
                      }
                    }));
      },
    );
  }

  showBottomSheet(
      BuildContext context, Task task, TaskMasterNotifier taskController) {
    return Container(
      padding: const EdgeInsets.only(top: 4),
      height: task.isCompleted == 1
          ? SizeConfig.screenHeight * 0.20
          : SizeConfig.screenHeight * 0.35,
      width: SizeConfig.screenWidth,
      color: Colors.white,
      child: Column(children: [
        Container(
          height: 6,
          width: 120,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Colors.grey[600]),
        ),
        const Spacer(),
        task.isCompleted == 1
            ? Container()
            : _buildBottomSheetButton(
                label: "Task Completed",
                onTap: () {
                  taskController.markTaskCompleted(task.id);
                  Navigator.pop(context);
                },
                clr: AppConstants.primaryColor),
        _buildBottomSheetButton(
            label: "Delete Task",
            onTap: () {
              taskController.deleteTask(task);
              Navigator.pop(context);
            },
            clr: Colors.red[300]),
        const SizedBox(
          height: 20,
        ),
        _buildBottomSheetButton(
            label: "Close",
            onTap: () {
              Navigator.pop(context);
            },
            isClose: true),
        const SizedBox(
          height: 20,
        ),
      ]),
    );
  }

  _buildBottomSheetButton(
      {required String label,
      Function? onTap,
      Color? clr,
      bool isClose = false}) {
    return GestureDetector(
      onTap: onTap as void Function()?,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        height: 55,
        width: SizeConfig.screenWidth! * 0.9,
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: isClose ? Colors.grey[600]! : clr!,
          ),
          borderRadius: BorderRadius.circular(20),
          color: isClose ? Colors.transparent : clr,
        ),
        child: Center(
            child: Text(
          label,
          style: isClose
              ? AppConstants.titleTextStyle
              : AppConstants.titleTextStyle.copyWith(color: Colors.white),
        )),
      ),
    );
  }

  _noTaskMsg() {
    return Stack(
      children: [
        AnimatedPositioned(
          duration: const Duration(milliseconds: 2000),
          left: left,
          top: top,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                "assets/images/task.svg",
                height: 90,
                semanticsLabel: 'Task',
              ),
              SizedBox(
                width: SizeConfig.screenWidth! * 0.8,
                child: Text(
                  "You do not have any tasks yet!\nAdd new tasks to make your days productive.",
                  textAlign: TextAlign.center,
                  style: AppConstants.titleTextStyle,
                  softWrap: true,
                ),
              ),
              const SizedBox(
                height: 80,
              ),
            ],
          ),
        )
      ],
    );
  }
}
