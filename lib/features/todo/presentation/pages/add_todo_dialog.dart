// lib/features/todo/presentation/pages/add_todo_dialog.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/todo.dart';
import '../bloc/todo_bloc.dart';

class AddTodoDialog extends StatefulWidget {
  const AddTodoDialog({super.key});

  @override
  AddTodoDialogState createState() => AddTodoDialogState();
}

class AddTodoDialogState extends State<AddTodoDialog> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add New Todo'),
      content: Form(
        key: _formKey,
        child: TextFormField(
          decoration: const InputDecoration(labelText: 'Title'),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a title';
            }
            return null;
          },
          onSaved: (value) {
            _title = value ?? '';
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            if (_formKey.currentState?.validate() ?? false) {
              _formKey.currentState?.save();
              final newTodo = Todo(
                id: DateTime.now().toString(),
                title: _title,
                isCompleted: false,
              );
              context.read<TodoBloc>().add(AddTodoEvent(newTodo));
              Navigator.of(context).pop();
            }
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
}
