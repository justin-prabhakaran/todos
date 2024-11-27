part of 'todo_bloc.dart';

sealed class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object?> get props => [];
}

class AddTodoEvent extends TodoEvent{
  final TodoEntity todo;
  const AddTodoEvent(this.todo);

  @override
  List<Object?> get props => [todo];
}

class DeleteTodoEvent extends TodoEvent{
  final int id;
  const DeleteTodoEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class UpdateTodoEvent extends TodoEvent {
  final int id;
  final TodoEntity updatedTodo;

  const UpdateTodoEvent(this.id, this.updatedTodo);

  @override
  List<Object?> get props => [id, updatedTodo];
}

class FetchTodosEvent extends TodoEvent {}





