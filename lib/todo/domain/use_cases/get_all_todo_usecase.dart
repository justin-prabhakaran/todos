import 'package:fpdart/fpdart.dart';
import 'package:todos/todo/domain/entities/todo_entity.dart';
import 'package:todos/todo/domain/use_cases/usecase.dart';

import '../repositories/todo_repository.dart';

class FetchTodosUsecase extends UseCase<List<TodoEntity>, NoParams> {
  final TodoRepository _repository;

  FetchTodosUsecase({required TodoRepository repository}) : _repository = repository;

  @override
  Either<Exception, List<TodoEntity>> call(NoParams params) {
    return _repository.getAllTodos();
  }
}

