import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tryhard_showcase/app/constants/keys.dart';
import 'package:tryhard_showcase/app/ui/styles/colors.dart';
import 'package:tryhard_showcase/app/ui/styles/style_constants.dart';
import 'package:tryhard_showcase/features/auth/domain/auth_form_cubit/auth_form_cubit.dart';
import 'package:tryhard_showcase/features/auth/domain/auth_form_cubit/auth_form_state.dart';
import 'package:tryhard_showcase/gen/assets.gen.dart';

class AuthForm extends StatelessWidget {
  const AuthForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      key: kAuthFormWidget,
      children: [
        const _FormHeader(),
        _FormBody(),
        _spacer,
        const _GoogleLogInButton(),
        _spacer,
      ],
    );
  }
}

const Widget _spacer = SizedBox(
  height: 16,
);

class _FormHeader extends StatelessWidget {
  const _FormHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          flex: 5,
          child: InkWell(
            key: kHeaderTitleLogin,
            onTap: () => context
                .read<AuthFormCubit>()
                .onFormTypeChanged(AuthFormType.login),
            splashColor: Colors.transparent,
            hoverColor: Colors.transparent,
            focusColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: Column(
              children: [
                const Text(
                  "Login",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                BlocBuilder<AuthFormCubit, AuthFormState>(
                  builder: (context, state) {
                    return Divider(
                      thickness: 5,
                      height: 4,
                      color: state.selectedFormType == AuthFormType.login
                          ? AppColors.primary
                          : Colors.transparent,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        Flexible(
          flex: 5,
          child: InkWell(
            key: kHeaderTitleRegister,
            onTap: () => context
                .read<AuthFormCubit>()
                .onFormTypeChanged(AuthFormType.register),
            splashColor: Colors.transparent,
            hoverColor: Colors.transparent,
            focusColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: Column(
              children: [
                const Text(
                  "Register",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                BlocBuilder<AuthFormCubit, AuthFormState>(
                  builder: (context, state) {
                    return Divider(
                      thickness: 5,
                      height: 4,
                      color: state.selectedFormType == AuthFormType.register
                          ? AppColors.primary
                          : Colors.transparent,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _FormBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthFormCubit, AuthFormState>(
      builder: (context, state) {
        return Container(
          key: state.selectedFormType == AuthFormType.login
              ? kFormBodyLogin
              : kFormBodyRegister,
          decoration: const BoxDecoration(
            color: AppColors.backgroundSecondary,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(16),
              bottomRight: Radius.circular(16),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16),
            child: ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              children: [
                _EmailField(
                  initialValue: state.inputs.email,
                ),
                _spacer,
                _PasswordField(
                  initialValue: state.inputs.password,
                  isPasswordHidden: state.isPasswordHidden,
                ),
                if (state.selectedFormType == AuthFormType.register)
                  const _IsTrainer(),
                _PossibleErrorMessage(
                  errorMessage: state.errorMessage,
                ),
                _LoginOrRegisterButton(
                  state: state,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class _EmailField extends StatelessWidget {
  const _EmailField({
    Key? key,
    required this.initialValue,
  }) : super(key: key);

  final String? initialValue;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: kEmailField,
      initialValue: initialValue ?? '',
      onChanged: context.read<AuthFormCubit>().onEmailChanged,
      decoration: const InputDecoration(
        hintText: 'Email',
      ),
    );
  }
}

class _PasswordField extends StatelessWidget {
  const _PasswordField({
    Key? key,
    required this.initialValue,
    required this.isPasswordHidden,
  }) : super(key: key);

  final String? initialValue;
  final bool isPasswordHidden;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: kPasswordField,
      initialValue: initialValue ?? '',
      obscureText: isPasswordHidden,
      decoration: InputDecoration(
        hintText: 'Password',
        suffixIcon: IconButton(
          icon: Icon(
            isPasswordHidden ? Icons.visibility_off : Icons.visibility,
            key: kVisibilityIcon,
            color: AppColors.white,
          ),
          onPressed: context.read<AuthFormCubit>().onHidePasswordChanged,
        ),
      ),
      onChanged: context.read<AuthFormCubit>().onPasswordChanged,
    );
  }
}

class _IsTrainer extends StatelessWidget {
  const _IsTrainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _spacer,
        TextFormField(
          decoration: const InputDecoration(
            hintText: 'Name',
          ),
          onChanged: context.read<AuthFormCubit>().onNameChanged,
        ),
        _spacer,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Are you a trainer?'),
            BlocBuilder<AuthFormCubit, AuthFormState>(
              builder: (context, state) {
                return CupertinoSwitch(
                  value: state.inputs.isTrainer,
                  activeColor: AppColors.primary,
                  onChanged: (_) =>
                      context.read<AuthFormCubit>().onIsTrainerChanged(),
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}

class _PossibleErrorMessage extends StatelessWidget {
  const _PossibleErrorMessage({
    Key? key,
    required this.errorMessage,
  }) : super(key: key);

  final String? errorMessage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Center(
        child: errorMessage == null
            ? const SizedBox(
                height: 22,
              )
            : Text(
                errorMessage!,
                key: kAuthErrorMessage,
                textAlign: TextAlign.center,
                maxLines: 2,
                style: const TextStyle(color: AppColors.caution),
              ),
      ),
    );
  }
}

class _LoginOrRegisterButton extends StatelessWidget {
  const _LoginOrRegisterButton({
    Key? key,
    required this.state,
  }) : super(key: key);

  final AuthFormState state;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 48,
      ),
      child: Align(
        child: state.authButtonState == AuthButtonState.loading
            ? const _Loading()
            : SizedBox(
                width: 128,
                height: 42,
                child: MaterialButton(
                  key: state.selectedFormType == AuthFormType.login
                      ? kLoginButton
                      : kRegisterButton,
                  color: AppColors.buttonPrimary,
                  onPressed: state.authButtonState == AuthButtonState.enabled
                      ? state.selectedFormType == AuthFormType.login
                          ? context.read<AuthFormCubit>().onLogin
                          : context.read<AuthFormCubit>().onRegister
                      : null,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Text(
                    state.selectedFormType == AuthFormType.login
                        ? "Login"
                        : "Register",
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}

class _Loading extends StatelessWidget {
  const _Loading({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 42,
      width: 42,
      child: CircularProgressIndicator(),
    );
  }
}

class _GoogleLogInButton extends StatelessWidget {
  const _GoogleLogInButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthFormCubit, AuthFormState>(
      builder: (context, state) {
        if (state.authButtonState == AuthButtonState.loading) {
          return const SizedBox();
        }
        return RawMaterialButton(
          key: kGoogleSignInButton,
          constraints: const BoxConstraints(
            maxWidth: 200,
            maxHeight: 42,
            minHeight: 42,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusConstants.borderRadius16,
          ),
          onPressed: context.read<AuthFormCubit>().onGoogleSignIn,
          fillColor: AppColors.backgroundSecondary,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                Assets.google.path,
                width: 20,
                height: 20,
              ),
              const SizedBox(
                width: 10,
              ),
              const SizedBox(
                width: 103,
                child: Text(
                  'Login with Google',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
