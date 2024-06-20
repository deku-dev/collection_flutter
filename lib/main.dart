import 'dart:io';

import 'package:Collectioneer/presentation/core.dart';
import 'package:Collectioneer/presentation/pages/home/home_cubit.dart';
import 'package:Collectioneer/presentation/pages/home/sorting_cubit.dart';
import 'package:Collectioneer/presentation/pages/settings/theme_notifier.dart';
import 'package:Collectioneer/presentation/widgets/sidebar_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

import 'data/database/database.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  GetIt getIt = GetIt.I;

  getIt.registerSingletonAsync<AppDatabase>(
      () async => await AppDatabase.getInstance()
  );

  await copyAssetToAppDirectory('assets/default_image.png', 'default_image.png');

  await getIt.allReady();
  // const count = 3;
  // getIt<AppDatabase>().countryDao.insertFake(count);
  // getIt<AppDatabase>().typeDao.insertFake(count);
  // getIt<AppDatabase>().categoryDao.insertFake(count);
  // getIt<AppDatabase>().seriesDao.insertFake(count);



  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => TeaserPostsCubit()..loadTeaserPosts(null)),
        BlocProvider(create: (_) => ThemeCubit()),
        BlocProvider(create: (_) => SidebarCubit()),
        BlocProvider(create: (_) => SortingCubit()),
      ],
      child: const Core(),
    );
  }
}

Future<String> copyAssetToAppDirectory(String assetPath, String filename) async {
  try {
    // Load asset as ByteData
    final byteData = await rootBundle.load(assetPath);

    // Get application documents directory
    final Directory appDir = await getApplicationDocumentsDirectory();
    final String collectionDirPath = path.join(appDir.path, 'Collection');

    // Ensure the collection directory exists
    final Directory collectionDir = Directory(collectionDirPath);
    if (!await collectionDir.exists()) {
      await collectionDir.create(recursive: true);
    }

    // Create a file in the application directory
    final file = File(path.join(collectionDirPath, filename));

    // Write the ByteData to the file
    await file.writeAsBytes(byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

    // Return the file path
    return file.path;
  } catch (e) {
    // Handle any errors
    throw Exception("Error copying asset to app directory: $e");
  }
}

