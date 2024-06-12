import 'package:Collectioneer/domain/entities/category_entity.dart';
import 'package:Collectioneer/presentation/pages/home/teaser_widget.dart';
import 'package:Collectioneer/presentation/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:qlevar_router/qlevar_router.dart';

import '../../../data/database/database.dart';
import '../../../domain/entities/post_entity.dart';
import '../../widgets/sidebar.dart';
import '../home/home_cubit.dart';

class CategoryPage extends StatelessWidget {
  final int categoryId = QR.params['id']!.asInt!;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  CategoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<CategoryEntity?>(
      future: GetIt.I.get<AppDatabase>().categoryDao.findCategoryById(categoryId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            key: _scaffoldKey,
            appBar: AppBar(
              title: const Text('Loading...'),
              leading: IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  _scaffoldKey.currentState?.openDrawer();
                },
              ),
            ),
            drawer: const Sidebar(),
            body: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasError || !snapshot.hasData) {
          return Scaffold(
            key: _scaffoldKey,
            appBar: AppBar(
              title: const Text('Error'),
              leading: IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  _scaffoldKey.currentState?.openDrawer();
                },
              ),
            ),
            drawer: const Sidebar(),
            body: const Center(
              child: Text('Error loading category'),
            ),
          );
        } else {
          final category = snapshot.data!;

          return BlocProvider(
            create: (context) => TeaserPostsCubit()..loadTeaserPosts(categoryId),
            child: Scaffold(
              key: _scaffoldKey,
              appBar: AppBar(
                title: Text(category.name),
                leading: IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () {
                    _scaffoldKey.currentState?.openDrawer();
                  },
                ),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {},
                  )
                ],
              ),
              drawer: const Sidebar(),
              body: BlocBuilder<TeaserPostsCubit, List<PostEntity>>(
                builder: (context, teaserPosts) {
                  return TeaserPostsWidget(teaserPosts: teaserPosts);
                },
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  QR.toName(AppRoutes.createPostPage);
                },
                child: const Icon(Icons.add),
              ),
            ),
          );
        }
      },
    );
  }
}
