import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:galvan_webapp/utils/app_router.dart';
import 'api/api_service.dart';
import 'di/injection.dart'; // si estás usando injectable/get_it

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Carga el .env
  await dotenv.load(fileName: ".env");

  // Configurar dependencias si usas injectable
  await configureDependencies();

  await getIt<ApiService>().loadTokenFromCookie();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appRouter = AppRouter(apiService: getIt<ApiService>());

    return MaterialApp.router(
      title: 'Flutter GALVAN APP',
      routerConfig: appRouter.router,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
