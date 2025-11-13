import 'package:galvan_webapp/api/api_service.dart';
import 'package:galvan_webapp/di/injection.dart';
import 'package:galvan_webapp/screens/login/login.dart';
import 'package:galvan_webapp/screens/nft_form/nft_form_screen.dart';
import 'package:galvan_webapp/screens/nft_home/nft_home_screen.dart';
import 'package:galvan_webapp/screens/proof_of_action/proof_of_action_screen.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  AppRouter();
  final ApiService apiService = getIt<ApiService>();

  late final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/home',
        name: 'home',
        builder: (context, state) => const ProofOfActionHomeScreen(),
      ),
      GoRoute(
        path: '/nfts',
        name: 'nft_home',
        builder: (context, state) => NftHomeScreen(),
      ),
      GoRoute(
        path: '/nfts/new',
        name: 'nft_form_new',
        builder: (context, state) => NftFormScreen(),
      ),
      GoRoute(
        path: '/nfts/edit/:id',
        name: 'nft_form_edit',
        builder: (context, state) {
          final id = int.tryParse(state.pathParameters['id'] ?? '');
          return NftFormScreen(nftId: id); // soporta edición
        },
      ),
      GoRoute(
        path: '/proof_of_action',
        name: 'proof_of_action',
        builder: (context, state) => const ProofOfActionHomeScreen(),
      ),
    ],
    redirect: (context, state) {
      final loggedIn =
          apiService.jwtToken != null && apiService.jwtToken!.isNotEmpty;
      final loggingIn = state.matchedLocation == '/';

      if (!loggedIn && !loggingIn) {
        return '/';
      }

      if (loggedIn && loggingIn) {
        return '/home';
      }

      return null;
    },
    debugLogDiagnostics: true,
  );
}
