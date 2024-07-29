import 'package:epic/cores/app_constants.dart';
import 'package:epic/cores/screens/error_page.dart';
import 'package:epic/features/auth/model/user_model.dart';
import 'package:epic/cores/widgets/background_animation.dart';
import 'package:epic/features/auth/repository/user_data_service.dart';
import 'package:epic/features/strategies/pages/strategy_detail_page.dart';
import 'package:epic/features/strategies/provider/strategy_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StrategyView extends StatefulWidget {
  final UserModel currentUser;
  const StrategyView({
    required this.currentUser,
    super.key,
  });

  @override
  State<StrategyView> createState() => _StrategyViewState();
}

class _StrategyViewState extends State<StrategyView> {
  final PageController _controller = PageController();
  final _notifierScroll = ValueNotifier(0.0);
  void listener() {
    _notifierScroll.value = _controller.page!;
  }

  @override
  void initState() {
    _controller.addListener(listener);
    super.initState();
  }

  @override
  void dispose() {
    _controller.removeListener(listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double cardheight = 280;
    double cardWidth = 280;
    return ValueListenableBuilder<double>(
      valueListenable: _notifierScroll,
      builder: (context, value, _) {
        return PageView.builder(
          controller: _controller,
          itemCount: 5,
          itemBuilder: (context, index) {
            final strategyName = widget.currentUser.strategies[index];

            return Center(
              child: Consumer(
                builder: (context, ref, child) {
                  final strategyAsync =
                      ref.watch(strategyStreamProvider(strategyName));
                  return strategyAsync.when(
                    data: (strategy) {
                      final strategyData = strategy.strategy;
                      return GestureDetector(
                        onTap: () {
                          ref
                              .read(userDataServiceProvider)
                              .updateLastSeenStrategy(strategyData.name);

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => StrategyDetailPage(
                                strategyName: strategyData.name,
                              ),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Material(
                                elevation: 20,
                                shadowColor: strategyData.color,
                                child: Container(
                                  height: cardheight,
                                  width: cardWidth,
                                  decoration: BoxDecoration(
                                    color: strategyData.color.withOpacity(0.3),
                                  ),
                                  child: Background(
                                    color1: strategyData.color.withOpacity(0.1),
                                    color2: strategyData.color.withOpacity(0.3),
                                    color3: strategyData.color.withOpacity(0.5),
                                    color4: strategyData.color.withOpacity(0.7),
                                    color5: strategyData.color.withOpacity(0.9),
                                  ),
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    "assets/images/strategies/${strategyData.name}.png",
                                    height: 150,
                                  ),
                                  const SizedBox(height: 20),
                                  Text(
                                    strategyData.name,
                                    style: const TextStyle(
                                      fontSize: 28,
                                      color: AppConstants.primaryTextColor,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 2,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    error: (error, stackTrace) => ErrorPage(
                      message: error.toString() + stackTrace.toString(),
                    ),
                    loading: () {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}
