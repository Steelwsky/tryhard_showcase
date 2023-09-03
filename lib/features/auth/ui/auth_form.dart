import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tryhard_showcase/app/constants/keys.dart';
import 'package:tryhard_showcase/app/di/di.dart';
import 'package:tryhard_showcase/app/ui/styles/colors.dart';
import 'package:tryhard_showcase/app/ui/styles/style_constants.dart';
import 'package:tryhard_showcase/features/auth/domain/auth_cubit/auth_cubit.dart';
import 'package:tryhard_showcase/features/auth/domain/auth_form_cubit/auth_form_cubit.dart';
import 'package:tryhard_showcase/features/auth/domain/auth_form_cubit/auth_form_state.dart';
import 'package:tryhard_showcase/gen/assets.gen.dart';

class AuthForm extends StatelessWidget {
  const AuthForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthFormCubit(sl.get<AuthCubit>()),
      child: Column(
        key: kAuthFormWidget,
        children: [
          const _FormHeader(),
          _FormBody(),
          _spacer,
          const _GoogleLogInButton(),
          _spacer,
        ],
      ),
    );
  }
}

const Widget _spacer = SizedBox(
  height: 16,
);

class _FormHeader extends StatelessWidget {
  const _FormHeader();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AuthFormCubit>();
    return Row(
      children: [
        _SwitchableHeader(
          title: "Login",
          onTap: (type) => cubit.onFormTypeChanged(type),
          formType: AuthFormType.login,
        ),
        _SwitchableHeader(
          title: "Register",
          onTap: (type) => cubit.onFormTypeChanged(type),
          formType: AuthFormType.register,
        ),
      ],
    );
  }
}

class _SwitchableHeader extends StatelessWidget {
  const _SwitchableHeader({
    required this.title,
    required this.onTap,
    required this.formType,
  });

  final String title;
  final Function(AuthFormType) onTap;
  final AuthFormType formType;

  @override
  Widget build(BuildContext context) {
    final selectedFormType =
        context.watch<AuthFormCubit>().state.selectedFormType;
    return Flexible(
      flex: 5,
      child: InkWell(
        key: formType == AuthFormType.login
            ? kHeaderTitleLogin
            : kHeaderTitleRegister,
        onTap: () => onTap(formType),
        splashColor: Colors.transparent,
        hoverColor: Colors.transparent,
        focusColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: Column(
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            Divider(
              thickness: 5,
              height: 4,
              color: selectedFormType == formType
                  ? AppColors.primary
                  : Colors.transparent,
            ),
          ],
        ),
      ),
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
                  const _TrainerSubForm(),
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
  const _EmailField({required this.initialValue});

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
    required this.initialValue,
    required this.isPasswordHidden,
  });

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

class _TrainerSubForm extends StatelessWidget {
  const _TrainerSubForm();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _spacer,
        TextFormField(
          key: kTrainerField,
          decoration: const InputDecoration(
            hintText: 'Name',
          ),
          onChanged: context.read<AuthFormCubit>().onNameChanged,
        ),
        _spacer,
        const _TrainerSwitchField(),
      ],
    );
  }
}

class _TrainerSwitchField extends StatelessWidget {
  const _TrainerSwitchField();

  @override
  Widget build(BuildContext context) {
    final value = context
        .select<AuthFormCubit, bool>((cubit) => cubit.state.inputs.isTrainer);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text('Are you a trainer?'),
        CupertinoSwitch(
          key: kTrainerSwitch,
          value: value,
          activeColor: AppColors.primary,
          onChanged: (_) => context.read<AuthFormCubit>().onIsTrainerChanged(),
        ),
      ],
    );
  }
}

class _PossibleErrorMessage extends StatelessWidget {
  const _PossibleErrorMessage({required this.errorMessage});

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
  const _LoginOrRegisterButton({required this.state});

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
  const _Loading();

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
  const _GoogleLogInButton();

  @override
  Widget build(BuildContext context) {
    final authButtonState = context.select<AuthFormCubit, AuthButtonState>(
        (cubit) => cubit.state.authButtonState);

    if (authButtonState == AuthButtonState.loading) {
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
  }
}
