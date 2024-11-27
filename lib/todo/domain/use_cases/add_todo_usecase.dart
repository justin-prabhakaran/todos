import 'package:fpdart/fpdart.dart';
import 'package:todos/todo/data/models/todo_model.dart';
import 'package:todos/todo/domain/entities/todo_entity.dart';
import 'package:todos/todo/domain/repositories/todo_repository.dart';
import 'package:todos/todo/domain/use_cases/usecase.dart';

class AddTodoUsecase extends UseCase<void, AddTodoUseCaseParams>{
  final TodoRepository _repository;

  AddTodoUsecase({required TodoRepository repository}) : _repository = repository;

  @override
  Either<Exception, void> call(AddTodoUseCaseParams param) {
    return _repository.addTodo(TodoModel.fromEntity(param.entity));
  }

}

class AddTodoUseCaseParams{
   final TodoEntity entity;
   const AddTodoUseCaseParams({required this.entity});
}