import 'package:flutter/material.dart';
import 'package:flutter_app/blocks/GridMain.dart';
import 'package:flutter_app/pages/category_filter.dart';
import 'package:flutter_app/pages/create_post_form.dart';
import 'package:flutter_app/pages/favorites.dart';
import 'package:flutter_app/pages/filter_form.dart';
import 'package:flutter_app/pages/main.dart';
import 'package:flutter_app/pages/search.dart';
import 'package:flutter_app/pages/settings.dart';
import 'package:get_it/get_it.dart';

import 'components/sidebar.dart';
import 'database/database.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  GetIt getIt = GetIt.I;

  getIt.registerSingletonAsync<AppDatabase>(
      () async => await AppDatabase.getInstance()
  );



  getIt<AppDatabase>().seriesDao.findAllSeriesId();
  const count = 100;
  getIt<AppDatabase>().countryDao.insertFake(count);
  getIt<AppDatabase>().typeDao.insertFake(count);
  getIt<AppDatabase>().categoryDao.insertFake(count);
  getIt<AppDatabase>().postDao.insertFake(count);
  getIt<AppDatabase>().seriesDao.insertFake(count);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => MainPage(),
        '/category-filter': (context) => CategoryFilterPage(),
        '/filter-form': (context) => FilterFormPage(),
        '/create-post-form': (context) => CreatePostFormPage(),
        '/favorites': (context) => FavoritesPage(),
        '/search': (context) => SearchPage(),
        '/settings': (context) => SettingsPage(),
      },
      builder: (BuildContext context, Widget? child) {
        return Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            title: const Text('Your App Name'),
            leading: IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                _scaffoldKey.currentState?.openDrawer();
              },
            ),
          ),
          drawer: Sidebar(),
          body: child,
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: const Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: GridMain(),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () { Navigator.pushNamed(context, '/'); },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
