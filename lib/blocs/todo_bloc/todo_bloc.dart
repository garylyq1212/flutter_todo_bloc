// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_bloc/models/todo_entity/todo_entity.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(TodoLoading()) {
    on<GetTodos>((event, emit) {
      emit(TodoListLoaded(todoList: event.todos));
    });
    on<AddTodo>((event, emit) {
      final state = this.state;
      if (state is TodoListLoaded) {
        emit(
          TodoListLoaded(
            todoList: List.from(state.todoList)..add(event.todo),
          ),
        );
      }
    });
  }
}
