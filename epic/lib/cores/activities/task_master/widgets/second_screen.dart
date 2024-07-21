import 'package:epic/cores/app_constants.dart';
import 'package:flutter/material.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen(this.payload, {super.key});

  final String? payload;

  @override
  State<StatefulWidget> createState() => SecondScreenState();
}

class SecondScreenState extends State<SecondScreen> {
  String? _payload;

  @override
  void initState() {
    super.initState();
    _payload = widget.payload;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(' ${_payload.toString().split("|")[0]}'),
      ),
      body: Column(children: [
        const SizedBox(
          height: 40,
        ),
        const Column(children: [
          Text(
            "Hello, User",
            style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w900,
                color: Color(0xFF162339)),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "You have a new reminder",
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w300,
                color: Colors.grey),
          ),
        ]),
        const SizedBox(
          height: 40,
        ),
        Expanded(
          child: Container(
            width: double.maxFinite,
            padding: const EdgeInsets.only(left: 30, right: 30, top: 50),
            margin: const EdgeInsets.only(left: 30, right: 30),
            decoration: const BoxDecoration(
                color: AppConstants.primaryColor,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(50),
                    topLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50),
                    bottomLeft: Radius.circular(50))),
            //child:Text('${_payload}'),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.text_format, size: 35, color: Colors.white),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Title",
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    _payload.toString().split("|")[0],
                    style: const TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Row(
                    children: [
                      Icon(Icons.description, size: 35, color: Colors.white),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Description",
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    _payload.toString().split("|")[1],
                    style: const TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Row(
                    children: [
                      Icon(Icons.calendar_today_outlined,
                          size: 35, color: Colors.white),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Date",
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    _payload.toString().split("|")[2],
                    style: const TextStyle(color: Colors.white, fontSize: 20),
                  )
                ]),
          ),
        ),
        const SizedBox(
          height: 140,
        )
      ]),
    );
  }
}
