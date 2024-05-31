
import 'package:faker/faker.dart';
import 'package:floor/floor.dart';
import 'package:flutter_app/domain/entities/category_entity.dart';

import 'base_dao.dart';

@dao
abstract class CategoryDao extends BaseDao<CategoryEntity> {

  @Query('SELECT * FROM CategoryEntity')
  Future<List<CategoryEntity>> findAllCategories();

  @Query('SELECT id FROM CategoryEntity')
  Future<List<int>> findAllCategoriesId();

  @Query('SELECT * FROM CategoryEntity WHERE id = :id')
  Future<CategoryEntity?> findCategoryById(int id);

  @update
  Future<void> updateItem(CategoryEntity category);

  @delete
  Future<void> deleteItem(CategoryEntity category);

  Future<void> insertFake(int count) async {
    final faker = Faker();
    for (var i = 0; i < count; i++) {
      final category = CategoryEntity(null, faker.food.dish());
      await insertItem(category);
    }
  }
}
