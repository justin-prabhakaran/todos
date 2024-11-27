import 'package:fpdart/fpdart.dart';
import 'package:todos/todo/domain/use_cases/usecase.dart';

import '../repositories/todo_repository.dart';

class DeleteTodoUsecase extends UseCase<void, DeleteTodoUseCaseParams> {
  final TodoRepository _repository;

  DeleteTodoUsecase({required TodoRepository repository}) : _repository = repository;

  @override
  Either<Exception, void> call(DeleteTodoUseCaseParams params) {
    return _repository.deleteTodo(params.id);
  }
}

class DeleteTodoUseCaseParams {
  final int id;

  const DeleteTodoUseCaseParams({required this.id});
}
