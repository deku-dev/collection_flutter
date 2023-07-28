import 'package:flutter/material.dart';
import 'package:flutter_app/pages/post.dart';

import '../database/database.dart';
import '../entity/post.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  TeasersWidgetState createState() => TeasersWidgetState();
}

class TeasersWidgetState extends State<MainPage> {
  List<Post> _teaserPosts = [];

  @override
  void initState() {
    super.initState();
    _loadTeaserPosts();
  }

  Future<void> _loadTeaserPosts() async {
    AppDatabase database = await AppDatabase.getInstance();
    final postDao = database.postDao;
    final teasers = await postDao.findAllPosts();

    setState(() {
      _teaserPosts = teasers;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16.0,
        crossAxisSpacing: 16.0,
      ),
      itemCount: _teaserPosts.length,
      itemBuilder: (context, index) {
        final post = _teaserPosts[index];
        return GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => PostPage(post: post)));
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
            ));
      },
    );
  }
}
