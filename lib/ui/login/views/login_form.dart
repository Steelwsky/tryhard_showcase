import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tryhard_showcase/gen/assets.gen.dart';
import 'package:tryhard_showcase/ui/login/controllers/login_form_controller.dart';
import 'package:tryhard_showcase/ui/login/models/login_form.dart';
import 'package:tryhard_showcase/ui/styles/colors.dart';
import 'package:tryhard_showcase/ui/styles/style_constants.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    Key? key,
    required this.loginFormController,
  }) : super(key: key);
  final LoginFormController loginFormController;

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  late final LoginFormController formController;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    formController = widget.loginFormController;
    emailController.addListener(() {
      formController.onEmailChanged(emailController.value.text);
    });
    passwordController.addListener(() {
      formController.onPasswordChanged(passwordController.value.text);
    });
    nameController.addListener(() {
      formController.onNameChanged(nameController.value.text);
    });
  }

  @override
  void dispose() {
    formController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<LoginFormViewModel>(
        key: const ValueKey('LoginFormWidget'),
        valueListenable: formController.viewModel,
        builder: (context, vm, __) {
          return Column(
            children: [
              _FormHeader(
                formController: formController,
                vm: vm,
              ),
              _FormBody(
                emailController: emailController,
                passwordController: passwordController,
                nameController: nameController,
                formController: formController,
                vm: vm,
              ),
              _spacer,
              _GoogleLogInButton(
                loginButtonState: vm.loginButtonState,
                onTap: formController.onGoogleSignIn,
              ),
              _spacer,
            ],
          );
        });
  }
}

const Widget _spacer = SizedBox(
  height: 16,
);

class _FormHeader extends StatelessWidget {
  const _FormHeader({
    Key? key,
    required this.formController,
    required this.vm,
  }) : super(key: key);

  final LoginFormController formController;
  final LoginFormViewModel vm;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _HeaderTitle(
          title: 'Login',
          type: LoginFormType.login,
          isSelected: vm.selectedFormType == LoginFormType.login ? true : false,
          onFormTypeChanged: formController.onFormTypeChanged,
        ),
        _HeaderTitle(
          title: 'Register',
          type: LoginFormType.register,
          isSelected:
              vm.selectedFormType == LoginFormType.register ? true : false,
          onFormTypeChanged: formController.onFormTypeChanged,
        ),
      ],
    );
  }
}

class _HeaderTitle extends StatelessWidget {
  const _HeaderTitle({
    Key? key,
    required this.title,
    required this.type,
    required this.isSelected,
    required this.onFormTypeChanged,
  }) : super(key: key);

  final String title;
  final LoginFormType type;
  final bool isSelected;
  final Function(LoginFormType type) onFormTypeChanged;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 5,
      child: InkWell(
        key: ValueKey('_HeaderTitle$type'),
        onTap: () => onFormTypeChanged(type),
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
              color: isSelected ? AppColors.primary : Colors.transparent,
            ),
          ],
        ),
      ),
    );
  }
}

class _FormBody extends StatelessWidget {
  const _FormBody({
    Key? key,
    required this.emailController,
    required this.passwordController,
    required this.formController,
    required this.nameController,
    required this.vm,
  }) : super(key: key);

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController nameController;
  final LoginFormController formController;
  final LoginFormViewModel vm;

  @override
  Widget build(BuildContext context) {
    return Container(
      key: ValueKey('_FormBody${vm.selectedFormType}'),
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
            TextFormField(
              key: const ValueKey('emailField'),
              controller: emailController,
              decoration: const InputDecoration(
                hintText: 'Email',
              ),
            ),
            _spacer,
            TextFormField(
              key: const ValueKey('passwordField'),
              controller: passwordController,
              obscureText: vm.isPasswordHidden,
              decoration: InputDecoration(
                hintText: 'Password',
                suffixIcon: IconButton(
                  icon: Icon(
                    vm.isPasswordHidden ? Icons.visibility_off : Icons.visibility,
                    key: const ValueKey('visibilityIcon'),
                    color: const Color(0xFFE6E6E6),
                  ),
                  onPressed: formController.onHidePasswordChanged,
                ),
              ),
            ),
            if (vm.selectedFormType == LoginFormType.register)
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _spacer,
                  TextFormField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      hintText: 'Name',
                    ),
                  ),
                  _spacer,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Are you a trainer?'),
                      CupertinoSwitch(
                        value: vm.isTrainer,
                        activeColor: AppColors.primary,
                        onChanged: (_) => formController.onIsTrainerChanged(),
                      ),
                    ],
                  ),
                ],
              ),
            _PossibleErrorMessage(
              errorMessage: vm.errorMessage,
            ),
            _LoginOrRegisterButton(
              loginButtonState: vm.loginButtonState,
              selectedFormType: vm.selectedFormType,
              onLoginPressed: formController.onLogin,
              onRegisterPressed: formController.onRegister,
            )
          ],
        ),
      ),
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
                key: const ValueKey('authErrorMessage'),
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
    required this.loginButtonState,
    required this.selectedFormType,
    required this.onLoginPressed,
    required this.onRegisterPressed,
  }) : super(key: key);

  final LoginButtonState loginButtonState;
  final LoginFormType selectedFormType;
  final VoidCallback onLoginPressed;
  final VoidCallback onRegisterPressed;

  final loginKey = const ValueKey('LoginButtonKey');
  final registerKey = const ValueKey('RegisterButtonKey');

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 48,
      ),
      child: Align(
        child: loginButtonState == LoginButtonState.loading
            ? const SizedBox(
                height: 42,
                width: 42,
                child: CircularProgressIndicator(),
              )
            : SizedBox(
                width: 128,
                height: 42,
                child: MaterialButton(
                  key: selectedFormType == LoginFormType.login
                      ? loginKey
                      : registerKey,
                  color: AppColors.buttonPrimary,
                  onPressed: loginButtonState == LoginButtonState.enabled
                      ? selectedFormType == LoginFormType.login
                          ? onLoginPressed
                          : onRegisterPressed
                      : null,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Text(
                    selectedFormType == LoginFormType.login
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

class _GoogleLogInButton extends StatelessWidget {
  const _GoogleLogInButton({
    Key? key,
    required this.onTap,
    required this.loginButtonState,
  }) : super(key: key);
  final VoidCallback onTap;
  final LoginButtonState loginButtonState;

  @override
  Widget build(BuildContext context) {
    if (loginButtonState == LoginButtonState.loading) {
      return const SizedBox();
    }
    return RawMaterialButton(
      key: const ValueKey('googleSignInButton'),
      constraints: const BoxConstraints(
        maxWidth: 200,
        maxHeight: 42,
        minHeight: 42,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusConstants.borderRadius16,
      ),
      onPressed: onTap,
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
