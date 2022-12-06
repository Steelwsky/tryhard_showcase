import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'di.config.dart';

final sl = GetIt.instance;

@InjectableInit(generateForDir: ['lib'])
Future<void> initDi(String env) async {
  sl.init(environment: env);
}
