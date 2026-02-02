import 'package:flutter/material.dart';

import '../routes/app_routes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, AppRoutes.settings),
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FilledButton(
              onPressed: () =>
                  Navigator.pushNamed(context, AppRoutes.homeDetailed),
              child: const Text('Go to Home Detailed'),
            ),
            const SizedBox(height: 12),
            FilledButton(
              onPressed: () =>
                  Navigator.pushNamed(context, AppRoutes.textChat),
              child: const Text('Go to Text Chat'),
            ),
            const SizedBox(height: 12),
            FilledButton(
              onPressed: () =>
                  Navigator.pushNamed(context, AppRoutes.taskCreation),
              child: const Text('Go to Task Creation'),
            ),
          ],
        ),
      ),
    );
  }
}
