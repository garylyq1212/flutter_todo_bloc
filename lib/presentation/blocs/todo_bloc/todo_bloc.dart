// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_bloc/data/data_source/repository/todo_repository.dart';
import 'package:todo_bloc/models/todo_entity/todo_entity.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoRepository _todoRepository;

  TodoBloc(this._todoRepository) : super(TodoLoading()) {
    on<GetTodos>((event, emit) async {
      await Future.delayed(const Duration(seconds: 1));
      final todos = await _todoRepository.getTodoList();
      emit(TodoListLoaded(todoList: todos));
    });
    on<AddTodo>((event, emit) async {
      await _todoRepository.saveTodo(event.todo);
      final state = this.state;
      if (state is TodoListLoaded) {
        emit(
          TodoListLoaded(
            todoList: List.from(state.todoList)..add(event.todo),
          ),
        );
      }
    });
    on<EditTodo>((event, emit) async {
      if (state is TodoListLoaded) {
        await _todoRepository.editTodo(event.todo);
        emit(TodoListLoaded(todoList: await _todoRepository.getTodoList()));
      }
    });
    on<DeleteTodo>((event, emit) async {
      if (state is TodoListLoaded) {
        await _todoRepository.deleteTodo(event.todo);
        emit(TodoListLoaded(todoList: await _todoRepository.getTodoList()));
      }
    });
  }
}
