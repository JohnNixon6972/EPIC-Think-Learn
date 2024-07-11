import 'package:epic/cores/app_constants.dart';
import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String title;
  final TextEditingController? controller;
  final String? hint;
  final Widget? widget;

  const InputField(
      {super.key,
      required this.title,
      this.controller,
      required this.hint,
      this.widget});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppConstants.titleTextStyle,
          ),
          const SizedBox(
            height: 8.0,
          ),
          Container(
            padding: const EdgeInsets.only(left: 14.0),
            height: 52,
            decoration: BoxDecoration(
                border: Border.all(
                  width: 1.0,
                  color: Colors.grey,
                ),
                borderRadius: BorderRadius.circular(12.0)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: TextFormField(
                    autofocus: false,
                    cursorColor: Colors.grey[600],
                    readOnly: widget == null ? false : true,
                    controller: controller,
                    style: AppConstants.subTitleTextStyle,
                    decoration: InputDecoration(
                      hintText: hint,
                      hintStyle: AppConstants.subTitleTextStyle,
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: AppConstants.primaryBackgroundColor,
                          width: 0,
                        ),
                      ),
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: AppConstants.primaryBackgroundColor,
                          width: 0,
                        ),
                      ),
                    ),
                  ),
                ),
                widget == null ? Container() : widget!,
              ],
            ),
          )
        ],
      ),
    );
  }
}
