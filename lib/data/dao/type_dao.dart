import 'package:Collectioneer/data/dao/base_dao.dart';
import 'package:Collectioneer/domain/entities/type_entity.dart';
import 'package:faker/faker.dart';
import 'package:floor/floor.dart';

@dao
abstract class TypeDao extends BaseDao<TypeEntity> {
  @Query('SELECT * FROM TypeEntity')
  Future<List<TypeEntity>> findAllTypes();

  @Query('SELECT id FROM TypeEntity')
  Future<List<int>> findAllTypesId();

  @Query('SELECT * FROM TypeEntity WHERE id = :id')
  Future<TypeEntity?> findTypeById(int id);

  @update
  Future<void> updateItem(TypeEntity type);

  @delete
  Future<void> deleteItem(TypeEntity type);

  Future<void> insertFake(int count) async {
    final faker = Faker();
    for (var i = 0; i < count; i++) {
      final type = TypeEntity(null, faker.sport.name());
      await insertItem(type);
    }
  }
}