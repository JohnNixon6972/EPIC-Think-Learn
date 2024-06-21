import 'package:epic/cores/games/simon_says/pages/simon_game.dart';
import 'package:flutter/material.dart';

enum Game {
  simonSays(
    name: 'Simon Says',
    image:
        'https://fileserver.teachstarter.com/thumbnails/6169-simon-says-instruction-cards-3-thumbnail-0-600x400.png',
    description:
        'Simon Says is a classic memory and attention game where players must mimic sequences of colors or sounds.',
    rules: [
      'The game will display a sequence of colors or sounds.',
      'The player must repeat the sequence correctly by tapping the corresponding buttons.',
      'If the player makes a mistake or taps the wrong button, the game ends.',
    ],
    strategies: [
      'Focus on memorizing the sequence as it is presented.',
      'Start with shorter sequences and gradually increase the difficulty as you improve.',
      'Take breaks between games to maintain concentration.',
    ],
    benefits: [
      'Improves memory recall and pattern recognition.',
      'Enhances cognitive skills such as attention, concentration, and mental agility.',
      'Strengthens inhibition by requiring players to resist the impulse to tap incorrect buttons.',
    ],
    gameWidget: SimonGame(),
  );

  final String name;
  final String image;
  final String description;
  final String keyPhrase;
  final List<String> rules;
  final List<String> strategies;
  final List<String> benefits;
  final Widget gameWidget;

  const Game({
    required this.name,
    required this.image,
    required this.description,
    required this.rules,
    required this.strategies,
    required this.benefits,
    required this.gameWidget,
    this.keyPhrase = 'Stop and Think',
  });
}