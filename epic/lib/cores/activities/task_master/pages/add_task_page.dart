// ignore_for_file: no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures

import 'package:cached_network_image/cached_network_image.dart';
import 'package:epic/cores/activities/task_master/model/task_model.dart';
import 'package:epic/cores/activities/task_master/repository/task_master_notifier.dart';
import 'package:epic/cores/activities/task_master/widgets/input_field.dart';
import 'package:epic/cores/app_constants.dart';
import 'package:epic/cores/screens/error_page.dart';
import 'package:epic/cores/screens/loader.dart';
import 'package:epic/features/account/pages/my_profile.dart';
import 'package:epic/features/auth/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  DateTime _selectedDate = DateTime.now();
  String? _startTime = DateFormat('hh:mm a').format(DateTime.now()).toString();

  String? _endTime = "9:30 AM";
  int _selectedColor = 0;

  int _selectedRemind = 5;
  List<int> remindList = [
    5,
    10,
    15,
    20,
  ];

  String? _selectedRepeat = 'None';
  List<String> repeatList = [
    'None',
    'Daily',
    'Weekly',
    'Monthly',
  ];

  @override
  Widget build(BuildContext context) {
    //print(new DateFormat.yMMMd().format(new DateTime.now()));
    debugPrint(" starttime ${_startTime!}");
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, now.minute, now.second);
    final format = DateFormat.jm();
    debugPrint(format.format(dt));
    debugPrint("add Task date: ${DateFormat.yMd().format(_selectedDate)}");
    //_startTime = DateFormat('hh:mm a').format(DateTime.now()).toString();
    return Scaffold(
      backgroundColor: AppConstants.primaryBackgroundColor,
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
                                    builder: (context) => const MyProfile()),
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Add Task",
                  style: AppConstants.headingTextStyle,
                ),
                const SizedBox(
                  height: 8,
                ),
                InputField(
                  title: "Title",
                  hint: "Enter title here.",
                  controller: _titleController,
                ),
                InputField(
                    title: "Note",
                    hint: "Enter note here.",
                    controller: _noteController),
                InputField(
                  title: "Date",
                  hint: DateFormat.yMd().format(_selectedDate),
                  widget: IconButton(
                    icon: (const Icon(
                      Icons.calendar_month_sharp,
                      color: Colors.grey,
                    )),
                    onPressed: () {
                      _getDateFromUser();
                    },
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: InputField(
                        title: "Start Time",
                        hint: _startTime,
                        widget: IconButton(
                          icon: (const Icon(
                            Icons.alarm,
                            color: Colors.grey,
                          )),
                          onPressed: () {
                            _getTimeFromUser(isStartTime: true);
                            setState(() {});
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      child: InputField(
                        title: "End Time",
                        hint: _endTime,
                        widget: IconButton(
                          icon: (const Icon(
                            Icons.alarm,
                            color: Colors.grey,
                          )),
                          onPressed: () {
                            _getTimeFromUser(isStartTime: false);
                          },
                        ),
                      ),
                    )
                  ],
                ),
                InputField(
                  title: "Remind",
                  hint: "$_selectedRemind minutes early",
                  widget: Row(
                    children: [
                      DropdownButton<String>(
                          icon: const Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.grey,
                          ),
                          iconSize: 32,
                          elevation: 4,
                          style: AppConstants.subTitleTextStyle,
                          underline: Container(height: 0),
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedRemind = int.parse(newValue!);
                            });
                          },
                          items: remindList
                              .map<DropdownMenuItem<String>>((int value) {
                            return DropdownMenuItem<String>(
                              value: value.toString(),
                              child: Text(value.toString()),
                            );
                          }).toList()),
                      const SizedBox(width: 6),
                    ],
                  ),
                ),
                InputField(
                  title: "Repeat",
                  hint: _selectedRepeat,
                  widget: Row(
                    children: [
                      DropdownButton<String>(
                          icon: const Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.grey,
                          ),
                          iconSize: 32,
                          elevation: 4,
                          style: AppConstants.subTitleTextStyle,
                          underline: Container(
                            height: 6,
                          ),
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedRepeat = newValue;
                            });
                          },
                          items: repeatList
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                              ),
                            );
                          }).toList()),
                      const SizedBox(width: 6),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 18.0,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _colorChips(),
                    Consumer(
                      builder: (context, ref, child) {
                        final taskController = ref.watch(taskMasterProvider);

                        return GestureDetector(
                          onTap: () {
                            _validateInputs(taskController);
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
                                "Create Task",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _validateInputs(TaskMasterNotifier _taskController) {
    if (_titleController.text.isNotEmpty && _noteController.text.isNotEmpty) {
      _addTaskToDB(_taskController);
      Navigator.pop(context);
    } else if (_titleController.text.isEmpty || _noteController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("All fields are required."),
        duration: Duration(seconds: 2),
      ));
    } else {
      debugPrint("############ SOMETHING BAD HAPPENED #################");
    }
  }

  _addTaskToDB(TaskMasterNotifier _taskController) async {
    await _taskController.addTask(
      task: Task(
        note: _noteController.text,
        title: _titleController.text,
        date: DateFormat.yMd().format(_selectedDate),
        startTime: _startTime,
        endTime: _endTime,
        remind: _selectedRemind,
        repeat: _selectedRepeat,
        color: _selectedColor,
        isCompleted: 0,
      ),
    );
  }

  _colorChips() {
    final List<Color> bgColors = [
      AppConstants.primaryColor,
      AppConstants.memoryColor,
      AppConstants.attentionColor,
      AppConstants.inhibitionColor,
      AppConstants.planningColor,
    ];
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        "Color",
        style: AppConstants.titleTextStyle,
      ),
      const SizedBox(
        height: 8,
      ),
      Wrap(
        children: List<Widget>.generate(
          5,
          (int index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedColor = index;
                });
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: CircleAvatar(
                  radius: 14,
                  backgroundColor: bgColors[index],
                  child: index == _selectedColor
                      ? const Center(
                          child: Icon(
                            Icons.done,
                            color: Colors.white,
                            size: 18,
                          ),
                        )
                      : Container(),
                ),
              ),
            );
          },
        ).toList(),
      ),
    ]);
  }

  double toDouble(TimeOfDay myTime) => myTime.hour + myTime.minute / 60.0;

  _getTimeFromUser({required bool isStartTime}) async {
    var _pickedTime = await _showTimePicker();

    if (_pickedTime == null)
      debugPrint("time canceled");
    else if (isStartTime)
      setState(() {
        String? _formatedTime = _pickedTime.format(context);
        debugPrint(_formatedTime);
        _startTime = _formatedTime;
      });
    else if (!isStartTime) {
      setState(() {
        String? _formatedTime = _pickedTime.format(context);
        debugPrint(_formatedTime);
        _endTime = _formatedTime;
      });
      //_compareTime();
    }
  }

  _showTimePicker() async {
    return showTimePicker(
      initialTime: TimeOfDay(
          hour: int.parse(_startTime!.split(":")[0]),
          minute: int.parse(_startTime!.split(":")[1].split(" ")[0])),
      initialEntryMode: TimePickerEntryMode.input,
      context: context,
    );
  }

  _getDateFromUser() async {
    final DateTime? _pickedDate = await showDatePicker(
        context: context,
        initialDate: _selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (_pickedDate != null) {
      setState(() {
        _selectedDate = _pickedDate;
      });
    }
  }
}
