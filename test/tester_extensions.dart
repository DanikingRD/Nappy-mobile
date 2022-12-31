import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';

extension WidgetTesterHelper on WidgetTester {
  /// For some reason, these animations need an extra `pump(0ms);` to properly start.
  /// This eases that boilerplate a bit. Also adds a convenience method for an initial wait time, which is common.
  Future<void> pumpAnimation(
    Widget child, {
    Duration? delay,
  }) async {
    await pumpWidget(child);
    await pump(Duration.zero);
    if (delay != null) {
      await pump(delay);
    }
  }
}
