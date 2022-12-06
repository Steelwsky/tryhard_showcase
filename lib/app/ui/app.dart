import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tryhard_showcase/app/di/di.dart';
import 'package:tryhard_showcase/app/navigation/routes.dart';
import 'package:tryhard_showcase/app/ui/root_screen.dart';
import 'package:tryhard_showcase/app/ui/styles/theme.dart';
import 'package:tryhard_showcase/features/auth/data/auth_repository.dart';
import 'package:tryhard_showcase/features/auth/domain/auth_cubit/auth_cubit.dart';
import 'package:tryhard_showcase/features/auth/domain/auth_form_cubit/auth_form_cubit.dart';
import 'package:tryhard_showcase/features/home_wrapper/domain/home_cubit/home_cubit.dart';
import 'package:tryhard_showcase/features/inner_page/inner_screen.dart';
import 'package:tryhard_showcase/features/profile/data/user_repository.dart';
import 'package:tryhard_showcase/features/profile/domain/profile_cubit.dart';

class App extends StatelessWidget {
  const App({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => sl.get<AuthCubit>(),
        ),
        BlocProvider(
          create: (_) => AuthFormCubit(sl.get<AuthCubit>()),
        ),
        BlocProvider(
          create: (_) => HomeWrapperCubit(),
        ),
        BlocProvider(
          create: (_) => ProfileCubit(
            sl.get<AuthRepository>(),
            sl.get<UserRepository>(),
            sl.get<AuthCubit>(),
          )..loadUserProfile(
              sl.get<AuthRepository>().getCurrentUserId(),
            ),
        ),
      ],
      child: const _MaterialApp(),
    );
  }
}

class _MaterialApp extends StatelessWidget {
  const _MaterialApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'TRYHARD showcase',
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
        }),
    GoRoute(
        path: RoutePaths.innerPage,
        builder: (context, state) {
          return const InnerScreen();
        }),
  ],
);
