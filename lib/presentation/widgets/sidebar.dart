import 'package:flutter/material.dart';
import 'package:flutter_app/domain/entities/category_entity.dart';

import '../../data/database/database.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CategoryEntity>>(
      future: _fetchTeasers(), // Call the function to fetch the list of posts (categories)
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // While waiting for the future to complete, show a loading indicator
          return const Drawer(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasError) {
          // If an error occurred while fetching the data, show an error message
          return const Drawer(
            child: Center(
              child: Text('Error loading data'),
            ),
          );
        } else {
          // If the future has completed successfully, display the fetched data
          final categories = snapshot.data;
          return Drawer(
            child: Column(
              children: [
                UserAccountsDrawerHeader(
                  accountName: Text('User Name', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
                  accountEmail: Text('user.email@example.com'),
                  currentAccountPicture: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Text(
                      'U',
                      style: TextStyle(fontSize: 40.0, color: Colors.blue),
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16.0),
                  child: const Text(
                    'Categories',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: categories!.map((category) => ListTile(
                      leading: Icon(Icons.category),
                      title: Text(
                        category.name,
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                      onTap: () {
                        // Handle item click here
                      },
                    )).toList(),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.settings),
                  title: Text('Settings'),
                  onTap: () {
                    // Handle settings click here
                  },
                ),
                ListTile(
                  leading: Icon(Icons.logout),
                  title: Text('Logout'),
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

  // Function to fetch the list of posts (teasers)
  Future<List<CategoryEntity>> _fetchTeasers() async {
    AppDatabase database = await AppDatabase.getInstance();
    return await database.categoryDao.findAllCategories();
  }
}
