import 'package:flutter/material.dart';
import 'package:qlevar_router/qlevar_router.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page Not Found'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error,
              size: 100,
              color: Colors.red,
            ),
            const SizedBox(height: 20),
            const Text(
              '404 - Page not found',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // You can navigate to a specific route or go back to the previous page.
                // Example:
                QR.to('/'); // Navigate to the home page
              },
              child: const Text('Go to Home'),
            ),
          ],
        ),
      ),
    );
  }
}
