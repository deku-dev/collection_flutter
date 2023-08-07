import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../database/database.dart';
import '../entity/category.dart' as entity;

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<entity.Category>>(
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
            child: ListView(
              padding: EdgeInsets.zero,
              children: categories!.map((category) => ListTile(
                title: Text(category.name),
                onTap: () {
                  // Handle item click here
                },
              )).toList(),
            ),
          );
        }
      },
    );
  }

  // Function to fetch the list of posts (teasers)
  Future<List<entity.Category>> _fetchTeasers() async {
    AppDatabase database = await AppDatabase.getInstance();
    return await database.categoryDao.findAllCategories();
  }
}
