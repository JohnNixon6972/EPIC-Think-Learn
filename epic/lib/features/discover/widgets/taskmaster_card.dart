import 'package:epic/cores/activities/task_master/pages/task_master.dart';
import 'package:epic/cores/app_constants.dart';
import 'package:flutter/material.dart';

class TaskMasterCard extends StatelessWidget {
  const TaskMasterCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const TaskMaster()),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text('Task Master',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppConstants.secondaryTextColor)),
                  SizedBox(
                    width: 5,
                  ),
                  Icon(
                    Icons.task_outlined,
                    color: AppConstants.secondaryTextColor,
                  )
                ],
              ),
            ),
            Center(
              child: Transform.rotate(
                angle: -0.1,
                child: SizedBox(
                  height: 315,
                  width: 300,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 45,
                        top: 0,
                        child: Container(
                          height: 150,
                          width: 120,
                          decoration: BoxDecoration(
                            color: Colors.blue.shade200,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.black, width: 1),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Not sure where this is going",
                                  style: TextStyle(
                                      height: 1,
                                      color: Colors.black.withOpacity(0.8),
                                      fontWeight: FontWeight.bold),
                                ),
                                const Text(
                                  "4th Jan 2050",
                                  style: TextStyle(
                                      height: 1,
                                      fontSize: 11,
                                      color: Colors.blueGrey,
                                      fontWeight: FontWeight.bold),
                                ),
                                const Spacer(),
                                const Text(
                                    "Don't read the caption, its all the same, just a bunch of words that don't make sense",
                                    style: TextStyle(
                                        height: 1,
                                        fontSize: 11,
                                        color: Colors.blueGrey,
                                        fontWeight: FontWeight.bold)),
                                Icon(
                                  Icons.local_fire_department_outlined,
                                  color: Colors.black.withOpacity(0.8),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        right: 25,
                        top: 20,
                        child: Container(
                          height: 150,
                          width: 120,
                          decoration: BoxDecoration(
                            color: Colors.green.shade200,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.black, width: 1),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Yes, created all notes on the same day 🙂",
                                  style: TextStyle(
                                      height: 1,
                                      color: Colors.black.withOpacity(0.8),
                                      fontWeight: FontWeight.bold),
                                ),
                                const Text(
                                  "4th Jan 2050",
                                  style: TextStyle(
                                    fontSize: 11,
                                    height: 1,
                                    color: Colors.blueGrey,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Spacer(),
                                const Text(
                                    "Don't read the caption, its all the same, just a bunch of words that don't make sense",
                                    style: TextStyle(
                                        height: 1,
                                        fontSize: 11,
                                        color: Colors.blueGrey,
                                        fontWeight: FontWeight.bold)),
                                Icon(
                                  Icons.book_outlined,
                                  color: Colors.black.withOpacity(0.8),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 30,
                        bottom: 10,
                        child: Container(
                          height: 150,
                          width: 120,
                          decoration: BoxDecoration(
                            color: Colors.purple.shade200,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.black, width: 1),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "This is a mockup of the task master",
                                  style: TextStyle(
                                      height: 1,
                                      color: Colors.black.withOpacity(0.8),
                                      fontWeight: FontWeight.bold),
                                ),
                                const Text(
                                  "4th Jan 2050",
                                  style: TextStyle(
                                    fontSize: 11,
                                    height: 1,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blueGrey,
                                  ),
                                ),
                                const Spacer(),
                                const Text(
                                    "Don't read the caption, its all the same, just a bunch of words that don't make sense",
                                    style: TextStyle(
                                        height: 1,
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blueGrey)),
                                Icon(
                                  Icons.notes,
                                  color: Colors.black.withOpacity(0.8),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        right: 35,
                        bottom: 0,
                        child: Container(
                          height: 150,
                          width: 120,
                          decoration: BoxDecoration(
                            color: Colors.yellow.shade200,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.black, width: 1),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "What do you expect to see here? 🤪",
                                  style: TextStyle(
                                      height: 1,
                                      color: Colors.black.withOpacity(0.8),
                                      fontWeight: FontWeight.bold),
                                ),
                                const Text(
                                  "4th Jan 2050",
                                  style: TextStyle(
                                    fontSize: 11,
                                    height: 1,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blueGrey,
                                  ),
                                ),
                                const Spacer(),
                                const Text(
                                    "Don't read the caption, its all the same, just a bunch of words that don't make sense",
                                    style: TextStyle(
                                        height: 1,
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blueGrey)),
                                Icon(
                                  Icons.brightness_auto_outlined,
                                  color: Colors.black.withOpacity(0.8),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
