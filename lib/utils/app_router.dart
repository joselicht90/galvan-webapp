import 'package:galvan_webapp/screens/home/home.dart';
import 'package:galvan_webapp/screens/login/login.dart';
import 'package:galvan_webapp/screens/nft_form/nft_form_screen.dart';
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
      GoRoute(path: '/nft_form', builder: (context, state) => NftFormScreen()),
    ],
    redirect: (context, state) {
      final loggedIn =
          apiService.jwtToken != null && apiService.jwtToken!.isNotEmpty;
      final loggingIn = state.matchedLocation == '/';

      if (!loggedIn && !loggingIn) {
        // No logueado y quiere entrar a una página privada
        return '/';
      }

      if (loggedIn && loggingIn) {
        // Ya logueado e intenta ir al login
        return '/home';
      }

      return null;
    },
    debugLogDiagnostics: true, // opcional: para debug
  );
}
