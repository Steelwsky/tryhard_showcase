import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:tryhard_showcase/app/constants/keys.dart';
import 'package:tryhard_showcase/app/di/di.dart';
import 'package:tryhard_showcase/app/ui/styles/theme.dart';
import 'package:tryhard_showcase/features/auth/ui/auth_form.dart';

import 'storage/fake_storage.dart';

void main() {
  const String inputEmail = "test@test.com";
  const String inputPassword = "123455";
  const String trainerName = "Test trainer name";

  setUpAll(() async {
    initHydratedStorage();
    await initDi("test");
  });

  Finder findFieldByKey({
    required Key key,
    required Key fieldKey,
  }) {
    return find.descendant(
      of: find.byKey(key),
      matching: find.byKey(fieldKey),
    );
  }

  Future<void> switchToRegisterFormType({
    required Key key,
    required WidgetTester tester,
  }) async {
    final finder = findFieldByKey(
      key: key,
      fieldKey: kHeaderTitleRegister,
    );

    expect(finder, findsOneWidget);
    await tester.tap(finder);
    await tester.pump();
  }

  Future<void> enterEmail({
    required Key key,
    required WidgetTester tester,
  }) async {
    final finder = findFieldByKey(
      key: key,
      fieldKey: kEmailField,
    );

    expect(finder, findsOneWidget);
    await tester.enterText(finder, inputEmail);
    await tester.pump();
  }

  Future<void> enterPassword({
    required Key key,
    required WidgetTester tester,
  }) async {
    final finder = findFieldByKey(
      key: key,
      fieldKey: kPasswordField,
    );

    expect(finder, findsOneWidget);
    await tester.enterText(finder, inputPassword);
    await tester.pump();
  }

  Future<void> tapOnVisibilityIcon({
    required Key key,
    required WidgetTester tester,
  }) async {
    final finder = findFieldByKey(
      key: key,
      fieldKey: kVisibilityIcon,
    );

    expect(finder, findsOneWidget);
    await tester.tap(finder);
    await tester.pump();
  }

  Future<void> tapOnIsTrainerSwitch({
    required Key key,
    required WidgetTester tester,
  }) async {
    final finder = findFieldByKey(
      key: key,
      fieldKey: kTrainerSwitch,
    );

    expect(finder, findsOneWidget);
    await tester.tap(finder);
    await tester.pump();
  }

  Future<void> enterTrainerName({
    required Key key,
    required WidgetTester tester,
  }) async {
    final finder = findFieldByKey(
      key: key,
      fieldKey: kTrainerField,
    );

    expect(finder, findsOneWidget);
    await tester.enterText(finder, trainerName);
    await tester.pump();
  }

  group('Golden Auth Form', () {
    testGoldens('Auth Form Login form type', (tester) async {
      final builder = DeviceBuilder()
        ..overrideDevicesForAllScenarios(devices: [
          const Device(
            size: Size(500, 360),
            name: '500x360',
          )
        ])
        ..addScenario(
          name: 'login form type default',
          widget: const _AuthForm(),
        )
        ..addScenario(
            name: 'email entered',
            widget: const _AuthForm(),
            onCreate: (key) async {
              await enterEmail(key: key, tester: tester);
            })
        ..addScenario(
            name: 'password entered',
            widget: const _AuthForm(),
            onCreate: (key) async {
              await enterPassword(key: key, tester: tester);
            })
        ..addScenario(
            name: 'show entered password',
            widget: const _AuthForm(),
            onCreate: (key) async {
              await tapOnVisibilityIcon(key: key, tester: tester);
              await enterPassword(key: key, tester: tester);
            })
        ..addScenario(
            name: 'filled email and password fields',
            widget: const _AuthForm(),
            onCreate: (key) async {
              await enterEmail(key: key, tester: tester);
              await enterPassword(key: key, tester: tester);
            });

      await tester.pumpDeviceBuilder(builder);
      await tester.pumpAndSettle();

      await screenMatchesGolden(tester, 'auth_form_multi_scenario_login_form');
    });

    testGoldens('Auth Form Register form type', (tester) async {
      final builder = DeviceBuilder()
        ..overrideDevicesForAllScenarios(devices: [
          const Device(
            size: Size(500, 500),
            name: '500x500',
          )
        ])
        ..addScenario(
            name: 'register form type default',
            widget: const _AuthForm(),
            onCreate: (key) async {
              await switchToRegisterFormType(key: key, tester: tester);
            })
        ..addScenario(
            name: 'email entered',
            widget: const _AuthForm(),
            onCreate: (key) async {
              await switchToRegisterFormType(key: key, tester: tester);
              await enterEmail(key: key, tester: tester);
            })
        ..addScenario(
            name: 'password entered',
            widget: const _AuthForm(),
            onCreate: (key) async {
              await switchToRegisterFormType(key: key, tester: tester);
              await enterPassword(key: key, tester: tester);
            })
        ..addScenario(
            name: 'show entered password',
            widget: const _AuthForm(),
            onCreate: (key) async {
              await switchToRegisterFormType(key: key, tester: tester);
              await tapOnVisibilityIcon(key: key, tester: tester);
              await enterPassword(key: key, tester: tester);
            })
        ..addScenario(
            name: 'tap on isTrainer switch',
            widget: const _AuthForm(),
            onCreate: (key) async {
              await switchToRegisterFormType(key: key, tester: tester);
              await tapOnIsTrainerSwitch(key: key, tester: tester);
            })
        ..addScenario(
            name: 'auth form with filled email and password fields',
            widget: const _AuthForm(),
            onCreate: (key) async {
              await switchToRegisterFormType(key: key, tester: tester);
              await enterEmail(key: key, tester: tester);
              await enterPassword(key: key, tester: tester);
              await tapOnVisibilityIcon(key: key, tester: tester);
              await tapOnIsTrainerSwitch(key: key, tester: tester);
              await enterTrainerName(key: key, tester: tester);
            });

      await tester.pumpDeviceBuilder(builder);
      await tester.pumpAndSettle();

      await screenMatchesGolden(
          tester, 'auth_form_multi_scenario_register_form');
    });
  });
}

class _AuthForm extends StatelessWidget {
  const _AuthForm();

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: myTheme,
      child: const AuthForm(),
    );
  }
}
