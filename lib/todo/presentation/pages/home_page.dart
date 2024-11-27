import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todos/todo/data/models/todo_model.dart';
import 'package:todos/todo/presentation/bloc/todo_bloc.dart';
import 'package:todos/todo/domain/entities/todo_entity.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isSelected = false;


  void _showAddTodoDialog() {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Add Todo"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                final title = titleController.text;
                final description = descriptionController.text;
                if (title.isNotEmpty && description.isNotEmpty) {
                  final newTodo = TodoEntity(
                    title,
                    description,
                    false,
                  );
                  context.read<TodoBloc>().add(AddTodoEvent(newTodo));
                  Navigator.of(context).pop();
                }
              },
              child: const Text("Add Todo"),
            ),
          ],
        );
      },
    );
  }


  void _showEditTodoDialog(int index, TodoEntity todo) {
    final TextEditingController titleController = TextEditingController(text: todo.title);
    final TextEditingController descriptionController = TextEditingController(text: todo.description);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Edit Todo"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                final title = titleController.text;
                final description = descriptionController.text;
                if (title.isNotEmpty && description.isNotEmpty) {
                  final updatedTodo = TodoEntity(
                    title,
                    description,
                    todo.isCompleted,
                  );
                  context.read<TodoBloc>().add(UpdateTodoEvent(index, updatedTodo));
                  Navigator.of(context).pop();
                }
              },
              child: const Text("Update Todo"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo Lists"),
        actions: [
          IconButton(
            onPressed: _showAddTodoDialog,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: BlocConsumer<TodoBloc, TodoState>(
        listener: (context, state) {
          if (state is TodoErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.message),
            ));
          }
        },
        builder: (context, state) {
          if (state is TodoLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is TodosLoadedState) {
            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              itemCount: state.todos.length,
              itemBuilder: (context, index) {
                final todo = state.todos[index];
                return Slidable(
                  startActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (context) {
                          _showEditTodoDialog(index, todo);
                        },
                        backgroundColor: Colors.blue,
                        icon: Icons.edit,
                        label: 'Edit',
                      ),
                    ],
                  ),
                  endActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (context) {
                          context.read<TodoBloc>().add(DeleteTodoEvent(index));
                        },
                        backgroundColor: Colors.red,
                        icon: Icons.delete,
                        label: 'Delete',
                      ),
                    ],
                  ),
                  child: ListTile(
                    title: Text(todo.title),
                    subtitle: Text(todo.description),
                    trailing: Checkbox(
                      value: todo.isCompleted,
                      onChanged: (val) {
                        final updatedTodo = TodoModel.fromEntity(todo).copyWith(isCompleted: val!).toEntity();
                        context.read<TodoBloc>().add(UpdateTodoEvent(index, updatedTodo));
                      },
                    ),
                    onLongPress: () {
                      context.read<TodoBloc>().add(DeleteTodoEvent(index));
                    },
                  ),
                );
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
