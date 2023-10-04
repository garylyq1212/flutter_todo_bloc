import 'package:equatable/equatable.dart';
import 'package:todo_bloc/data_source/models/todo/todo.dart';

class TodoEntity extends Equatable {
  final String id;
  final String task;
  final bool isComplete;

  const TodoEntity({
    required this.id,
    required this.task,
    required this.isComplete,
  });

  factory TodoEntity.fromModel(Todo todo) {
    return TodoEntity(
      id: todo.id,
      task: todo.task,
      isComplete: todo.isComplete,
    );
  }

  TodoEntity copyWith({String? task, bool? isComplete}) {
    return TodoEntity(
      id: id,
      task: task ?? this.task,
      isComplete: isComplete ?? this.isComplete,
    );
  }

  @override
  List<Object?> get props => [id, task, isComplete];
}
