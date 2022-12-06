import 'package:tryhard_showcase/data/api/auth/models/auth_exception.dart';
import 'package:tryhard_showcase/data/api/datasource/models/exception.dart';
import 'package:tryhard_showcase/data/repositories/auth/auth_repository.dart';
import 'package:tryhard_showcase/data/repositories/user/models/user_info_basic.dart';
import 'package:tryhard_showcase/data/repositories/user/user_repository.dart';

abstract class UserLoginController {
  Future<void> logIn({
    required String email,
    required String password,
  });

  Future<void> onGoogleSignIn();

  Future<void> register({
    required String email,
    required String password,
    String? name,
    bool? isTrainer,
  });
}

class RealUserLoginController implements UserLoginController {
  RealUserLoginController({
    required AuthRepository auth,
    required UserRepository userRepository,
  })  : _auth = auth,
        _userRepository = userRepository;

  final AuthRepository _auth;
  final UserRepository _userRepository;

  @override
  Future<void> logIn({
    required String email,
    required String password,
  }) async {
    if (_auth.isLogged.value == true) {
      throw AuthException(
        code: 'login-error',
        message: 'User is already logged in',
      );
    }
    try {
      await _auth.login(
        email: email,
        password: password,
      );
    } on AuthException catch (_) {
      rethrow;
    }
  }

  @override
  Future<void> register({
    required String email,
    required String password,
    String? name,
    bool? isTrainer,
  }) async {
    try {
      await _auth.register(
        email: email,
        password: password,
      );
    } on AuthException catch (_) {
      rethrow;
    }
    try {
      if (_auth.isLogged.value == true) {
        final user = _auth.user.value;
        return await _userRepository.createUserProfile(
          userBasicInfo: UserRegistrationBasicInfo.create(
            guid: user!.userGuid!,
            name: name,
            email: email,
            isTrainer: isTrainer,
          ),
        );
      } else {
        throw ApiException(
          code: 'user-not-logged',
          description: 'You are not logged in',
        );
      }
    } on ApiException catch (_) {
      rethrow;
    }
  }

  @override
  Future<void> onGoogleSignIn() async {
    try {
      await _auth.googleLogIn();
      if (_auth.isLogged.value == true) {
        final user = _auth.user.value;
        if (user != null) {
          await _userRepository.createUserProfile(
            userBasicInfo: UserRegistrationBasicInfo.create(
              guid: user.userGuid!,
              name: user.name,
              email: user.email!,
              photoUrl: user.photoUrl,
            ),
          );
        } else {
          throw AuthException(
            code: 'auth-user',
            message: 'Google sign in is canceled',
          );
        }
      } else {
        throw AuthException(
          code: 'auth-user',
          message: 'An error occurred. Please try again',
        );
      }
    } on Exception catch (_) {
      rethrow;
    }
  }
}
