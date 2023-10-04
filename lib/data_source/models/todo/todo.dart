import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:todo_bloc/models/todo_entity/todo_entity.dart';

part 'todo.g.dart';

@HiveType(typeId: 1)
class Todo extends Equatable {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String task;

  @HiveField(2)
  final bool isComplete;

  const Todo({required this.id, required this.task, required this.isComplete});

  factory Todo.fromEntity(TodoEntity todoEntity) {
    return Todo(
      id: todoEntity.id,
      task: todoEntity.task,
      isComplete: todoEntity.isComplete,
    );
  }

  @override
  List<Object?> get props => [id, task, isComplete];
}
