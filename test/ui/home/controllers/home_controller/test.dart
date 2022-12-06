import 'package:flutter_test/flutter_test.dart';

import 'support_test.dart';

void main() {
  group('changing pages testing', () {
    final fakePageIndexes = [0, 1];
    for (var index in fakePageIndexes) {
      test(
        "viewModel's page is $index successfully changes on change page call",
        harness((given, when, then) async {
          when.changingPageTo(index);
          then.viewModelWouldBeWithPage(index);
        }),
      );
    }
  });
}
