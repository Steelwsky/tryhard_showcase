import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tryhard_showcase/app/ui/app.dart';

import 'app/di/di.dart';

void main() async {
  const env = String.fromEnvironment("env", defaultValue: "prod");
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: await getTemporaryDirectory());
  await Firebase.initializeApp();
  await initDi(env);

  runApp(const App());
}
