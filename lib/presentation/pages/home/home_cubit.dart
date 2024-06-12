import 'package:Collectioneer/data/database/database.dart';
import 'package:Collectioneer/domain/entities/post_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TeaserPostsCubit extends Cubit<List<PostEntity>> {
  TeaserPostsCubit() : super([]);

  Future<void> loadTeaserPosts(int? category) async {
    AppDatabase database = await AppDatabase.getInstance();
    final postDao = database.postDao;

    final teasers = category != null ?
    await postDao.findPostByCategory(category) :
    await postDao.findAllPosts();

    emit(teasers);
  }

  Future<void> removePost(int? postId) async {
    if (postId != null) {
      final updatedPosts = state.where((post) => post.id != postId).toList();
      emit(updatedPosts);
    }

  }
}
