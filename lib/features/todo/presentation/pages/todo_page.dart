import 'package:flutter/material.dart';

class TodoPage extends StatelessWidget {
  const TodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To-Do List'),
      ),
      body: const Center(
        child: Text('To-Do List'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Logic to add a new todo
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
