import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/todo.dart';
import '../bloc/todo_bloc.dart';

class TodoList extends StatelessWidget {
  final List<Todo> todos;

  const TodoList({super.key, required this.todos});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: todos.length,
      itemBuilder: (context, index) {
        final todo = todos[index];
        return ListTile(
          title: Text(
            todo.title,
            style: TextStyle(
              decoration: todo.isCompleted ? TextDecoration.lineThrough : null,
            ),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  //todo: Implement edit functionality
                },
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  BlocProvider.of<TodoBloc>(context)
                      .add(DeleteTodoEvent(todo.id));
                },
              ),
            ],
          ),
          leading: Checkbox(
            value: todo.isCompleted,
            onChanged: (bool? value) {
              final updatedTodo = Todo(
                id: todo.id,
                title: todo.title,
                isCompleted: value!,
              );
              BlocProvider.of<TodoBloc>(context)
                  .add(UpdateTodoEvent(updatedTodo));
            },
          ),
        );
      },
    );
  }
}
