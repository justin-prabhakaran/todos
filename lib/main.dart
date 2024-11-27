import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todos/todo/data/data_sources/todo_datasource.dart';
import 'package:todos/todo/data/models/todo_model.dart';
import 'package:todos/todo/data/repositories/todo_repository.dart';
import 'package:todos/todo/domain/repositories/todo_repository.dart';
import 'package:todos/todo/domain/use_cases/add_todo_usecase.dart';
import 'package:todos/todo/domain/use_cases/delete_todo_usecase.dart';
import 'package:todos/todo/domain/use_cases/get_all_todo_usecase.dart';
import 'package:todos/todo/domain/use_cases/update_todo_usecase.dart';
import 'package:todos/todo/presentation/bloc/todo_bloc.dart';
import 'package:todos/todo/presentation/pages/home_page.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(TodoModelAdapter());
  await Hive.openBox<TodoModel>('todos');
  initDependency();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => serviceLocator<TodoBloc>(),
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const HomePage(),
      ),
    );
  }
}


final serviceLocator = GetIt.instance;
void initDependency() {
  // Use cases
  serviceLocator.registerFactory(() => AddTodoUsecase(repository: serviceLocator()));
  serviceLocator.registerFactory(() => DeleteTodoUsecase(repository: serviceLocator()));
  serviceLocator.registerFactory(() => FetchTodosUsecase(repository: serviceLocator()));
  serviceLocator.registerFactory(() => UpdateTodoUsecase(repository: serviceLocator()));

  // Repositories
  serviceLocator.registerFactory<TodoRepository>(
        () => TodoRepositoryImpl(todoDataSource: serviceLocator()),
  );

  // Data sources
  serviceLocator.registerLazySingleton<TodoDataSource>(
        () => TodoDataSourceImpl(),
  );

  // Bloc
  serviceLocator.registerLazySingleton<TodoBloc>(() => TodoBloc(
    addTodoUsecase: serviceLocator(),
    fetchTodosUsecase: serviceLocator(),
    deleteTodoUsecase: serviceLocator(),
    updateTodoUsecase: serviceLocator(),
  ));
}

