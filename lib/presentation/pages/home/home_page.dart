import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_app/domain/entities/post_entity.dart';
import 'package:qlevar_router/qlevar_router.dart';

import '../../widgets/sidebar.dart';
import '../create_post/create_post_form.dart';
import '../post.dart';
import 'home_cubit.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
      ),
      drawer: const Sidebar(),
      body: BlocProvider(
        create: (context) => TeaserPostsCubit()..loadTeaserPosts(),
        child: const TeasersWidget(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          QR.to('/create-post');
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
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16.0,
            crossAxisSpacing: 16.0,
          ),
          itemCount: teaserPosts.length,
          itemBuilder: (context, index) {
            final post = teaserPosts[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PostPage(post: post)),
                );
              },
              child: GridTile(
                footer: GridTileBar(
                  backgroundColor: Colors.black54,
                  title: Text(
                    post.title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                child: Image.network(post.images!, fit: BoxFit.cover),
              ),
            );
          },
        );
      },
    );
  }
}
