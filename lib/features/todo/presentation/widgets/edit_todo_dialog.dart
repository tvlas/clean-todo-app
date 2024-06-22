import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/todo.dart';
import '../bloc/todo_bloc.dart';

class EditTodoDialog extends StatefulWidget {
  final Todo todo;

  const EditTodoDialog({super.key, required this.todo});

  @override
  EditTodoDialogState createState() => EditTodoDialogState();
}

class EditTodoDialogState extends State<EditTodoDialog> {
  final _formKey = GlobalKey<FormState>();
  late String _title;

  @override
  void initState() {
    super.initState();
    _title = widget.todo.title;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit Todo'),
      content: Form(
        key: _formKey,
        child: TextFormField(
          initialValue: _title,
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
              final updatedTodo = Todo(
                id: widget.todo.id,
                title: _title,
                isCompleted: widget.todo.isCompleted,
              );
              context.read<TodoBloc>().add(UpdateTodoEvent(updatedTodo));
              Navigator.of(context).pop();
            }
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
