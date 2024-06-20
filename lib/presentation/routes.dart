import 'package:Collectioneer/presentation/pages/category/category_page.dart';
import 'package:Collectioneer/presentation/pages/create_post/create_post_form.dart';
import 'package:Collectioneer/presentation/pages/home/home_cubit.dart';
import 'package:Collectioneer/presentation/pages/home/home_page.dart';
import 'package:Collectioneer/presentation/pages/login/login_page.dart';
import 'package:Collectioneer/presentation/pages/not_found_page.dart';
import 'package:Collectioneer/presentation/pages/post/post.dart';
import 'package:Collectioneer/presentation/pages/settings/settings.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qlevar_router/qlevar_router.dart';


class AppRoutes {
  static const String homePage = 'Home Page';
  static const String userPage = 'User Page';
  static const String settingsPage = 'Settings Page';
  static const String postPage = 'Post Page';
  static const String createPostPage = 'Create Post Page';
  static const String categoryPage = 'Category Page';
  static const String editPostPage = 'Edit Post Page';
  static const String loginPage = 'Login Page';

  final TeaserPostsCubit teaserPostsCubit;

  AppRoutes({required this.teaserPostsCubit});

  void setupRouter() {
    QR.settings.notFoundPage = QRoute(path: '/404', builder: () => const NotFoundPage());
  }

  List<QRoute> get routes => [
    QRoute(name: homePage, path: '/', builder: () => HomePage()),
    QRoute(
      name: postPage,
      path: '/post/:id',
      builder: () => BlocProvider.value(
        value: teaserPostsCubit,
        child: PostPage(teaserPostsCubit: teaserPostsCubit),
      ),
    ),
    QRoute(name: createPostPage, path: '/create-post', builder: () => CreatePostFormPage()),
    QRoute(name: settingsPage, path: '/settings', builder: () => const SettingsPage()),
    QRoute(name: categoryPage, path: '/category/:id', builder: () => CategoryPage()),
    QRoute(name: editPostPage, path: '/post-edit/:id', builder: () => CreatePostFormPage()),
    QRoute(name: loginPage, path: '/login', builder: () => LoginPage())
  ];
}
