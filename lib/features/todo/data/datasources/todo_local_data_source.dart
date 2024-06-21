import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/todo_model.dart';

abstract class TodoLocalDataSource {
  Future<List<TodoModel>> getTodos();
  Future<void> addTodo(TodoModel todo);
  Future<void> updateTodo(TodoModel todo);
  Future<void> deleteTodo(String id);
}

class TodoLocalDataSourceImpl implements TodoLocalDataSource {
  final SharedPreferences sharedPreferences;
  static const String cachedTodos = 'CACHED_TODOS';

  TodoLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<TodoModel>> getTodos() {
    final jsonString = sharedPreferences.getString(cachedTodos);
    if (jsonString != null) {
      final List<dynamic> jsonMap = json.decode(jsonString);
      return Future.value(
          jsonMap.map((json) => TodoModel.fromJson(json)).toList());
    } else {
      return Future.value([]);
    }
  }

  @override
  Future<void> addTodo(TodoModel todo) async {
    final todos = await getTodos();
    todos.add(todo);
    sharedPreferences.setString(
        cachedTodos, json.encode(todos.map((e) => e.toJson()).toList()));
  }

  @override
  Future<void> updateTodo(TodoModel todo) async {
    final todos = await getTodos();
    final index = todos.indexWhere((element) => element.id == todo.id);
    if (index != -1) {
      todos[index] = todo;
      sharedPreferences.setString(
          cachedTodos, json.encode(todos.map((e) => e.toJson()).toList()));
    }
  }

  @override
  Future<void> deleteTodo(String id) async {
    final todos = await getTodos();
    todos.removeWhere((element) => element.id == id);
    sharedPreferences.setString(
        cachedTodos, json.encode(todos.map((e) => e.toJson()).toList()));
  }
}
