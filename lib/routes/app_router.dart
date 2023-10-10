import 'package:auto_route/auto_route.dart';
import 'package:todo_bloc/presentation/screens/home_screen.dart';
import 'package:todo_bloc/common_widgets/base_widget.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: HomeRoute.page, path: '/', initial: true),
        AutoRoute(page: TodoTalkerRoute.page, path: '/log'),
      ];
}
