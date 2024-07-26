import 'package:epic/cores/app_constants.dart';
import 'package:flutter/material.dart';

class NumberBox extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  final IconData icon;

  const NumberBox({
    required this.label,
    required this.value,
    required this.color,
    required this.icon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: AppConstants.secondaryTextColor.withOpacity(0.5),
            ),
            color: AppConstants.secondaryColor.withOpacity(0.8),
          ),
          height: 40,
          width: MediaQuery.of(context).size.width / 1.85,
          child: Center(
            child: Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 18,
                    color: AppConstants.primaryTextColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 10),
                Icon(
                  icon,
                  color: color,
                  size: 25,
                ),
              ],
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: AppConstants.secondaryTextColor.withOpacity(0.5),
            ),
            color: AppConstants.primaryColor.withOpacity(0.8),
          ),
          height: 40,
          width: MediaQuery.of(context).size.width / 2.75,
          child: Center(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 18,
                color: AppConstants.primaryTextColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
