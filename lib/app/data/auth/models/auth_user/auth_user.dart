import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_user.freezed.dart';

part 'auth_user.g.dart';

@freezed
class AuthUser with _$AuthUser {
  const factory AuthUser({
    String? userGuid,
    String? name,
    String? email,
    String? photoUrl,
  }) = _AuthUser;

  factory AuthUser.fromJson(Map<String, dynamic> json) =>
      _$AuthUserFromJson(json);
}
