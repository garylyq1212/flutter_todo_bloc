import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/blocs/todo_bloc/todo_bloc.dart';
import 'package:todo_bloc/models/todo_entity/todo_entity.dart';

class AddTodoScreen extends StatelessWidget {
  const AddTodoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController controllerId = TextEditingController();
    TextEditingController controllerTask = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('BloC Pattern: Add a To Do'),
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
                    _inputField('ID', controllerId),
                    _inputField('Task', controllerTask),
                    ElevatedButton(
                      onPressed: () {
                        var todo = TodoEntity(
                          id: controllerId.value.text,
                          task: controllerTask.value.text,
                          isComplete: false,
                        );
                        context.read<TodoBloc>().add(AddTodo(todo: todo));
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                      ),
                      child: const Text('Add To Do'),
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
