import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'example_mockito_test.mocks.dart';

abstract class ExampleApi {
  Future<String> getUserNameByUserId({
    required int userId,
  });
}

class RealExampleApi implements ExampleApi {
  @override
  Future<String> getUserNameByUserId({
    required int userId,
  }) {
    try {
      return Future.value('UserName');
    } catch (e) {
      throw Exception('some exception');
    }
  }
}

typedef UserId = int;

class FakeExampleApi implements ExampleApi {
  Map<UserId, List<Completer<String>>?> getUserNameCompleters = {};

  @override
  Future<String> getUserNameByUserId({
    required int userId,
  }) {
    final Completer<String> completer = Completer();
    getUserNameCompleters[userId] = [...?getUserNameCompleters[userId], completer];
    return getUserNameCompleters[userId]!.last.future;
  }
}

class _TestCase {
  _TestCase({
    required this.userId,
    required this.toExpect,
  });

  final int userId;
  final dynamic toExpect;
}

abstract class ExampleController {
  Future<String> getUserName({
    required int userId,
  });
}

class RealExampleController implements ExampleController {
  RealExampleController({
    required ExampleApi api,
  }) : _api = api;

  late final ExampleApi _api;

  @override
  Future<String> getUserName({
    required int userId,
  }) {
    try {
      return _api.getUserNameByUserId(userId: userId);
    } catch (_) {
      throw Exception('some exception');
    }
  }
}

@GenerateMocks([RealExampleApi])
void main() {
  group('getting user name', () {
    test('should return success result', () async {
      final api = MockRealExampleApi();
      final controller = RealExampleController(api: api);

      final testCase = _TestCase(
        userId: 0,
        toExpect: 'userName',
      );

      when(controller.getUserName(userId: testCase.userId)).thenAnswer((_) async {
        return testCase.toExpect;
      });

      final result = controller.getUserName(userId: testCase.userId);
      verify(controller.getUserName(userId: testCase.userId));

      expect(await result, testCase.toExpect);
    });

    test('should fail and catch an exception', () async {
      final api = MockRealExampleApi();
      final controller = RealExampleController(api: api);

      final testCase = _TestCase(
        userId: 0,
        toExpect: Exception('whatever msg'),
      );

      when(controller.getUserName(userId: testCase.userId)).thenAnswer((_) async {
        throw testCase.toExpect;
      });

      final result = controller.getUserName(userId: testCase.userId);
      expect(result, throwsException);
    });
  });
}
