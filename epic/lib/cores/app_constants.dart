import 'package:flutter/material.dart';

class AppConstants {
  static const String memoryCardImage = 'assets/images/memory.jpg';
  static const String inhibitionCardImage = 'assets/images/inhibition.jpg';
  static const String attentionCardImage = 'assets/images/attention.jpg';
  static const String planningCardImage = 'assets/images/planning.jpg';
  static const String selfRegulationCardImage =
      'assets/images/self_regulation.jpg';

  static const String cloudBackgroundImage =
      'assets/images/cloud_background.png';

  static const Color primaryColor = Color(0xffd50032);
  static Color primaryColorLight = Colors.red.shade50;

  static const Color secondaryColor = Colors.amber;
  static Color secondaryColorLight = Colors.amber.shade50;

  static const Color tertiaryColor = Colors.teal;
  static Color tertiaryColorLight = Colors.teal.shade50;

  static const Color attentionColor = Color(0xfff6a800);
  static const Color inhibitionColor = Color(0xffff601f);
  static const Color memoryColor = Color(0xff992b79);
  static const Color planningColor = Color(0xff00546f);
  static const Color selfregulationColor = Color(0xff144839);

  static const Color primaryBackgroundColor =
      Color.fromARGB(255, 249, 249, 249);
  static const Color secondaryBackgroundColor = Color(0xff0099ab);

  static const Color primaryTextColor = Colors.white;
  static const Color secondaryTextColor = Color.fromARGB(255, 95, 119, 121);

  // static const Color primaryButtonColor = Color.fromARGB(255, 217, 168, 62);
  static const Color primaryButtonColor = attentionColor;
}
