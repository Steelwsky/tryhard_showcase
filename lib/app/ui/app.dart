import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tryhard_showcase/app/di/di.dart';
import 'package:tryhard_showcase/app/navigation/routes.dart';
import 'package:tryhard_showcase/app/ui/root_screen.dart';
import 'package:tryhard_showcase/app/ui/styles/theme.dart';
import 'package:tryhard_showcase/features/auth/domain/auth_cubit/auth_cubit.dart';
import 'package:tryhard_showcase/features/inner_page/inner_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl.get<AuthCubit>(),
      child: const _MaterialApp(),
    );
  }
}

class _MaterialApp extends StatelessWidget {
  const _MaterialApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'TRYHARD',
      theme: myTheme,
      routerConfig: _goRouter,
    );
  }
}

final _goRouter = GoRouter(
  routes: [
    GoRoute(
      path: RoutePaths.root,
      builder: (context, state) {
        return const RootScreen();
      },
    ),
    GoRoute(
      path: RoutePaths.innerPage,
      builder: (context, state) {
        return const InnerScreen();
      },
    ),
  ],
);
