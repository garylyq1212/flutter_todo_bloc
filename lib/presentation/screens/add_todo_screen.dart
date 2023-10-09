import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/blocs/todo_bloc/todo_bloc.dart';
import 'package:todo_bloc/models/todo_entity/todo_entity.dart';
import 'package:uuid/uuid.dart';

class AddTodoScreen extends StatelessWidget {
  final TodoEntity? todo;

  const AddTodoScreen({Key? key, this.todo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TextEditingController controllerId = TextEditingController();
    TextEditingController controllerTask = TextEditingController();

    // controllerId.text = todo?.id ?? '';
    controllerTask.text = todo?.task ?? '';

    return Scaffold(
      appBar: AppBar(
        title: todo != null
            ? const Text('BloC Pattern: Edit a To Do')
            : const Text('BloC Pattern: Add a To Do'),
      ),
      body: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {
          if (state is TodoLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is TodoListLoaded) {
            return Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    todo != null ? Text(todo!.id) : const SizedBox.shrink(),
                    _inputField('Task', controllerTask),
                    ElevatedButton(
                      onPressed: () {
                        if (todo != null) {
                          context.read<TodoBloc>().add(
                                EditTodo(
                                  todo: todo!.copyWith(
                                    task: controllerTask.text,
                                    isComplete: false,
                                  ),
                                ),
                              );
                        } else {
                          var newTodo = TodoEntity(
                            id: const Uuid().v4(),
                            task: controllerTask.value.text,
                            isComplete: false,
                          );
                          context.read<TodoBloc>().add(AddTodo(todo: newTodo));
                        }

                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                      ),
                      child: todo != null
                          ? const Text('Edit Todo')
                          : const Text('Add To Do'),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const Text('Something went wrong.');
          }
        },
      ),
    );
  }

  Column _inputField(
    String field,
    TextEditingController controller,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$field: ',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          height: 50,
          margin: const EdgeInsets.only(bottom: 10),
          width: double.infinity,
          child: TextFormField(
            controller: controller,
          ),
        ),
      ],
    );
  }
}
