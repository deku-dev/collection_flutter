import 'package:flutter_app/presentation/pages/create_post/create_post_form.dart';
import 'package:flutter_app/presentation/pages/home/home_page.dart';
import 'package:flutter_app/presentation/pages/not_found_page.dart';
import 'package:flutter_app/presentation/pages/settings.dart';
import 'package:qlevar_router/qlevar_router.dart';

class AppRoutes {
  static String homePage = 'Home Page';
  static String userPage = 'User Page';
  static String settingsPage = 'Settings Page';

  void setupRouter() {
    QR.settings.notFoundPage = QRoute(path: '/404', builder: ()=> NotFoundPage());
  }

  final routes = [
    QRoute(name: homePage, path: '/', builder: () => HomePage()),
    QRoute(path: '/post/:postId', builder: () => HomePage()),
    QRoute(path: '/create-post', builder: () => const CreatePostFormPage()),
    QRoute(
        name: userPage,
        path: '/user/:userId',
        builder: () => SettingsPage(),
        children: [
          QRoute(name: settingsPage, path: '/settings', builder: () => SettingsPage()),
        ]),
  ];
}