import 'package:equatable/equatable.dart';

enum LoginFormType {
  login,
  register,
}

enum LoginButtonState {
  loading,
  disabled,
  enabled,
}

class LoginFormViewModel extends Equatable {
  final LoginFormType selectedFormType;
  final bool isTrainer;
  final LoginButtonState loginButtonState;
  final bool isPasswordHidden;
  final String? errorMessage;

  const LoginFormViewModel._({
    required this.selectedFormType,
    required this.isTrainer,
    required this.loginButtonState,
    required this.isPasswordHidden,
    required this.errorMessage,
  });

  const LoginFormViewModel.initial()
      : loginButtonState = LoginButtonState.disabled,
        selectedFormType = LoginFormType.login,
        isPasswordHidden = true,
        isTrainer = false,
        errorMessage = null;

  const LoginFormViewModel.loading({
    required this.selectedFormType,
    required this.isTrainer,
    required this.isPasswordHidden,
  })  : loginButtonState = LoginButtonState.loading,
        errorMessage = null;

  const LoginFormViewModel.error({
    required this.errorMessage,
    required this.loginButtonState,
    required this.selectedFormType,
    required this.isPasswordHidden,
    required this.isTrainer,
  });

  const LoginFormViewModel.data({
    required this.errorMessage,
    required this.loginButtonState,
    required this.selectedFormType,
    required this.isPasswordHidden,
    required this.isTrainer,
  });

  LoginFormViewModel copyWith({
    final LoginFormType? selectedFormType,
    final bool? isTrainer,
    final bool? isPasswordHidden,
    final LoginButtonState? loginButtonState,
    final String? errorMessage,
  }) {
    return LoginFormViewModel._(
      selectedFormType: selectedFormType ?? this.selectedFormType,
      loginButtonState: loginButtonState ?? this.loginButtonState,
      isPasswordHidden: isPasswordHidden ?? this.isPasswordHidden,
      isTrainer: isTrainer ?? this.isTrainer,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        selectedFormType,
        isTrainer,
        isPasswordHidden,
        loginButtonState,
        errorMessage,
      ];
}
