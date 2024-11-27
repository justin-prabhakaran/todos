import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:todos/todo/domain/entities/todo_entity.dart';
import 'package:todos/todo/domain/use_cases/add_todo_usecase.dart';
import 'package:todos/todo/domain/use_cases/delete_todo_usecase.dart';
import 'package:todos/todo/domain/use_cases/get_all_todo_usecase.dart';
import 'package:todos/todo/domain/use_cases/update_todo_usecase.dart';
import 'package:todos/todo/domain/use_cases/usecase.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final AddTodoUsecase _addTodoUsecase;
  final FetchTodosUsecase _fetchTodosUsecase;
  final DeleteTodoUsecase _deleteTodoUsecase;
  final UpdateTodoUsecase _updateTodoUsecase;

  TodoBloc({
    required AddTodoUsecase addTodoUsecase,
    required FetchTodosUsecase fetchTodosUsecase,
    required DeleteTodoUsecase deleteTodoUsecase,
    required UpdateTodoUsecase updateTodoUsecase,
  })  : _addTodoUsecase = addTodoUsecase,
        _fetchTodosUsecase = fetchTodosUsecase,
        _deleteTodoUsecase = deleteTodoUsecase,
        _updateTodoUsecase = updateTodoUsecase,
        super(TodoInitial()) {
    on<AddTodoEvent>(_onAddTodo);
    on<DeleteTodoEvent>(_onDeleteTodo);
    on<UpdateTodoEvent>(_onUpdateTodo);
    on<FetchTodosEvent>(_onFetchTodos);
  }

  // General function to handle all CRUD operations followed by fetch
  Future<void> _handleTodoAction(
      Either<Exception, void> action,
      Emitter<TodoState> emit,
      ) async {
    emit(TodoLoadingState());

    final result = action;

    result.fold(
          (error) => emit(TodoErrorState(error.toString())),
          (_) => _fetchTodosAndEmit(emit),
    );
  }

  Future<void> _onAddTodo(AddTodoEvent event, Emitter<TodoState> emit) async {
    _handleTodoAction(
        _addTodoUsecase(AddTodoUseCaseParams(entity: event.todo)),
        emit
    );
  }

  Future<void> _onDeleteTodo(DeleteTodoEvent event, Emitter<TodoState> emit) async {
    _handleTodoAction(
        _deleteTodoUsecase(DeleteTodoUseCaseParams(id: event.id)),
        emit
    );
  }

  Future<void> _onUpdateTodo(UpdateTodoEvent event, Emitter<TodoState> emit) async {
    _handleTodoAction(
        _updateTodoUsecase(UpdateTodoUseCaseParams(entity: event.updatedTodo, id: event.id)),
        emit
    );
  }

  Future<void> _onFetchTodos(FetchTodosEvent event, Emitter<TodoState> emit) async {
    emit(TodoLoadingState());
    final todos = _fetchTodosUsecase(NoParams());
    todos.fold(
          (error) => emit(TodoErrorState(error.toString())),
          (todos) => emit(TodosLoadedState(todos)),
    );
  }

  Future<void> _fetchTodosAndEmit(Emitter<TodoState> emit) async {
    final todos = _fetchTodosUsecase(NoParams());
    todos.fold(
          (error) => emit(TodoErrorState(error.toString())),
          (todos) => emit(TodosLoadedState(todos)),
    );
  }
}
