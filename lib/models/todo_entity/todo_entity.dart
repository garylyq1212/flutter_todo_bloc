import 'package:equatable/equatable.dart';

class TodoEntity extends Equatable {
  final String id;
  final String task;
  final bool isComplete;

  const TodoEntity({
    required this.id,
    required this.task,
    required this.isComplete,
  });

  @override
  List<Object?> get props => [id, task, isComplete];
}
