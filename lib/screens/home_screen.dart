import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/blocs/todo_bloc/todo_bloc.dart';
import 'package:todo_bloc/models/todo_entity/todo_entity.dart';
import 'package:todo_bloc/screens/add_todo_screen.dart';

@RoutePage()
class HomeScreen extends StatelessWidget implements AutoRouteWrapper {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget wrappedRoute(BuildContext context) {
    return this;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BloC Pattern: To Dos'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddTodoScreen(),
                ),
              );
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      // body: BlocBuilder<TodosStatusBloc, TodosStatusState>(
      //   builder: (context, state) {
      //     if (state is TodosStatusLoading) {
      //       return const Center(
      //         child: CircularProgressIndicator(),
      //       );
      //     }
      //     if (state is TodosStatusLoaded) {
      //       return Padding(
      //         padding: const EdgeInsets.all(8.0),
      //         child: Column(
      //           crossAxisAlignment: CrossAxisAlignment.start,
      //           children: [
      //             _todo(
      //               state.pendingTodos,
      //               'Pending',
      //             ),
      //             _todo(
      //               state.completedTodos,
      //               'Completed',
      //             ),
      //           ],
      //         ),
      //       );
      //     } else {
      //       return const Text('Something went wrong.');
      //     }
      //   },
      // ),
      body: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {
          if (state is TodoLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is TodoListLoaded) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _todo(
                    state.todoList,
                    'Pending',
                  ),
                ],
              ),
            );
          } else {
            return const Text('Something went wrong.');
          }
        },
      ),
    );
  }

  Column _todo(List<TodoEntity> todos, String status) {
    return Column(
      children: [
        SizedBox(
          height: 50,
          child: Row(
            children: [
              Text(
                '$status To Dos: ',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: todos.length,
          itemBuilder: (BuildContext context, int index) {
            return _todosCard(
              context,
              todos[index],
            );
          },
        ),
      ],
    );
  }

  Widget _todosCard(
    BuildContext context,
    TodoEntity todo,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              todo.task,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            BlocBuilder<TodoBloc, TodoState>(
              builder: (context, state) {
                return Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddTodoScreen(
                              todo: todo,
                            ),
                          ),
                        );
                      },
                      icon: const Icon(Icons.edit),
                    ),
                    IconButton(
                      onPressed: () {
                        // context.read<TodoBloc>().add(
                        //       UpdateTodo(
                        //         todo: todo.copyWith(isCompleted: true),
                        //       ),
                        //     );
                      },
                      icon: const Icon(Icons.add_task),
                    ),
                    IconButton(
                      onPressed: () {
                        // context.read<TodoBloc>().add(
                        //       DeleteTodo(
                        //         todo: todo.copyWith(isCancelled: true),
                        //       ),
                        //     );
                      },
                      icon: const Icon(Icons.cancel),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
