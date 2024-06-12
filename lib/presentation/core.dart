import 'package:Collectioneer/presentation/pages/home/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qlevar_router/qlevar_router.dart';

import 'pages/settings/theme_notifier.dart';
import 'routes.dart';

class Core extends StatelessWidget {
  const Core({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appRoutes = AppRoutes(teaserPostsCubit: context.read<TeaserPostsCubit>());
    appRoutes.setupRouter();

    return BlocBuilder<ThemeCubit, bool>(
      builder: (context, isDarkMode) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routeInformationParser: const QRouteInformationParser(),
          routerDelegate: QRouterDelegate(appRoutes.routes),
          title: 'Flutter Demo',
          theme: isDarkMode ? ThemeData.dark().copyWith() : ThemeData.light().copyWith(),
          restorationScopeId: 'app',
        );
      },
    );
  }
}