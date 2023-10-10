import 'package:flutter/material.dart';
import 'package:todo_bloc/routes/app_router.dart';
import 'package:todo_bloc/service_locator.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget title;
  final List<Widget>? actions;

  const MyAppBar({
    super.key,
    required this.title,
    this.actions,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final customActions = <Widget>[];

    customActions.addAll(
      [
        IconButton(
          onPressed: () {
            getIt.get<AppRouter>().navigateNamed('/log');
          },
          icon: const Icon(
            Icons.monitor_heart,
            color: Colors.amber,
          ),
        ),
        ...actions ?? [],
      ],
    );

    return AppBar(
      title: title,
      actions: customActions,
    );
  }
}
