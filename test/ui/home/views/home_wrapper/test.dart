import 'package:flutter_test/flutter_test.dart';

import 'support_test.dart';

void main() {
  testWidgets(
    'The home wrapper is found after pumping up',
    harness((given, when, then) async {
      await given.widgetIsPumped();
      await then.widgetIsFound();
    }),
  );

  final fakeScreensIndexes = [0, 1];
  for (var index in fakeScreensIndexes) {
    testWidgets(
      'screen $index is found when on bottom nav bar item with index $index is tapped',
      harness((given, when, then) async {
        await given.widgetIsPumped();
        await when.bottomNavBarItemIsTapped(index: index);
        await then.findScreenWithIndex(index);
      }),
    );
  }
}
