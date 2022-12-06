import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:tryhard_showcase/app/constants/strings/errors.dart';
import 'package:tryhard_showcase/app/data/auth/models/auth_exception.dart';
import 'package:tryhard_showcase/app/data/datasource/models/exception.dart';
import 'package:tryhard_showcase/features/auth/domain/auth_cubit/auth_cubit.dart';
import 'package:tryhard_showcase/features/auth/domain/models/user_input.dart';

import 'auth_form_state.dart';

class AuthFormCubit extends HydratedCubit<AuthFormState> {
  AuthFormCubit(this._authCubit) : super(const AuthFormState.initial());

  final AuthCubit _authCubit;

  void onFormTypeChanged(AuthFormType type) {
    emit(state.copyWith(selectedFormType: type));
  }

  void onHidePasswordChanged() {
    emit(state.copyWith(isPasswordHidden: !state.isPasswordHidden));
  }

  void onIsTrainerChanged() {
    emit(
      state.copyWith(
        inputs: state.inputs.copyWith(isTrainer: !state.inputs.isTrainer),
      ),
    );
  }

  void onNameChanged(String name) {
    emit(
      state.copyWith(
        inputs: state.inputs.copyWith(name: name),
      ),
    );
  }

  void onEmailChanged(String email) {
    final UserInput inputs = state.inputs.copyWith(email: email);
    final bool areValid = inputs.areInputsValid();
    emit(
      state.copyWith(
        inputs: inputs,
        authButtonState:
            areValid ? AuthButtonState.enabled : AuthButtonState.disabled,
      ),
    );
  }

  void onPasswordChanged(String password) {
    final UserInput inputs = state.inputs.copyWith(password: password);
    final bool areValid = inputs.areInputsValid();
    emit(
      state.copyWith(
        inputs: inputs,
        authButtonState:
            areValid ? AuthButtonState.enabled : AuthButtonState.disabled,
      ),
    );
  }

  Future<void> onLogin() async {
    if (_checkRequiredInputsEmpty()) {
      _setFormStateError(
        errorMessage: AppStringErrors.emailAndPasswordMustBeFilled,
        buttonState: AuthButtonState.disabled,
      );
      return;
    }
    try {
      _setFormStateLoading();
      await _authCubit.logIn(
        email: state.inputs.email!,
        password: state.inputs.password!,
      );
      _setFormStateDone();
    } on AuthException catch (e) {
      _setFormStateError(
        errorMessage: e.message,
        buttonState: AuthButtonState.enabled,
      );
    }
  }

  Future<void> onRegister() async {
    if (_checkRequiredInputsEmpty()) {
      _setFormStateError(
        errorMessage: AppStringErrors.emailAndPasswordMustBeFilled,
        buttonState: AuthButtonState.disabled,
      );
      return;
    }
    try {
      _setFormStateLoading();
      await _authCubit.register(
        email: state.inputs.email!,
        password: state.inputs.password!,
        name: state.inputs.name,
        isTrainer: state.inputs.isTrainer,
      );
      _setFormStateDone();
    } on AuthException catch (e) {
      _setFormStateError(
        errorMessage: e.message,
        buttonState: AuthButtonState.enabled,
      );
    } on ApiException catch (e) {
      _setFormStateError(
        errorMessage: e.description,
        buttonState: AuthButtonState.enabled,
      );
    }
  }

  Future<void> onGoogleSignIn() async {
    try {
      _setFormStateLoading();
      await _authCubit.onGoogleSignIn();
      _setFormStateDone();
    } on AuthException catch (e) {
      _setFormStateError(
        errorMessage: e.message,
        buttonState: _checkRequiredInputsEmpty()
            ? AuthButtonState.disabled
            : AuthButtonState.enabled,
      );
    } on ApiException catch (e) {
      _setFormStateError(
        errorMessage: e.description,
        buttonState: _checkRequiredInputsEmpty()
            ? AuthButtonState.disabled
            : AuthButtonState.enabled,
      );
    }
  }

  void _setFormStateDone() {
    emit(
      AuthFormState.done(
        inputs: state.inputs,
      ),
    );
  }

  void _setFormStateLoading() {
    if (state.authButtonState != AuthButtonState.loading) {
      emit(
        AuthFormState.loading(
          selectedFormType: state.selectedFormType,
          inputs: state.inputs,
          isPasswordHidden: state.isPasswordHidden,
        ),
      );
    }
  }

  void _setFormStateError({
    required String errorMessage,
    required AuthButtonState buttonState,
  }) {
    emit(
      AuthFormState.error(
        errorMessage: errorMessage,
        authButtonState: buttonState,
        selectedFormType: state.selectedFormType,
        isPasswordHidden: state.isPasswordHidden,
        inputs: state.inputs,
      ),
    );
  }

  bool _checkRequiredInputsEmpty() {
    return (state.inputs.email?.isEmpty ?? true) ||
        (state.inputs.password?.isEmpty ?? true);
  }

  @override
  AuthFormState? fromJson(Map<String, dynamic> json) {
    final saved = AuthFormState.fromJson(json);
    return saved.copyWith(
      inputs: const UserInput.initial(),
      authButtonState: AuthButtonState.disabled,
      errorMessage: null,
    );
  }

  @override
  Map<String, dynamic>? toJson(AuthFormState state) {
    return state.toJson();
  }
}
