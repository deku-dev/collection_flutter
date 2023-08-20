import 'package:flutter/material.dart';

class CategoryFilterPage extends StatelessWidget {
  const CategoryFilterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Category Filter Page'),
      ),
      body: const Center(
        child: Text('Filter posts by category'),
      ),
    );
  }
}