import 'package:flutter/material.dart';
import 'package:flutter_app/domain/entities/post_entity.dart';
import 'package:flutter_app/presentation/pages/post/post_content.dart';
import 'package:get_it/get_it.dart';
import 'package:qlevar_router/qlevar_router.dart';

import '../../../data/database/database.dart';

class PostPage extends StatelessWidget {
  final postId = QR.params['postId']!.asInt!;

  late final Future<PostEntity?> post = GetIt.I.get<AppDatabase>().postDao.findPostById(postId);

  PostPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post Page'),
      ),
      body: FutureBuilder<PostEntity?>(
        future: post,
        builder: (BuildContext context, AsyncSnapshot<PostEntity?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            debugPrint(snapshot.error.toString());
            return Text('Error: ${snapshot.error}');
          } else {
            final post = snapshot.data!;
            return PostContent(post: post);
          }
        },
      )
    );
  }


}
