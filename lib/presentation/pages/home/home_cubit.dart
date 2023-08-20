import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_app/data/database/database.dart';
import 'package:flutter_app/domain/entities/post_entity.dart';

class TeaserPostsCubit extends Cubit<List<PostEntity>> {
  TeaserPostsCubit() : super([]);

  Future<void> loadTeaserPosts() async {
    AppDatabase database = await AppDatabase.getInstance();
    final postDao = database.postDao;
    final teasers = await postDao.findAllPosts();

    emit(teasers);
  }
}
