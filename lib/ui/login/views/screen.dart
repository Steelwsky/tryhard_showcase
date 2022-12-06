import 'package:flutter/material.dart';
import 'package:tryhard_showcase/ui/login/controllers/login_form_controller.dart';

import 'login_form.dart';
import 'logo.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({
    Key? key,
    required LoginFormController userLoginFormController,
  })  : _userLoginFormController = userLoginFormController,
        super(key: key);

  final LoginFormController _userLoginFormController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScrollConfiguration(
        behavior: const ScrollBehavior().copyWith(overscroll: false),
        child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: SingleChildScrollView(
            child: Align(
              alignment: Alignment.center,
              child: Container(
                constraints: const BoxConstraints(
                  maxWidth: 768,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      _spacer,
                      const LogoWidget(),
                      _spacer,
                      LoginForm(
                        loginFormController: _userLoginFormController,
                      ),
                      _spacer,
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

const Widget _spacer = SizedBox(
  height: 16,
);
