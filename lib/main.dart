// lib/main.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/todo/data/datasources/todo_local_data_source.dart';
import 'features/todo/data/repositories/todo_repository_impl.dart';
import 'features/todo/domain/usecases/add_todo.dart';
import 'features/todo/domain/usecases/delete_todo.dart';
import 'features/todo/domain/usecases/get_todos.dart';
import 'features/todo/domain/usecases/update_todo.dart';
import 'features/todo/presentation/bloc/todo_bloc.dart';
import 'features/todo/presentation/pages/todo_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPreferences = await SharedPreferences.getInstance();
  final todoLocalDataSource =
      TodoLocalDataSourceImpl(sharedPreferences: sharedPreferences);
  final todoRepository =
      TodoRepositoryImpl(localDataSource: todoLocalDataSource);
  runApp(MyApp(todoRepository: todoRepository));
}

class MyApp extends StatelessWidget {
  final TodoRepositoryImpl todoRepository;

  const MyApp({super.key, required this.todoRepository});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => TodoBloc(
            getTodos: GetTodos(todoRepository),
            addTodo: AddTodo(todoRepository),
            updateTodo: UpdateTodo(todoRepository),
            deleteTodo: DeleteTodo(todoRepository),
          )..add(GetTodosEvent()),
        ),
      ],
      child: const MaterialApp(
        title: 'Flutter Clean Architecture',
        home: TodoPage(),
      ),
    );
  }
}
