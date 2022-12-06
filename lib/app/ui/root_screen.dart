import 'package:flutter/material.dart';
import 'package:tryhard_showcase/features/auth/ui/auth_screen.dart';
import 'package:tryhard_showcase/features/home_wrapper/ui/home_wrapper.dart';

import 'root_builder.dart';

class RootScreen extends StatelessWidget {
  const RootScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RootBuilder(
      isNotAuthorized: (context) => const AuthScreen(),
      isAuthorized: (context) => const HomeScreenWrapper(),
    );
  }
}
