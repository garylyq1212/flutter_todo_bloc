import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_bloc/blocs/todo_bloc/todo_bloc.dart';
import 'package:todo_bloc/data_source/models/todo/todo.dart';
import 'package:todo_bloc/data_source/repository/todo_repository.dart';
import 'package:todo_bloc/screens/home_screen.dart';
import 'package:todo_bloc/simple_bloc_observer.dart';

void main() async {
  Bloc.observer = SimpleBlocObserver();
  await Hive.initFlutter();
  Hive.registerAdapter(TodoAdapter());
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => TodoRepository(),
      child: BlocProvider<TodoBloc>(
        create: (context) => TodoBloc(context.read<TodoRepository>())
          ..add(
            const GetTodos(
              todos: [],
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
      ),
    );
  }
}
