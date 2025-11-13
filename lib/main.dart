import 'package:flutter/material.dart';
import 'package:galvan_webapp/utils/app_router.dart';
import 'package:galvan_webapp/utils/theme.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'api/api_service.dart';
import 'di/injection.dart'; // si estás usando injectable/get_it

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Configurar dependencias si usas injectable
  await configureDependencies();

  await getIt<ApiService>().loadTokenFromCookie();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appRouter = AppRouter();

    return ResponsiveSizer(
      maxTabletWidth: 840,
      maxMobileWidth: 640,
      builder: (context, orientation, screenType) {
        return MaterialApp.router(
          title: 'Flutter GALVAN APP',
          routerConfig: appRouter.router,
          theme: appTheme,

        );
      },
    );
  }
}
