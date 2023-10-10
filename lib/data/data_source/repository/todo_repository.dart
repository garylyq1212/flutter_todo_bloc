import 'package:hive_flutter/hive_flutter.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:todo_bloc/data/data_source/models/todo/todo.dart';
import 'package:todo_bloc/models/todo_entity/todo_entity.dart';
import 'package:todo_bloc/service_locator.dart';

class TodoRepository {
  Future<List<TodoEntity>> getTodoList() async {
    var todoList = <TodoEntity>[];
    final todosBox = await Hive.openBox('todos');
    todoList =
        todosBox.values.map((todo) => TodoEntity.fromModel(todo)).toList();

    return todoList;
  }

  Future<void> saveTodo(TodoEntity todo) async {
    final todosBox = await Hive.openBox('todos');
    final todoModel = Todo.fromEntity(todo);
    await todosBox.put(todo.id, todoModel);
  }

  Future<void> editTodo(TodoEntity todo) async {
    try {
      final todosBox = await Hive.openBox('todos');
      final todoModel = Todo.fromEntity(todo);
      await todosBox.put(todo.id, todoModel);
    } on Exception catch (err, stack) {
      getIt.get<Talker>().handle(err, stack);
    }
  }

  Future<void> deleteTodo(TodoEntity todo) async {
    try {
      final todosBox = await Hive.openBox('todos');
      await todosBox.delete(todo.id);
    } on Exception catch (err, stack) {
      getIt.get<Talker>().handle(err, stack);
    }
  }
}
