import 'package:flutter/material.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'routes.dart';

class Core extends StatelessWidget {
  const Core({super.key});

  @override
  Widget build(BuildContext context) {
    final appRoutes = AppRoutes();
    appRoutes.setupRouter();
    return MaterialApp.router(
      routeInformationParser: const QRouteInformationParser(),
      routerDelegate: QRouterDelegate(appRoutes.routes),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      restorationScopeId: 'app',
    );
  }
}