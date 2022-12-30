import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nappy_mobile/common/util/responsive.dart';

const kMobileTestSize = Size(400, 400);
const kTabletTestSize = Size(800, 600);
const kDesktopTestSize = Size(1440, 900);
void main() {
  testWidgets("Responsive functions", (WidgetTester tester) async {
    // Small screen test
    await tester.pumpWidget(
      makeTestWidget(kMobileTestSize, (ctx) {
        expect(Responsive.isSmallScreen(ctx), isTrue);
        expect(Responsive.isMediumScreen(ctx), isFalse);
        expect(Responsive.isLargeScreen(ctx), isFalse);
        expect(Responsive.isTabletOrGreater(ctx), isFalse);
      }),
    );
    // Medium screen test
    await tester.pumpWidget(
      makeTestWidget(kTabletTestSize, (ctx) {
        expect(Responsive.isSmallScreen(ctx), isFalse);
        expect(Responsive.isMediumScreen(ctx), isTrue);
        expect(Responsive.isLargeScreen(ctx), isFalse);
        expect(Responsive.isTabletOrGreater(ctx), isTrue);
      }),
    );
    // Large screen test
    await tester.pumpWidget(
      makeTestWidget(kDesktopTestSize, (ctx) {
        expect(Responsive.isSmallScreen(ctx), isFalse);
        expect(Responsive.isMediumScreen(ctx), isFalse);
        expect(Responsive.isLargeScreen(ctx), isTrue);
        expect(Responsive.isTabletOrGreater(ctx), isTrue);
      }),
    );
  });
}

Widget makeTestWidget(Size size, Function(BuildContext) action) {
  return MaterialApp(
    home: MediaQuery(
      data: MediaQueryData(size: size),
      child: Builder(
        builder: (context) {
          action.call(context);
          return const Placeholder();
        },
      ),
    ),
  );
}
