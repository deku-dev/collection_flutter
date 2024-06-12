import 'package:Collectioneer/data/database/database.dart';
import 'package:Collectioneer/domain/entities/post_entity.dart';
import 'package:flutter/material.dart';

class TeaserPostsProvider extends ChangeNotifier {
  List<PostEntity> _teaserPosts = [];

  List<PostEntity> get teaserPosts => _teaserPosts;

  Future<void> loadTeaserPosts(int? category) async {
    try {
      AppDatabase? database = await AppDatabase.getInstance();
      final postDao = database.postDao;

      final teasers = category != null ?
      await postDao.findPostByCategory(category) :
      await postDao.findAllPosts();

      _teaserPosts = teasers;
      notifyListeners();
    } catch (e) {
      // Handle exception, e.g., log the error or show a message to the user
      debugPrint('Failed to load teaser posts: $e');
    }
  }

  void addPost(PostEntity post) {
    _teaserPosts.add(post);
    notifyListeners();
  }

  void removePost(PostEntity post) {
    _teaserPosts.remove(post);
    notifyListeners();
  }

  void updatePost(PostEntity post) {
    int index = _teaserPosts.indexWhere((p) => p.id == post.id);
    if (index != -1) {
      _teaserPosts[index] = post;
      notifyListeners();
    }
  }

  void clearPosts() {
    _teaserPosts.clear();
    notifyListeners();
  }
}
