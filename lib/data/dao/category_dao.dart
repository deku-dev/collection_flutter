
import 'package:Collectioneer/domain/entities/category_entity.dart';
import 'package:faker/faker.dart';
import 'package:floor/floor.dart';
import 'package:flutter/cupertino.dart';

@dao
abstract class CategoryDao {

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

  @insert
  Future<void> insertCategory(CategoryEntity item);

  Future<void> insertItem(CategoryEntity item) async {
    try {
      await insertCategory(item);
    } catch (e) {
      debugPrint('Error adding item: $e');
    }
  }

  Future<void> insertFake(int count) async {
    final faker = Faker();
    for (var i = 0; i < count; i++) {
      final category = CategoryEntity(null, faker.food.dish());
      await insertItem(category);
    }
  }
}
