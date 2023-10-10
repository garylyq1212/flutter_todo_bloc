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
      await _todoRepository.editTodo(event.todo);
      emit(EditTodoSuccess(todo: event.todo));

      // final state = this.state;
      // if (state is TodoListLoaded) {
      //   for (var todo in state.todoList) {
      //     if (todo.id == event.todo.id) {
      //       await _todoRepository.editTodo(event.todo);
      //       todo.copyWith(
      //         task: event.todo.task,
      //         isComplete: event.todo.isComplete,
      //       );
      //       emit(EditTodoSuccess(todo: todo));
      //     }
      //   }
      // }
    });
    on<DeleteTodo>((event, emit) async {
      await _todoRepository.deleteTodo(event.todo);
      emit(DeleteTodoSuccess(todo: event.todo));
    });
  }
}
