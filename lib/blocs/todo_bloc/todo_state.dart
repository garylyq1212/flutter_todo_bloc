part of 'todo_bloc.dart';

sealed class TodoState extends Equatable {
  const TodoState();

  @override
  List<Object> get props => [];
}

final class TodoInitial extends TodoState {}

final class TodoLoading extends TodoState {}

final class TodoListLoaded extends TodoState {
  final List<TodoEntity> todoList;

  const TodoListLoaded({required this.todoList});

  @override
  List<Object> get props => [todoList];
}
