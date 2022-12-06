import 'package:flutter/material.dart';
import 'package:tryhard_showcase/data/repositories/auth/auth_repository.dart';
import 'package:tryhard_showcase/data/repositories/user/user_repository.dart';
import 'package:tryhard_showcase/ui/login/controllers/login_form_controller.dart';
import 'package:tryhard_showcase/ui/login/controllers/login_screen_controller.dart';
import 'package:tryhard_showcase/ui/login/views/screen.dart';

class LoginScreenDependencies extends StatefulWidget {
  const LoginScreenDependencies({
    Key? key,
    required this.authRepository,
    required this.userRepository,
  }) : super(key: key);
  final AuthRepository authRepository;
  final UserRepository userRepository;

  @override
  State<LoginScreenDependencies> createState() => _LoginScreenDependenciesState();
}

class _LoginScreenDependenciesState extends State<LoginScreenDependencies> {
  late final UserLoginController _userLoginController;
  late final LoginFormController _userLoginFormController;
  late final AuthRepository _authRepository;
  late final UserRepository _userRepository;

  @override
  void initState() {
    super.initState();
    _authRepository = widget.authRepository;
    _userRepository = widget.userRepository;

    _userLoginController = RealUserLoginController(
      auth: _authRepository,
      userRepository: _userRepository,
    );
    _userLoginFormController = RealLoginFormController(
      userLoginController: _userLoginController,
    );
  }

  @override
  Widget build(BuildContext context) {
    return LoginScreen(
      userLoginFormController: _userLoginFormController,
    );
  }
}
