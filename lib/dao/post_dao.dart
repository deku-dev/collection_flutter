import 'package:faker/faker.dart';
import 'package:floor/floor.dart';
import 'package:flutter_app/entity/post.dart';

import '../database/database.dart';

@dao
abstract class PostDao {
  @Query('SELECT * FROM Post')
  Future<List<Post>> findAllPosts();

  @Query('SELECT * FROM Post WHERE id = :id')
  Future<Post?> findPostById(int id);

  @insert
  Future<void> insertPost(Post post);

  @update
  Future<void> updatePost(Post post);

  @delete
  Future<void> deletePost(Post post);

  Future<void> insertFake(int count) async {
    AppDatabase database = await AppDatabase.getInstance();
    final country = await database.countryDao.findAllCountriesId();
    final type = await database.typeDao.findAllTypesId();
    final series = await database.seriesDao.findAllSeriesId();
    final category = await database.categoryDao.findAllCategoriesId();
    final faker = Faker();
    final DateTime currentDate = DateTime.now();
    for (var i = 0; i < count; i++) {
      final post = Post(
          title: faker.job.title(),
          description: faker.lorem.sentence(),
          images: faker.image.image(),
          typeId: type[random.integer(type.length)],
          year: random.integer(2023),
          timestamp: currentDate.millisecondsSinceEpoch,
          inStock: random.boolean(),
          countryId: country[random.integer(country.length)],
          seriesId: series[random.integer(series.length)],
          categoryId: category[random.integer(category.length)]);
      await insertPost(post);
    }
  }
}