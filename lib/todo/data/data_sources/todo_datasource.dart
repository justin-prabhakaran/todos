import 'package:hive/hive.dart';
import 'package:todos/todo/data/models/todo_model.dart';

abstract class TodoDataSource {
  void addTodo(TodoModel todo);
  void deleteTodo(int id);
  void updateTodo(int id, TodoModel todo);
  TodoModel? getTodo(int id);
  List<TodoModel> getAllTodos();
}

class TodoDataSourceImpl implements TodoDataSource {
  final Box<TodoModel> _box;

  TodoDataSourceImpl() : _box = Hive.box<TodoModel>("todos");

  @override
  void addTodo(TodoModel todo) async {
   await _box.add(todo);
  }

  @override
  void deleteTodo(int id) async{
    if (_box.containsKey(id)) {
     await _box.delete(id);
    } else {
      throw Exception("Todo with id $id not found");
    }
  }

  @override
  void updateTodo(int id, TodoModel todo) async {
    if (_box.containsKey(id)) {
      await _box.put(id, todo);
    } else {
      throw Exception("Todo with id $id not found");
    }
  }

  @override
  TodoModel? getTodo(int id) {
    return _box.get(id);
  }

  @override
  List<TodoModel> getAllTodos() {
    return _box.values.toList();
  }
}
