import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tryhard_showcase/app/utils/toast.dart';
import 'package:tryhard_showcase/features/auth/domain/auth_cubit/auth_cubit.dart';

class RootBuilder extends StatelessWidget {
  const RootBuilder({
    Key? key,
    required this.isNotAuthorized,
    required this.isAuthorized,
  }) : super(key: key);

  final WidgetBuilder isNotAuthorized;
  final WidgetBuilder isAuthorized;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      builder: (context, state) {
        return switch (state) {
          AuthNotAuthorizedState() ||
          AuthErrorState() =>
            isNotAuthorized(context),
          AuthAuthorizedState() => isAuthorized(context),
        };
      },
      listener: (context, state) {
        if (state is AuthErrorState) showServiceToast(state.message);
      },
    );
  }
}
