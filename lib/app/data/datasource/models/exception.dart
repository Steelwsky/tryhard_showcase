class ApiException implements Exception {
  final String code;
  final String description;

  ApiException({
    required this.code,
    required this.description,
  });
}
