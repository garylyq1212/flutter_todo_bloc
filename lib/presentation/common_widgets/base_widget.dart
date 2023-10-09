import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:todo_bloc/routes/app_router.dart';
import 'package:todo_bloc/service_locator.dart';

class BaseWidget extends StatelessWidget {
  final Widget? child;

  const BaseWidget({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          child ?? const SizedBox.shrink(),
          Positioned(
            top: 0,
            right: 0,
            child: IconButton(
              onPressed: () {
                getIt.get<AppRouter>().navigateNamed('/log');
              },
              icon: const Icon(
                Icons.monitor_heart,
                color: Colors.amber,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

@RoutePage()
class TodoTalkerScreen extends StatelessWidget {
  const TodoTalkerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TalkerScreen(
        talker: getIt.get<Talker>(),
      ),
    );
  }
}
