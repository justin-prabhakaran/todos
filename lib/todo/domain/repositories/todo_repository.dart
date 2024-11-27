import 'package:fpdart/fpdart.dart';
import 'package:todos/todo/domain/entities/todo_entity.dart';


abstract class TodoRepository{
  Either<Exception,void> addTodo(TodoEntity todo);
  Either<Exception,void> deleteTodo(int id);
  Either<Exception,void> updateTodo(int id, TodoEntity todo);
  Either<Exception,TodoEntity?> getTodo(int id);
  Either<Exception,List<TodoEntity> >getAllTodos();
}