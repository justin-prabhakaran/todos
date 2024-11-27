part of 'todo_bloc.dart';

sealed class TodoState extends Equatable {
  const TodoState();
}

final class TodoInitial extends TodoState {
  @override
  List<Object> get props => [];
}

class TodoLoadingState extends TodoState {
  @override
  List<Object?> get props => [];
}


class TodosLoadedState extends TodoState {
  final List<TodoEntity> todos;

  const TodosLoadedState(this.todos);

  @override
  List<Object?> get props => [todos];
}

class TodoErrorState extends TodoState {
  final String message;

  const TodoErrorState(this.message);

  @override
  List<Object?> get props => [message];
}

