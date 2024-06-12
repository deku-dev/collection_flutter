import 'package:Collectioneer/presentation/pages/home/teaser_widget.dart';
import 'package:Collectioneer/presentation/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qlevar_router/qlevar_router.dart';

import '../../../domain/entities/post_entity.dart';
import '../../widgets/sidebar.dart';
import 'home_cubit.dart';
import 'sorting_cubit.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> _refreshPosts(BuildContext context) async {
    context.read<TeaserPostsCubit>().loadTeaserPosts(null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('All items'),
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
          ),
          IconButton(
            icon: const Icon(Icons.sort),
            onPressed: () {
              context.read<SortingCubit>().toggleSortOrder();
            },
          )
        ],
      ),
      drawer: const Sidebar(),
      body: RefreshIndicator(
        onRefresh: () => _refreshPosts(context),
        child: BlocBuilder<TeaserPostsCubit, List<PostEntity>>(
          builder: (context, teaserPosts) {
            return BlocBuilder<SortingCubit, SortOrder>(
              builder: (context, sortOrder) {
                List<PostEntity> sortedPosts = List.from(teaserPosts);
                sortedPosts.sort((a, b) {
                  if (sortOrder == SortOrder.ascending) {
                    return a.title.compareTo(b.title); // Assuming PostEntity has a title property
                  } else {
                    return b.title.compareTo(a.title);
                  }
                });
                return TeaserPostsWidget(teaserPosts: sortedPosts);
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          QR.toName(AppRoutes.createPostPage);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
