import 'package:flutter/material.dart';
import 'package:flutter_app/domain/entities/post_entity.dart';
import 'package:flutter_app/presentation/routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qlevar_router/qlevar_router.dart';

import '../../widgets/image_fallback.dart';
import '../../widgets/sidebar.dart';
import 'home_cubit.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
          )
        ],
      ),
      drawer: const Sidebar(),
      body: BlocProvider(
        create: (context) => TeaserPostsCubit()..loadTeaserPosts(),
        child: const TeasersWidget(),
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

class TeasersWidget extends StatelessWidget {
  const TeasersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TeaserPostsCubit, List<PostEntity>>(
      builder: (context, teaserPosts) {
        return GridView.builder(
          padding: const EdgeInsets.all(16.0),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16.0,
            crossAxisSpacing: 16.0,
            childAspectRatio: 0.75,
          ),
          itemCount: teaserPosts.length,
          itemBuilder: (context, index) {
            final post = teaserPosts[index];
            return GestureDetector(
              onTap: () {
                QR.toName(AppRoutes.postPage, params: {'postId': post.id});
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                elevation: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(16.0),
                          topRight: Radius.circular(16.0),
                        ),
                        child: NetworkImageWithFallback(imageUrl: post.firstImage),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(16.0),
                          bottomRight: Radius.circular(16.0),
                        ),
                      ),
                      child: Text(
                        post.title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
