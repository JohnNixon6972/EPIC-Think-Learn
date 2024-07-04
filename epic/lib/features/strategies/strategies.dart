import 'package:epic/cores/app_constants.dart';
import 'package:epic/cores/games/games.dart';
import 'package:flutter/material.dart';

enum Strategies {
  memory(
      name: "Memory",
      image: AppConstants.memoryCardImage,
      game: Game.teaTowel,
      color: AppConstants.memoryColor),

  inhibition(
      name: "Inhibition",
      image: AppConstants.inhibitionCardImage,
      game: Game.simonSays,
      color: AppConstants.inhibitionColor),
  attention(
      image: AppConstants.attentionCardImage,
      game: Game.simonSays,
      name: "Attention",
      color: AppConstants.attentionColor),
  planning(
      name: "Planning",
      image: AppConstants.planningCardImage,
      game: Game.fourInARow,
      color: AppConstants.planningColor),
  selfRegulation(
      image: AppConstants.selfRegulationCardImage,
      game: Game.howLongIsAMinute,
      name: "Self Regulation",
      color: AppConstants.selfregulationColor);

  const Strategies({
    required this.color,
    required this.name,
    required this.image,
    required this.game,
  });

  final String name;
  final Color color;
  final String image;
  final Game game;
}

enum Difficulties {
  d1(
    name: "Stop and Think Before You Speak or Act",
    areaOfImprovement: [
      Strategies.inhibition,
      Strategies.planning,
      Strategies.selfRegulation,
    ],
  ),
  d2(
    name: "Make the right choices",
    areaOfImprovement: [Strategies.inhibition],
  ),
  d3(
    name: "Wait your turn",
    areaOfImprovement: [Strategies.inhibition],
  ),
  d4(
    name: "Start a task (e.g plan ahead)",
    areaOfImprovement: [Strategies.attention, Strategies.planning],
  ),
  d5(
    name: "Stay focused on a task",
    areaOfImprovement: [Strategies.attention, Strategies.selfRegulation],
  ),
  d6(
    name: "Complete/ finish a task",
    areaOfImprovement: [
      Strategies.attention,
      Strategies.planning,
      Strategies.selfRegulation,
    ],
  ),
  d7(
    name: "Thinking flexibly",
    areaOfImprovement: [Strategies.attention, Strategies.selfRegulation],
  ),
  d8(
    name: "Sit still for long periods of time",
    areaOfImprovement: [
      Strategies.attention,
    ],
  ),
  d9(
    name: "Moving from one task to another",
    areaOfImprovement: [Strategies.attention, Strategies.selfRegulation],
  ),
  d10(
    name: "Follow instructions",
    areaOfImprovement: [Strategies.memory],
  ),
  d11(
    name: "Complete sums in your mind",
    areaOfImprovement: [Strategies.memory],
  ),
  d12(
    name: "Follow a story",
    areaOfImprovement: [Strategies.memory],
  ),
  d13(
    name: "Time management/ kepping track of time",
    areaOfImprovement: [Strategies.planning, Strategies.selfRegulation],
  ),
  d14(
    name: "Setting goals",
    areaOfImprovement: [Strategies.planning],
  ),
  d15(
    name: "Accuracy and speed on completing a task (too fast or too slow)",
    areaOfImprovement: [
      Strategies.planning,
      Strategies.inhibition,
      Strategies.selfRegulation
    ],
  ),
  d16(
    name: "Remembering all the relevant information or steps",
    areaOfImprovement: [Strategies.planning, Strategies.memory],
  ),
  d17(
    name: "Planning your response",
    areaOfImprovement: [Strategies.inhibition, Strategies.selfRegulation],
  ),
  d18(
    name: "Monitoring of your own progress on the task",
    areaOfImprovement: [Strategies.selfRegulation],
  );

  const Difficulties({required this.name, required this.areaOfImprovement});

  final String name;
  final List<Strategies> areaOfImprovement;
}
