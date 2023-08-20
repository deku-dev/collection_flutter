import 'package:flutter/material.dart';
import 'package:flutter_app/presentation/core.dart';
import 'package:get_it/get_it.dart';

import 'data/database/database.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  GetIt getIt = GetIt.I;

  getIt.registerSingletonAsync<AppDatabase>(
      () async => await AppDatabase.getInstance()
  );

  await getIt.allReady();
  const count = 10;
  getIt<AppDatabase>().countryDao.insertFake(count);
  getIt<AppDatabase>().typeDao.insertFake(count);
  getIt<AppDatabase>().categoryDao.insertFake(count);
  getIt<AppDatabase>().postDao.insertFake(count);
  getIt<AppDatabase>().seriesDao.insertFake(count);

  runApp(const Core());
}

