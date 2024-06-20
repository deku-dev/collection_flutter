// required package imports
import 'dart:async';

import 'package:Collectioneer/data/dao/user_dao.dart';
import 'package:Collectioneer/domain/entities/user_entity.dart';
import 'package:floor/floor.dart';
import 'package:sqflite_sqlcipher/sqflite.dart' as sqflite;

import '../../domain/entities/category_entity.dart';
import '../../domain/entities/country_entity.dart';
import '../../domain/entities/post_entity.dart';
import '../../domain/entities/series_entity.dart';
import '../../domain/entities/type_entity.dart';
import '../dao/category_dao.dart';
import '../dao/country_dao.dart';
import '../dao/post_dao.dart';
import '../dao/series_dao.dart';
import '../dao/type_dao.dart';

part 'database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [PostEntity, CategoryEntity, CountryEntity, TypeEntity, SeriesEntity, UserEntity])
abstract class AppDatabase extends FloorDatabase {
  PostDao get postDao;
  CategoryDao get categoryDao;
  CountryDao get countryDao;
  TypeDao get typeDao;
  SeriesDao get seriesDao;
  UserDao get userDao;

  static AppDatabase? _instance;

  static Future<AppDatabase> getInstance() async {
    return _instance ??= await $FloorAppDatabase
        .databaseBuilder('app_database.db')
        .addCallback(Callback(
      onCreate: (database, version) async {
        await database.execute('PRAGMA key = "test";');
      },
      onOpen: (database) async {
        await database.execute('PRAGMA key = "test";');
      },
    ))
        .build();
  }
}
