import 'package:epic/cores/app_constants.dart';
import 'package:flutter/material.dart';

class CloudTextBox extends StatelessWidget {
  final String text;
  final double height, width;

  final TextStyle textStyle;

  const CloudTextBox(
      {super.key,
      required this.height,
      required this.width,
      required this.text,
      required this.textStyle});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: Stack(
        children: [
          Center(
            child: Image(
              height: height,
              width: width,
              image: const AssetImage(AppConstants.cloudBackgroundImage),
            ),
          ),
          Column(
            children: [
              SizedBox(
                height: height * 0.6,
              ),
              Center(
                child: Text(
                  text,
                  softWrap: true,
                  style: textStyle,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
