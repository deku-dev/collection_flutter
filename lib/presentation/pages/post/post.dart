import 'package:Collectioneer/domain/entities/post_entity.dart';
import 'package:Collectioneer/presentation/pages/post/post_content.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:qlevar_router/qlevar_router.dart';

import '../../../data/database/database.dart';
import '../../routes.dart';
import '../home/home_cubit.dart';

class PostPage extends StatefulWidget {
  final int postId = QR.params['id']!.asInt!;
  final TeaserPostsCubit teaserPostsCubit;

  PostPage({Key? key, required this.teaserPostsCubit}) : super(key: key);

  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  late Future<PostEntity?> post;

  @override
  void initState() {
    super.initState();
    post = GetIt.I.get<AppDatabase>().postDao.findPostById(widget.postId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post Page'),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(
              Icons.more_vert,
            ),
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem(
                value: 'edit',
                child: Text(
                  'Edit',
                  style: TextStyle(color: Colors.black), // Customize the text color
                ),
              ),
              const PopupMenuItem(
                value: 'create_nft',
                child: Text(
                  'Create NFT',
                  style: TextStyle(color: Colors.black), // Customize the text color
                ),
              ),
              const PopupMenuItem(
                value: 'delete',
                child: Text(
                  'Delete',
                  style: TextStyle(color: Colors.black), // Customize the text color
                ),
              ),
            ],
            onSelected: (value) {
              if (value == 'edit') {
                QR.toName(AppRoutes.editPostPage, params: {'id': widget.postId});
              } else if (value == 'delete') {
                _showDeleteConfirmationDialog();
              } else if (value == 'create_nft') {
                _createNFT(post as PostEntity);
              }
            },
          ),
        ],
      ),
      body: FutureBuilder<PostEntity?>(
        future: post,
        builder: (BuildContext context, AsyncSnapshot<PostEntity?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            debugPrint(snapshot.error.toString());
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final post = snapshot.data!;
            return PostContent(
              post: post,
            );
          }
        },
      ),
    );
  }

  void _showDeleteConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Post'),
          content: const Text('Are you sure you want to delete this post?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Delete'),
              onPressed: () {
                _deletePost();
              },
            ),
          ],
        );
      },
    );
  }

  void _createNFT(PostEntity post) {

  }

  Future<void> _deletePost() async {
    final db = GetIt.I.get<AppDatabase>();
    final postEntity = await post;
    if (postEntity != null) {
      await db.postDao.deletePost(postEntity);
      if (mounted) {
        Navigator.of(context).pop(); // Close the dialog
        widget.teaserPostsCubit.removePost(postEntity.id);
        QR.back(); // Navigate back to the previous screen
      }
    }
  }
}
