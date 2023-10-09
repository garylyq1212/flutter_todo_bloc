import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:talker_bloc_logger/talker_bloc_logger.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:todo_bloc/routes/app_router.dart';

final getIt = GetIt.instance;

Future<void> initTalker() async {
  getIt.registerSingleton<Talker>(Talker());
  getIt.registerSingleton<TalkerRouteObserver>(
    TalkerRouteObserver(getIt.get<Talker>()),
  );
  getIt.registerSingleton<TalkerBlocObserver>(
    TalkerBlocObserver(talker: getIt.get<Talker>()),
  );
  getIt.registerSingleton<TalkerDioLogger>(
    TalkerDioLogger(talker: getIt.get<Talker>()),
  );
}

Future<void> registerDependencies() async {
  await Hive.initFlutter();

  getIt.registerSingleton<AppRouter>(AppRouter());

  // Init Bloc & Repository
}
