import 'package:epic/cores/app_constants.dart';

import 'package:epic/cores/games/games.dart';
import 'package:epic/cores/games/game_internals/provider/game_provider.dart';
import 'package:epic/cores/widgets/cloud_text_box.dart';
import 'package:epic/features/strategies/model/strategy_model.dart';
import 'package:epic/features/strategies/provider/strategy_provider.dart';
import 'package:epic/features/strategies/strategies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ActivityOverview extends ConsumerWidget {
  final StrategyModel model;
  final Function(StrategyNav) changeNav;

  const ActivityOverview(
      {required this.changeNav, required this.model, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Game game = model.strategy.game;
    Strategies strategy = model.strategy;

    return Scaffold(
      backgroundColor: AppConstants.primaryBackgroundColor,
      floatingActionButton: TextButton(
        style: TextButton.styleFrom(
          elevation: 5,
          shadowColor: model.strategy.color,
          backgroundColor: model.strategy.color,
          padding: const EdgeInsets.all(16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        onPressed: () {
          final gameService = ref.watch(gameServiceProvider);
          gameService.setGame(strategyModel: model);
          gameService.updateLastPlayed();
          changeNav(StrategyNav.activity);
        },
        child: const Text(
          'Start Activity',
          style: TextStyle(
              fontSize: 16,
              color: AppConstants.primaryTextColor,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Activity',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppConstants.secondaryBackgroundColor,
                        ),
                      ),
                      Text(
                        game.name,
                        style: const TextStyle(
                            fontSize: 26,
                            color: AppConstants.primaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      "assets/images/strategies/${model.strategy.name}.png",
                      height: 90,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                game.description,
                style:
                    const TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
              ),
              Center(
                child: CloudTextBox(
                    strategyColor: strategy.color,
                    height: 230,
                    width: MediaQuery.of(context).size.width,
                    text: game.keyPhrase,
                    textStyle: const TextStyle(
                      color: AppConstants.primaryTextColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    )),
              ),
              const Text(
                'Benefits',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppConstants.secondaryBackgroundColor),
              ),
              SizedBox(
                height: 240,
                child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    for (String benefit in game.benefits)
                      ListTile(
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        leading: const Icon(Icons.fiber_manual_record,
                            size: 15, color: AppConstants.secondaryTextColor),
                        title: Text(
                          benefit,
                          style: const TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      )
                  ],
                ),
              ),
              const Text('Rules',
                  style: TextStyle(
                      color: AppConstants.secondaryBackgroundColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
              SizedBox(
                height: 300,
                child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    for (String benefit in game.rules)
                      ListTile(
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        leading: const Icon(Icons.fiber_manual_record,
                            size: 15, color: AppConstants.secondaryTextColor),
                        title: Text(
                          benefit,
                          style: const TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
