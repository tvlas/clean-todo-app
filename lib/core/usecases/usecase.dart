// lib/core/usecases/usecase.dart

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../error/failure.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

// Classe para casos de uso que não requerem parâmetros
class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}
