import 'models/auth_user.dart';

abstract class AuthApi {
  Future<AuthUser> userLogin({
    required String email,
    required String password,
  });

  Future<AuthUser> googleLogIn();

  Future<AuthUser> userRegistration({
    required String email,
    required String password,
  });

  Future<void> userLogout();

  String? getAuthUserInfo();
}
