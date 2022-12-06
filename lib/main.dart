import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tryhard_showcase/data/api/auth/auth.dart';
import 'package:tryhard_showcase/data/api/auth/auth_service.dart';
import 'package:tryhard_showcase/data/api/datasource/db.dart';
import 'package:tryhard_showcase/data/api/datasource/db_client.dart';
import 'package:tryhard_showcase/data/repositories/auth/auth_repository.dart';
import 'package:tryhard_showcase/data/repositories/user/user_repository.dart';
import 'package:tryhard_showcase/navigation/navigation_controller.dart';
import 'package:tryhard_showcase/ui/home/views/dependencies.dart';
import 'package:tryhard_showcase/ui/login/views/dependencies.dart';

import 'navigation/routes.dart';
import 'ui/styles/theme.dart';
import 'ui/toast/controllers/toast_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final Database db = FirebaseApiService();
  final AuthApi auth = FirebaseAuthService();

  runApp(
    MyApp(
      db: db,
      auth: auth,
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({
    Key? key,
    required Database db,
    required AuthApi auth,
  })  : _db = db,
        _auth = auth,
        super(key: key);
  final Database _db;
  final AuthApi _auth;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final UserRepository _userRepository;
  late final AuthRepository _authRepository;
  late final ToastController _toastController;
  late final NavigationController navigationController;

  final navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();

    _toastController = RealToastController();

    _authRepository = RealAuthRepository(
      auth: widget._auth,
    );

    _userRepository = RealUserRepository(
      db: widget._db,
      authRepository: _authRepository,
    );

    navigationController = NavigationControllerImplementation(
      key: navigatorKey,
      isLogged: _authRepository.isLogged,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigationController.key,
      title: 'TRYHARD showcase',
      theme: myTheme,
      initialRoute: RoutesNames.login,
      routes: {
        RoutesNames.login: (_) => LoginScreenDependencies(
              authRepository: _authRepository,
              userRepository: _userRepository,
            ),
        RoutesNames.home: (_) => HomeScreenDependencies(
              authRepository: _authRepository,
              userRepository: _userRepository,
              toastController: _toastController,
            ),
      },
    );
  }
}
