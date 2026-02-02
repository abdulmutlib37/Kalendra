import 'package:flutter/material.dart';

class TaskCreationScreen extends StatelessWidget {
  const TaskCreationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Task Creation')),
      body: const Center(
        child: Text('Task Creation Screen'),
      ),
    );
  }
}
