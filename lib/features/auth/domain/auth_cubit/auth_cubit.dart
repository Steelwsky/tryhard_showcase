import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:tryhard_showcase/app/data/auth/models/auth_exception.dart';
import 'package:tryhard_showcase/app/data/auth/models/auth_user/auth_user.dart';
import 'package:tryhard_showcase/app/data/datasource/models/exception.dart';
import 'package:tryhard_showcase/app/data/datasource/models/user_info_basic.dart';
import 'package:tryhard_showcase/features/auth/data/auth_repository.dart';
import 'package:tryhard_showcase/features/profile/data/user_repository.dart';

part 'auth_cubit.freezed.dart';

part 'auth_cubit.g.dart';

part 'auth_state.dart';

@Singleton()
@prod
@test
class AuthCubit extends HydratedCubit<AuthState> {
  AuthCubit(
    this._authRepository,
    this._userRepository,
  ) : super(AuthState.notAuthorized());

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
      emit(AuthState.authorized(user));
    } on AuthException catch (_) {
      emit(AuthState.notAuthorized());
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
      emit(AuthState.notAuthorized());
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
      emit(AuthState.authorized(user));
    } on ApiException catch (_) {
      emit(AuthState.notAuthorized());
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
      emit(AuthState.authorized(user));
    } on Exception catch (_) {
      emit(AuthState.notAuthorized());
      rethrow;
    }
  }

  Future<void> logout() async {
    try {
      // throw AuthException(code: 'code', message: 'message');
      _authRepository.logout();
      emit(AuthState.notAuthorized());
    } on Exception catch (_) {
      rethrow;
    }
  }

  @override
  AuthState? fromJson(Map<String, dynamic> json) {
    if (json.isEmpty) return AuthState.notAuthorized();
    final state = AuthState.fromJson(json);
    return state.whenOrNull(
      authorized: (user) => AuthState.authorized(user),
      notAuthorized: () => AuthState.notAuthorized(),
    );
  }

  @override
  Map<String, dynamic>? toJson(AuthState state) {
    return state
            .whenOrNull(
              authorized: (authUser) => AuthState.authorized(authUser),
            )
            ?.toJson() ??
        AuthState.notAuthorized().toJson();
  }
}
