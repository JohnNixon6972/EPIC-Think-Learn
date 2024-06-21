import 'package:epic/cores/app_constants.dart';
import 'package:epic/cores/screens/error_page.dart';
import 'package:epic/cores/screens/loader.dart';
import 'package:epic/features/strategies/model/strategy_model.dart';
import 'package:epic/features/strategies/provider/strategy_provider.dart';
import 'package:epic/features/strategies/widgets/activity_overview.dart';
import 'package:epic/features/strategies/widgets/custom_strategies_app_bar.dart';
import 'package:epic/features/strategies/widgets/strategy_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StrategyDetailPage extends ConsumerWidget {
  final String strategyName;
  const StrategyDetailPage({
    required this.strategyName,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final strategyAsync = ref.watch(strategyStreamProvider(strategyName));
    return strategyAsync.when(
        data: (model) {
          return StrategyBody(
            model: model,
          );
        },
        loading: () => const Loader(),
        error: (error, stack) => ErrorPage(message: error.toString()));
  }
}

class StrategyBody extends StatefulWidget {
  final StrategyModel model;
  const StrategyBody({
    required this.model,
    super.key,
  });

  @override
  State<StrategyBody> createState() => _StrategyBodyState();
}

class _StrategyBodyState extends State<StrategyBody> {
  StrategyNav _currentNav = StrategyNav.detail;

  void _changeNav(StrategyNav nav) {
    setState(() {
      _currentNav = nav;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Widget activityWidget = widget.model.strategy.game.gameWidget;

    return Scaffold(
        backgroundColor: AppConstants.primaryBackgroundColor,
        appBar: CustomStrategiesAppBar(
            changeNav: _changeNav,
            currentNav: _currentNav,
            title: widget.model.strategy.name,
            color: widget.model.strategy.color),
        body: switch (_currentNav) {
          StrategyNav.detail => StrategyDetail(
              model: widget.model,
              changeNav: _changeNav,
            ),
          StrategyNav.activityOverview => ActivityOverview(
              changeNav: _changeNav,
              model: widget.model,
            ),
          StrategyNav.activity => activityWidget
        });
  }
}
