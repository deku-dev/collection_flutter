
import 'package:Collectioneer/domain/entities/type_entity.dart';
import 'package:faker/faker.dart';
import 'package:floor/floor.dart';
import 'package:flutter/cupertino.dart';

@dao
abstract class TypeDao {
  @Query('SELECT * FROM TypeEntity')
  Future<List<TypeEntity>> findAllTypes();

  @Query('SELECT id FROM TypeEntity')
  Future<List<int>> findAllTypesId();

  @Query('SELECT * FROM TypeEntity WHERE id = :id')
  Future<TypeEntity?> findTypeById(int id);

  @Query('SELECT * FROM TypeEntity WHERE name = :name')
  Future<TypeEntity?> findByName(String name);

  @update
  Future<void> updateItem(TypeEntity type);

  @delete
  Future<void> deleteItem(TypeEntity type);

  @insert
  Future<void> insertType(TypeEntity item);

  Future<void> insertItem(TypeEntity item) async {
    try {
      await insertType(item);
    } catch (e) {
      debugPrint('Error adding item: $e');
    }
  }

  Future<void> insertFake(int count) async {
    final faker = Faker();
    for (var i = 0; i < count; i++) {
      final type = TypeEntity(null, faker.sport.name());
      await insertItem(type);
    }
  }
}