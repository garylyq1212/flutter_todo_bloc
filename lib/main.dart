import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:talker_bloc_logger/talker_bloc_logger_observer.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:todo_bloc/blocs/todo_bloc/todo_bloc.dart';
import 'package:todo_bloc/presentation/common_widgets/base_widget.dart';
import 'package:todo_bloc/data_source/models/todo/todo.dart';
import 'package:todo_bloc/data_source/repository/todo_repository.dart';
import 'package:todo_bloc/routes/app_router.dart';
import 'package:todo_bloc/service_locator.dart';

void main() async {
  await initTalker();

  final talker = getIt.get<Talker>();

  runZonedGuarded(
    () async {
      await registerDependencies();

      Bloc.observer = getIt.get<TalkerBlocObserver>();

      Hive.registerAdapter(TodoAdapter());

      WidgetsFlutterBinding.ensureInitialized();

      runApp(MyApp());
    },
    (error, stack) {
      talker.handle(error, stack, 'Uncaught App Exception!');
    },
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _appRouter = getIt.get<AppRouter>();

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
        child: MaterialApp.router(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
            primaryColor: const Color(0xFF000A1F),
            appBarTheme: const AppBarTheme(
              color: Color(0xFF000A1F),
            ),
          ),
          routerConfig: _appRouter.config(
            navigatorObservers: () => [
              getIt.get<TalkerRouteObserver>(),
            ],
          ),
          builder: (context, child) => BaseWidget(child: child),
        ),
      ),
    );
  }
}
