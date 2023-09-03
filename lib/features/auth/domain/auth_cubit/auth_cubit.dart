import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:tryhard_showcase/app/data/auth/models/auth_exception.dart';
import 'package:tryhard_showcase/app/data/auth/models/auth_user/auth_user.dart';
import 'package:tryhard_showcase/app/data/datasource/models/exception.dart';
import 'package:tryhard_showcase/app/data/datasource/models/user_info_basic.dart';
import 'package:tryhard_showcase/features/auth/data/auth_repository.dart';
import 'package:tryhard_showcase/features/profile/data/remote/user_repository.dart';

part 'auth_state.dart';

@Singleton()
@prod
@test
class AuthCubit extends Cubit<AuthState> {
  AuthCubit(
    this._authRepository,
    this._userRepository,
  ) : super(AuthNotAuthorizedState());

  final AuthRepository _authRepository;
  final UserRepository _userRepository;

  Future<void> logIn({
    required String email,
    required String password,
  }) async {
    try {
      final user = await _authRepository.login(
        email: email,
        password: password,
      );
      emit(AuthAuthorizedState(user: user));
    } on AuthException catch (_) {
      emit(AuthNotAuthorizedState());
      rethrow;
    }
  }

  Future<void> register({
    required String email,
    required String password,
    String? name,
    bool? isTrainer,
  }) async {
    AuthUser? user;
    try {
      user = await _authRepository.register(
        email: email,
        password: password,
      );
    } on AuthException catch (_) {
      emit(AuthNotAuthorizedState());
      rethrow;
    }
    try {
      await _userRepository.createUserProfile(
        userBasicInfo: UserRegistrationBasicInfo.create(
          guid: user.userGuid!,
          name: name,
          email: email,
          isTrainer: false,
        ),
      );
      emit(AuthAuthorizedState(user: user));
    } on ApiException catch (_) {
      emit(AuthNotAuthorizedState());
      rethrow;
    }
  }

  Future<void> onGoogleSignIn() async {
    AuthUser? user;
    try {
      user = await _authRepository.googleLogIn();
      await _userRepository.createUserProfile(
        userBasicInfo: UserRegistrationBasicInfo.create(
          guid: user.userGuid!,
          name: user.name,
          email: user.email!,
          photoUrl: user.photoUrl,
        ),
      );
      emit(AuthAuthorizedState(user: user));
    } on Exception catch (_) {
      emit(AuthNotAuthorizedState());
      rethrow;
    }
  }

  Future<void> logout() async {
    try {
      await _authRepository.logout();
    } on AuthException catch (e) {
      emit(AuthErrorState(message: e.message));
    } finally {
      emit(AuthNotAuthorizedState());
    }
  }
}
