import 'package:flutter_test/flutter_test.dart';
import 'package:tryhard_showcase/data/api/auth/models/auth_exception.dart';
import 'package:tryhard_showcase/data/api/datasource/models/exception.dart';

Matcher apiException({
  required String code,
  String? description,
}) {
  return const TypeMatcher<ApiException>()
      .having(
        (e) => e.code,
        'code',
        code,
      )
      .having(
        (e) => e.description,
        'description',
        description,
      );
}

Matcher authException({
  required String code,
  String? message,
}) {
  return const TypeMatcher<AuthException>()
      .having(
        (e) => e.code,
        'code',
        code,
      )
      .having(
        (e) => e.message,
        'message',
        message,
      );
}
