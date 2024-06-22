import 'package:epic/features/auth/model/user_model.dart';
import 'package:epic/features/discover/widgets/strategy_card.dart';
import 'package:flutter/material.dart';

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
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      viewportFraction: 0.8,
      initialPage: _currentPage,
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return RawScrollbar(
  //     controller: _pageController,
  //     thumbColor: AppConstants.primaryColor,
  //     thickness: 3,
  //     radius: const Radius.circular(30),
  //     thumbVisibility: true,
  //     child: GridView.builder(
  //       padding: EdgeInsets.zero,
  //       physics: const BouncingScrollPhysics(),
  //       gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
  //         maxCrossAxisExtent: 175.0,
  //         mainAxisExtent: 175,
  //         childAspectRatio: 0.4,
  //       ),
  //       itemCount: 5,
  //       controller: _pageController,
  //       itemBuilder: (context, index) {
  //         bool isActive = index == _currentPage;
  //         return SizedBox(
  //           height: 200,
  //           width: MediaQuery.of(context).size.width / 3,
  //           child: GestureDetector(
  //             onTap: () {
  //               setState(() {
  //                 _currentPage = index;
  //               });
  //             },
  //             child: Center(
  //               child: _buildCard(
  //                   StrategyCard(
  //                     strategyName: widget.currentUser.strategies[index],
  //                   ),
  //                   isActive),
  //             ),
  //           ),
  //         );
  //       },
  //     ),
  //   );
  // }
  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      itemCount: 5,
      controller: _pageController,
      onPageChanged: (index) {
        setState(() {
          _currentPage = index;
        });
      },
      itemBuilder: (context, index) {
        bool isActive = index == _currentPage;
        return Padding(
          padding: const EdgeInsets.only(bottom: 15.0),
          child: Center(
            child: _buildCard(
                StrategyCard(
                  strategyName: widget.currentUser.strategies[index],
                ),
                isActive),
          ),
        );
      },
    );
  }
}

Widget _buildCard(Widget card, bool isActive) {
  double scaleFactor = isActive ? 1 : 0.8;
  return AnimatedContainer(
    padding: const EdgeInsets.all(08),
    duration: const Duration(milliseconds: 350),
    curve: Curves.easeInOut,
    transform: Matrix4.identity()..scale(scaleFactor, scaleFactor),
    child: card,
  );
}
