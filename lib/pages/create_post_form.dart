import 'package:flutter/material.dart';
import 'package:flutter_app/entity/type.dart';

import '../database/database.dart';
import '../entity/post.dart';

class CreatePostFormPage extends StatefulWidget {
  const CreatePostFormPage({super.key});

  @override
  CreatePostFormState createState() => CreatePostFormState();
}

class CreatePostFormState extends State<CreatePostFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _yearController = TextEditingController();
  final _inStockController = TextEditingController();

  int? _selectedTypeId;
  int? _selectedCategoryId;
  int? _selectedSeriesId;
  int? _selectedCountryId;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _titleController,
            decoration: const InputDecoration(labelText: 'Title'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a title';
              }
              return null;
            },
          ),
          // Add more TextFormField widgets for other fields like description, year, inStock, etc.

          // Dropdown for Type
          FutureBuilder<List<Type>>(
            future: _fetchTypes(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return const Text('Error loading types');
              } else {
                final types = snapshot.data!;
                return DropdownButtonFormField<int>(
                  value: _selectedTypeId,
                  items: types
                      .map((type) => DropdownMenuItem<int>(
                    value: type.id!,
                    child: Text(type.name), // Adjust the property based on your Type class
                  ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedTypeId = value;
                    });
                  },
                  decoration: const InputDecoration(labelText: 'Type'),
                  validator: (value) {
                    if (value == null) {
                      return 'Please select a type';
                    }
                    return null;
                  },
                );
              }
            },
          ),
          // Add similar dropdowns for Series, Category, and Country using FutureBuilders

          ElevatedButton(
            onPressed: _submitForm,
            child: const Text('Create Post'),
          ),
        ],
      ),
    );
  }

  // Function to fetch the list of Types from the database
  Future<List<Type>> _fetchTypes() async {
    final database = await AppDatabase.getInstance();
    final typeDao = database.typeDao;
    return await typeDao.findAllTypes();
  }

  // Add similar functions to fetch Series, Category, and Country options from the database

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      // All form fields are valid, proceed with creating the Post entity
      final newPost = Post(
        title: _titleController.text,
        description: _descriptionController.text,
        // Set other properties from form fields
        typeId: _selectedTypeId!,
        categoryId: _selectedCategoryId!,
        seriesId: _selectedSeriesId!,
        countryId: _selectedCountryId!,
        timestamp: DateTime.now().millisecondsSinceEpoch,
      );

      // Save the new Post entity to the database (you need to implement the savePost method in your DAO)
      final database = await AppDatabase.getInstance();
      final postDao = database.postDao;
      postDao.insertPost(newPost);

      // You may also want to show a confirmation message or navigate back to the previous screen after saving
      // For simplicity, we'll just show a snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Post created successfully!')),
      );
    }
  }
}
