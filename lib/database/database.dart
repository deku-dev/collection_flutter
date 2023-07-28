// required package imports
import 'dart:async';

import 'package:floor/floor.dart';
import 'package:flutter_app/dao/series_dao.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import '../dao/category_dao.dart';
import '../dao/country_dao.dart';
import '../dao/post_dao.dart';
import '../dao/type_dao.dart';
import '../entity/category.dart';
import '../entity/country.dart';
import '../entity/post.dart';
import '../entity/series.dart';
import '../entity/type.dart';

part 'database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [Post, Category, Country, Type, Series])
abstract class AppDatabase extends FloorDatabase {
  PostDao get postDao;
  CategoryDao get categoryDao;
  CountryDao get countryDao;
  TypeDao get typeDao;
  SeriesDao get seriesDao;

  static AppDatabase? _instance;

  static Future<AppDatabase> getInstance() async {
    return _instance ??= await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  }

}