import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/blocs/todo_bloc/todo_bloc.dart';
import 'package:todo_bloc/models/todo_entity/todo_entity.dart';
import 'package:todo_bloc/screens/home_screen.dart';
import 'package:todo_bloc/simple_bloc_observer.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TodoBloc>(
      create: (context) => TodoBloc()
        ..add(
          const GetTodos(
            todos: [
              TodoEntity(id: '1', task: 'Todo #1', isComplete: false),
              TodoEntity(id: '2', task: 'Todo #2', isComplete: false),
            ],
          ),
        ),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          primaryColor: const Color(0xFF000A1F),
          appBarTheme: const AppBarTheme(
            color: Color(0xFF000A1F),
          ),
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
