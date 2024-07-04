import 'package:epic/cores/screens/error_page.dart';
import 'package:epic/features/auth/model/user_model.dart';
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
    double cardWidth = 250;
    return ValueListenableBuilder<double>(
      valueListenable: _notifierScroll,
      builder: (context, value, _) {
        return PageView.builder(
          controller: _controller,
          itemCount: 5,
          itemBuilder: (context, index) {
            final strategyName = widget.currentUser.strategies[index];
            final percent = (index - value).abs();
            final rotate = percent.clamp(0.0, 1.0);

            return Consumer(
              builder: (context, ref, child) {
                final strategyAsync =
                    ref.watch(strategyStreamProvider(strategyName));
                return strategyAsync.when(
                  data: (strategy) {
                    final strategyData = strategy.strategy;
                    return GestureDetector(
                      onTap: () {
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
                        child: Center(
                          child: Stack(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    height: cardheight,
                                    width: cardWidth,
                                    decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.7),
                                        boxShadow: [
                                          BoxShadow(
                                            color: strategyData.color
                                                .withOpacity(1),
                                            blurRadius: 10,
                                            offset: const Offset(5.0, 5.0),
                                            spreadRadius: 5,
                                          ),
                                        ]),
                                  ),
                                  const SizedBox(height: 20),
                                  Opacity(
                                    opacity: 1 - rotate,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          strategyData.name,
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: strategyData.color,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Transform(
                                alignment: Alignment.centerLeft,
                                transform: Matrix4.identity()
                                  ..setEntry(3, 2, 0.002)
                                  ..rotateY(1.2 * rotate)
                                  ..translate(-rotate * 200),
                                child: Hero(
                                  tag: 'strategy-image-${strategyData.name}',
                                  child: Image.asset(
                                    strategyData.image,
                                    height: cardheight,
                                    width: cardWidth,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ],
                          ),
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
            );
          },
        );
      },
    );
  }
}
