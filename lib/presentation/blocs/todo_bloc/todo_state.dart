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

final class EditTodoSuccess extends TodoState {
  final TodoEntity todo;

  const EditTodoSuccess({required this.todo});

  @override
  List<Object> get props => [todo];
}

final class DeleteTodoSuccess extends TodoState {
  final TodoEntity todo;

  const DeleteTodoSuccess({required this.todo});

  @override
  List<Object> get props => [todo];
}
