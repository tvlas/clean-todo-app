import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/todo.dart';
import '../repositories/todo_repository.dart';

class UpdateTodo implements UseCase<void, Todo> {
  final TodoRepository repository;

  UpdateTodo(this.repository);

  @override
  Future<Either<Failure, void>> call(Todo todo) async {
    return await repository.updateTodo(todo);
  }
}
