import 'package:fpdart/fpdart.dart';
import 'package:todos/todo/data/data_sources/todo_datasource.dart';
import 'package:todos/todo/data/models/todo_model.dart';
import 'package:todos/todo/domain/entities/todo_entity.dart';
import 'package:todos/todo/domain/repositories/todo_repository.dart';

class TodoRepositoryImpl implements TodoRepository{

  final TodoDataSource _todoDataSource;

  TodoRepositoryImpl({
    required TodoDataSource todoDataSource
}) : _todoDataSource = todoDataSource;

  @override
  Either<Exception, void> addTodo(TodoEntity todo) {
    try{
      _todoDataSource.addTodo(TodoModel.fromEntity(todo));
      return right(null);
    }catch(e){
      return left(Exception(e.toString()));
    }
  }

  @override
  Either<Exception, void> deleteTodo(int id) {
    try{
      _todoDataSource.deleteTodo(id);
      return right(null);
    }catch(e){
      return left(Exception(e.toString()));
    }
  }

  @override
  Either<Exception, List<TodoModel>> getAllTodos() {
    try{
      var list = _todoDataSource.getAllTodos();
      return right(list);
    }catch(e){
      return left(Exception(e.toString()));
    }
  }

  @override
  Either<Exception, TodoEntity?> getTodo(int id) {
    try{
      var todo = _todoDataSource.getTodo(id);
      return right(todo);
    }catch(e){
      return left(Exception(e.toString()));
    }
  }

  @override
  Either<Exception, void> updateTodo(int id, TodoEntity todo) {
    try{
       _todoDataSource.updateTodo(id, TodoModel.fromEntity(todo));

      return right(null);
    }catch(e){
      return left(Exception(e.toString()));
    }
  }

  
}