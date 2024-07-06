import 'package:epic/cores/games/4_in_a_row/screens/game_screen/game_screen.dart';
import 'package:epic/cores/games/how_long_is_a_minute/screens/gameScreen.dart';
import 'package:epic/cores/games/simon_says/pages/simon_says_game.dart';
import 'package:epic/cores/games/tea_towel/pages/tea_towel_game.dart';
import 'package:flutter/material.dart';

enum Game {
  simonSays(
      keyPhrase: 'Stop and Think',
      name: 'Simon Says',
      image: 'assets/images/strategies/inhibition_strategy.png',
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
      gameWidget: SimonSaysGame()),

  teaTowel(
    keyPhrase: 'I Found a Way to Remember',
    name: 'Tea Towel',
    image: 'assets/images/strategies/memory_strategy.png',
    description:
        'The Tea Towel Game challenges players to remember a set of items before they are hidden, testing and improving memory recall.',
    rules: [
      'The game will display a few items on the screen for 20 seconds.',
      'After 20 seconds, the items will be hidden.',
      'The player must recall and select the tiles (object names) that they had seen previously.',
      'The number of items will increase as the game progresses.',
    ],
    strategies: [
      'Group items into categories to make them easier to recall.',
      'Visualize the items in a familiar setting to strengthen memory.',
      'Take breaks and try different strategies to see which works best for each individual.'
    ],
    benefits: [
      'Enhances memory recall and visual memory.',
      'Encourages the use of effective memory strategies.',
      'Improves attention to detail and observational skills.',
      'Helps develop cognitive skills such as concentration and focus.'
    ],
    gameWidget: TeaTowelGame(),
  ),

  howLongIsAMinute(
  keyPhrase: 'I can self-regulate',
  name: 'How Long is a Minute?',
  image: 'assets/images/strategies/memory_strategy.png',
  description:
      'How Long is a Minute? is a fun and engaging game that helps us develop a sense of time. You start a timer and stop it when you think one minute has passed. The goal is to guess as close to one minute as possible.',
  rules: [
    'Press the start button to begin the timer.',
    'Try to estimate when one minute has passed and press the stop button.',
    'The game will show you how close your guess was to the actual one-minute mark.',
    'Repeat and try to improve your accuracy with each attempt.',
  ],
  strategies: [
    'Count seconds in your head to keep track of time.',
    'Use a steady rhythm or song to help maintain a consistent pace.',
    'Focus on your internal sense of timing and practice regularly.',
  ],
  benefits: [
    'Improves awareness and perception of time.',
    'Enhances concentration and focus.',
    'Develops self-regulation and patience.',
    'Encourages mindfulness and present-moment awareness.',
  ],
  gameWidget:  HowLongIsAMinute(),),

  fourInARow(
    keyPhrase: 'I can Plan',
    name: '4 in a row',
    image: 'assets/images/strategies/memory_strategy.png',
    description:
        '4 in a Row is a strategic game where players take turns dropping colored discs into a grid, aiming to connect four of their discs in a row horizontally, vertically, or diagonally.',
    rules: [
      'Players take turns dropping one of their colored discs from the top into a column.',
      'The game continues until one player connects four of their discs in a row or all columns are filled without a winner.',
      'If a player connects four discs horizontally, vertically, or diagonally, they win.',
      'If all columns are filled and no player has connected four discs, the game ends in a draw.',
    ],
    strategies: [
      'Plan ahead and anticipate your opponent’s moves.',
      'Focus on creating multiple lines of four simultaneously.',
      'Block your opponent’s attempts to connect four discs.',
      'Control the center columns to increase your chances of winning.',
    ],
    benefits: [
      'Develops strategic thinking and planning skills.',
      'Enhances problem-solving abilities.',
      'Encourages patience and careful consideration of each move.',
      'Improves spatial awareness and pattern recognition.',
    ],
    gameWidget: FourInARow(),
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
    required this.keyPhrase,
  });
}
