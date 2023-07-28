import 'package:floor/floor.dart';
import 'package:flutter_app/entity/category.dart';
import 'package:faker/faker.dart';

@dao
abstract class CategoryDao {
  @Query('SELECT * FROM Category')
  Future<List<Category>> findAllCategories();

  @Query('SELECT id FROM Category')
  Future<List<int>> findAllCategoriesId();

  @Query('SELECT * FROM Category WHERE id = :id')
  Future<Category?> findCategoryById(int id);

  @insert
  Future<void> insertCategory(Category category);

  @update
  Future<void> updateCategory(Category category);

  @delete
  Future<void> deleteCategory(Category category);

  Future<void> insertFake(int count) async {
    final faker = Faker();
    for (var i = 0; i < count; i++) {
      final category = Category(null, faker.food.dish());
      await insertCategory(category);
    }
  }
}