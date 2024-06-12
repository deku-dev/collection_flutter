import 'package:Collectioneer/data/database/database.dart';
import 'package:Collectioneer/domain/entities/post_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class CategoryPostsCubit extends Cubit<List<PostEntity>> {
  CategoryPostsCubit() : super([]);

  Future<void> loadCategoryPosts(int id) async {
    final posts = await GetIt.I<AppDatabase>().postDao.findPostByCategory(id);
    emit(posts);
  }
}
