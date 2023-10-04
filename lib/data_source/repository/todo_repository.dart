import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_bloc/data_source/models/todo/todo.dart';
import 'package:todo_bloc/models/todo_entity/todo_entity.dart';

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
    final todosBox = await Hive.openBox('todos');
    final todoModel = Todo.fromEntity(todo);
    await todosBox.put(todo.id, todoModel);
  }
}
