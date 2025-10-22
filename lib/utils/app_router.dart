import 'package:galvan_webapp/screens/home/home.dart';
import 'package:galvan_webapp/screens/login/login.dart';
import 'package:go_router/go_router.dart';
import '../api/api_service.dart';

class AppRouter {
  final ApiService apiService;

  AppRouter({required this.apiService});

  late final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(path: '/', builder: (context, state) => const LoginScreen()),
      GoRoute(path: '/home', builder: (context, state) => const HomeScreen()),
    ],
    redirect: (context, state) {
      final loggedIn = apiService.jwtToken != null;
      final loggingIn = state.matchedLocation == '/';
      if (!loggedIn && !loggingIn) return '/';
      if (loggedIn && loggingIn) return '/home';
      return null;
    },
    debugLogDiagnostics: true, // opcional: para debug
  );
}
