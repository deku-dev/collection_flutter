import 'package:Collectioneer/domain/entities/category_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qlevar_router/qlevar_router.dart';

import '../../data/database/database.dart';
import '../routes.dart';
import 'sidebar_cubit.dart';

class Sidebar extends StatefulWidget {
  const Sidebar({Key? key}) : super(key: key);

  @override
  _SidebarState createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  late SidebarCubit _sidebarCubit;

  @override
  void initState() {
    super.initState();
    _sidebarCubit = context.read<SidebarCubit>();
    QR.navigator.addListener(_updateSelectedCategory);
  }

  @override
  void dispose() {
    QR.navigator.removeListener(_updateSelectedCategory);
    super.dispose();
  }

  void _updateSelectedCategory() {
    final currentRoute = QR.currentRoute.name;
    if (currentRoute == AppRoutes.categoryPage) {
      final categoryId = QR.params['id']?.asInt;
      _sidebarCubit.selectCategory(categoryId);
    } else if (currentRoute == AppRoutes.homePage) {
      _sidebarCubit.clearSelection();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CategoryEntity>>(
      future: _fetchCategories(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Drawer(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasError) {
          return const Drawer(
            child: Center(
              child: Text('Error loading data'),
            ),
          );
        } else {
          final categories = snapshot.data ?? [];
          return Drawer(
            child: Column(
              children: [
                UserAccountsDrawerHeader(
                  accountName: const Text(
                    'User Name',
                    style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  accountEmail: const Text('user.email@example.com'),
                  currentAccountPicture: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Text(
                      'U',
                      style: TextStyle(fontSize: 40.0, color: Theme.of(context).primaryColor),
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.view_list),
                  title: const Text(
                    'All Items',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  selected: context.select((SidebarCubit cubit) => cubit.state == null),
                  onTap: () {
                    _sidebarCubit.clearSelection();
                    QR.toName(AppRoutes.homePage); // Navigate to the home page showing all items
                  },
                ),
                Container(
                  padding: const EdgeInsets.all(12.0),
                  child: const Text(
                    'Categories',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: categories.map((category) {
                      return ListTile(
                        leading: const Icon(Icons.category),
                        title: Text(
                          category.name,
                          style: const TextStyle(fontSize: 18.0),
                        ),
                        selected: context.select((SidebarCubit cubit) => cubit.state == category.id),
                        onTap: () {
                          _sidebarCubit.selectCategory(category.id);
                          QR.toName(AppRoutes.categoryPage, params: {'id': category.id.toString()}); // Navigate to the category page
                        },
                      );
                    }).toList(),
                  ),
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.settings),
                  title: const Text('Settings'),
                  onTap: () {
                    QR.toName(AppRoutes.settingsPage);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.logout),
                  title: const Text('Logout'),
                  onTap: () {
                    // Handle logout click here
                  },
                ),
              ],
            ),
          );
        }
      },
    );
  }

  Future<List<CategoryEntity>> _fetchCategories() async {
    final database = await AppDatabase.getInstance();
    return await database.categoryDao.findAllCategories();
  }
}
