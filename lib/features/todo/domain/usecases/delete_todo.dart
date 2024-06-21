import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/todo_repository.dart';

class DeleteTodo implements UseCase<void, String> {
  final TodoRepository repository;

  DeleteTodo(this.repository);

  @override
  Future<Either<Failure, void>> call(String id) async {
    return await repository.deleteTodo(id);
  }
}
