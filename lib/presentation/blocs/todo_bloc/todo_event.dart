part of 'todo_bloc.dart';

sealed class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object> get props => [];
}

final class GetTodos extends TodoEvent {
  final List<TodoEntity> todos;

  const GetTodos({required this.todos});

  @override
  List<Object> get props => [todos];
}

final class AddTodo extends TodoEvent {
  final TodoEntity todo;

  const AddTodo({required this.todo});

  @override
  List<Object> get props => [todo];
}

final class EditTodo extends TodoEvent {
  final TodoEntity todo;

  const EditTodo({required this.todo});

  @override
  List<Object> get props => [todo];
}

final class DeleteTodo extends TodoEvent {
  final TodoEntity todo;

  const DeleteTodo({required this.todo});

  @override
  List<Object> get props => [todo];
}
