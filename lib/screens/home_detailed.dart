import 'package:flutter/material.dart';

class HomeDetailedScreen extends StatelessWidget {
  const HomeDetailedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Detailed')),
      body: const Center(
        child: Text('Home Detailed Screen'),
      ),
    );
  }
}
