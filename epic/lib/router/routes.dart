import 'package:epic/screens/home_screen.dart';
import 'package:go_router/go_router.dart';

class Routes {
  static final _router = GoRouter(
    debugLogDiagnostics: false,
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomeScreen(),
      ),
    ],
  );

  static GoRouter get getRouter => _router;
}
