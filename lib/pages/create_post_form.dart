import 'package:flutter/material.dart';

class CreatePostFormPage extends StatelessWidget {
  const CreatePostFormPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Post Form Page'),
      ),
      body: const Center(
        child: Text('Form for creating a new post'),
      ),
    );
  }
}