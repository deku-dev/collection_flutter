import 'package:flutter/material.dart';

class FilterFormPage extends StatelessWidget {
  const FilterFormPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filter Form Page'),
      ),
      body: const Center(
        child: Text('Filter posts by type, country, and other criteria'),
      ),
    );
  }
}