import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:tryhard_showcase/app/di/di.dart';
import 'package:tryhard_showcase/app/ui/styles/theme.dart';
import 'package:tryhard_showcase/features/auth/ui/auth_screen.dart';

import 'storage/fake_storage.dart';

void main() {
  setUp(() async {
    initHydratedStorage();
    await initDi("test");
  });

  group('Golden Auth Screen', () {
    testGoldens('Auth Screen default state', (tester) async {
      final builder = DeviceBuilder()
        ..overrideDevicesForAllScenarios(devices: [
          Device.phone,
          Device.iphone11,
          Device.tabletPortrait,
          Device.tabletLandscape,
        ])
        ..addScenario(
          widget: const _AuthScreenTest(),
          name: 'auth screen',
        );

      await tester.pumpDeviceBuilder(builder);
      await screenMatchesGolden(
          tester, 'auth_screen_single_scenario_multiple_devices');
    });
  });
}

class _AuthScreenTest extends StatelessWidget {
  const _AuthScreenTest();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: myTheme,
      home: const AuthScreen(),
    );
  }
}
