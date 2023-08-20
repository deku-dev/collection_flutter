import 'package:floor/floor.dart';
import 'package:flutter_app/domain/entities/category_entity.dart';
import 'package:faker/faker.dart';

@dao
abstract class CategoryDao {
  @Query('SELECT * FROM CategoryEntity')
  Future<List<CategoryEntity>> findAllCategories();

  @Query('SELECT id FROM CategoryEntity')
  Future<List<int>> findAllCategoriesId();

  @Query('SELECT * FROM CategoryEntity WHERE id = :id')
  Future<CategoryEntity?> findCategoryById(int id);

  @insert
  Future<void> insertCategory(CategoryEntity category);

  @update
  Future<void> updateCategory(CategoryEntity category);

  @delete
  Future<void> deleteCategory(CategoryEntity category);

  Future<void> insertFake(int count) async {
    final faker = Faker();
    for (var i = 0; i < count; i++) {
      final category = CategoryEntity(null, faker.food.dish());
      await insertCategory(category);
    }
  }
}