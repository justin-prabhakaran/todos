import 'package:hive/hive.dart';
import 'package:todos/todo/domain/entities/todo_entity.dart';

part 'todo_model.g.dart';
@HiveType(typeId: 0)
class TodoModel extends TodoEntity{

  @HiveField(0)
  int? id;

  @override
  @HiveField(1)
  String title;

  @override
  @HiveField(2)
  String description;

  @override
  @HiveField(3)
  bool isCompleted;

  TodoModel({
    required this.title,
    required this.description,
    required this.isCompleted
}) : super(title,description,isCompleted);


  factory TodoModel.fromEntity(TodoEntity entity) {
    return TodoModel(title : entity.title, description : entity.description, isCompleted : entity.isCompleted);
  }

  TodoEntity toEntity() {
    return TodoEntity(title, description, isCompleted);
  }

  TodoModel copyWith({
    int? id,
    String? title,
    String? description,
    bool? isCompleted,
  }) {
    return TodoModel(
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}