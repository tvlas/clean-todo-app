import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/todo.dart';
import '../../domain/usecases/add_todo.dart';
import '../../domain/usecases/delete_todo.dart';
import '../../domain/usecases/get_todos.dart';
import '../../domain/usecases/update_todo.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final GetTodos getTodos;
  final AddTodo addTodo;
  final UpdateTodo updateTodo;
  final DeleteTodo deleteTodo;

  TodoBloc({
    required this.getTodos,
    required this.addTodo,
    required this.updateTodo,
    required this.deleteTodo,
  }) : super(TodoEmpty()) {
    on<GetTodosEvent>((event, emit) async {
      emit(TodoLoading());
      final failureOrTodos = await getTodos(NoParams());
      emit(failureOrTodos.fold(
        (failure) => const TodoError(message: 'Error loading todos'),
        (todos) => TodoLoaded(todos: todos),
      ));
    });

    on<AddTodoEvent>((event, emit) async {
      final failureOrSuccess = await addTodo(event.todo);
      emit(failureOrSuccess.fold(
        (failure) => const TodoError(message: 'Error adding todo'),
        (_) => TodoAdded(),
      ));
    });

    on<UpdateTodoEvent>((event, emit) async {
      final failureOrSuccess = await updateTodo(event.todo);
      emit(failureOrSuccess.fold(
        (failure) => const TodoError(message: 'Error updating todo'),
        (_) => TodoUpdated(),
      ));
    });

    on<DeleteTodoEvent>((event, emit) async {
      final failureOrSuccess = await deleteTodo(event.id);
      emit(failureOrSuccess.fold(
        (failure) => const TodoError(message: 'Error deleting todo'),
        (_) => TodoDeleted(),
      ));
    });
  }
}
