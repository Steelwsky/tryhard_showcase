import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tryhard_showcase/features/auth/domain/models/user_input.dart';

part 'auth_form_state.g.dart';

enum AuthFormType {
  login,
  register,
}

enum AuthButtonState {
  loading,
  disabled,
  enabled,
}

@JsonSerializable()
class AuthFormState extends Equatable {
  final UserInput inputs;
  final AuthFormType selectedFormType;
  final AuthButtonState authButtonState;
  final bool isPasswordHidden;
  final String? errorMessage;

  const AuthFormState({
    required this.inputs,
    required this.selectedFormType,
    required this.authButtonState,
    required this.isPasswordHidden,
    required this.errorMessage,
  });

  const AuthFormState.initial()
      : authButtonState = AuthButtonState.disabled,
        selectedFormType = AuthFormType.login,
        inputs = const UserInput.initial(),
        isPasswordHidden = true,
        errorMessage = null;

  const AuthFormState.loading({
    required this.selectedFormType,
    required this.inputs,
    required this.isPasswordHidden,
  })  : authButtonState = AuthButtonState.loading,
        errorMessage = null;

  AuthFormState.done({
    required this.inputs,
  })  : authButtonState = inputs.areInputsValid()
            ? AuthButtonState.enabled
            : AuthButtonState.disabled,
        selectedFormType = AuthFormType.login,
        isPasswordHidden = true,
        errorMessage = null;

  const AuthFormState.error({
    required this.errorMessage,
    required this.authButtonState,
    required this.selectedFormType,
    required this.isPasswordHidden,
    required this.inputs,
  });

  const AuthFormState.data({
    required this.errorMessage,
    required this.authButtonState,
    required this.selectedFormType,
    required this.isPasswordHidden,
    required this.inputs,
  });

  AuthFormState copyWith({
    final AuthFormType? selectedFormType,
    final UserInput? inputs,
    final bool? isPasswordHidden,
    final AuthButtonState? authButtonState,
    final String? errorMessage,
  }) {
    return AuthFormState(
      selectedFormType: selectedFormType ?? this.selectedFormType,
      authButtonState: authButtonState ?? this.authButtonState,
      isPasswordHidden: isPasswordHidden ?? this.isPasswordHidden,
      inputs: inputs ?? this.inputs,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  factory AuthFormState.fromJson(Map<String, dynamic> json) =>
      _$AuthFormStateFromJson(json);

  Map<String, dynamic> toJson() => _$AuthFormStateToJson(this);

  @override
  List<Object?> get props => [
        selectedFormType,
        inputs,
        isPasswordHidden,
        authButtonState,
        errorMessage,
      ];
}
