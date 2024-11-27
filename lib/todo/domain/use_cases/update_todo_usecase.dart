import 'package:fpdart/fpdart.dart';
import 'package:todos/todo/domain/use_cases/usecase.dart';

import '../../data/models/todo_model.dart';
import '../entities/todo_entity.dart';
import '../repositories/todo_repository.dart';

class UpdateTodoUsecase extends UseCase<void, UpdateTodoUseCaseParams> {
  final TodoRepository _repository;

  UpdateTodoUsecase({required TodoRepository repository}) : _repository = repository;

  @override
  Either<Exception, void> call(UpdateTodoUseCaseParams params) {
    return _repository.updateTodo(params.id,TodoModel.fromEntity(params.entity)) ;
  }
}

class UpdateTodoUseCaseParams {
  final TodoEntity entity;
  final int id;

  const UpdateTodoUseCaseParams({required this.entity , required this.id});
}
