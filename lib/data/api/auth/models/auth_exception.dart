class AuthException implements Exception {
  AuthException({
    required this.code,
    required this.message,
  });

  final String code;
  final String message;
}
