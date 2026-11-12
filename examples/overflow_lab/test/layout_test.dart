import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:overflow_lab/main.dart';

Future<void> showDemo(
  WidgetTester tester,
  Widget demo, {
  Size size = const Size(320, 500),
  double textScale = 2,
}) async {
  tester.view.devicePixelRatio = 1;
  tester.view.physicalSize = size;
  addTearDown(tester.view.resetDevicePixelRatio);
  addTearDown(tester.view.resetPhysicalSize);
  await tester.pumpWidget(
    MaterialApp(
      builder: (context, child) => MediaQuery(
        data: MediaQuery.of(
          context,
        ).copyWith(textScaler: TextScaler.linear(textScale)),
        child: child!,
      ),
      home: demo,
    ),
  );
  await tester.pumpAndSettle();
}

void expectFullText(WidgetTester tester, Finder text) {
  final richText = find.descendant(of: text, matching: find.byType(RichText));
  final paragraph = tester.renderObject<RenderParagraph>(richText);
  expect(
    paragraph.didExceedMaxLines,
    isFalse,
    reason: 'Required text was truncated',
  );
}

Future<void> revealAction(
  WidgetTester tester,
  Finder action,
  Key viewport,
) async {
  final scrollable = find.descendant(
    of: find.byKey(viewport),
    matching: find.byType(Scrollable),
  );
  if (scrollable.evaluate().isNotEmpty) {
    await tester.scrollUntilVisible(action, 48, scrollable: scrollable.first);
  }
  await tester.pumpAndSettle();
}

Future<void> tapReachable(WidgetTester tester, Finder action) async {
  expect(action.hitTestable(), findsOneWidget, reason: 'Action is unreachable');
  await tester.tap(action);
  await tester.pumpAndSettle();
}

void main() {
  for (final (label, size, scale) in [
    ('narrow with large text', const Size(320, 500), 2.0),
    ('baseline', const Size(720, 500), 1.0),
  ]) {
    testWidgets('Product card preserves text, price and action ($label)', (
      tester,
    ) async {
      await showDemo(tester, const ProductDemo(), size: size, textScale: scale);
      expect(tester.takeException(), isNull, reason: 'Product card must fit');
      expectFullText(tester, find.text(productName));
      expect(find.text('\$129').hitTestable(), findsOneWidget);
      await tapReachable(tester, find.byKey(addButton));
      expect(find.text('Added to cart'), findsOneWidget);
    });
  }

  testWidgets('Shipping details are not silently truncated', (tester) async {
    await showDemo(tester, const ShippingDemo());
    expect(tester.takeException(), isNull);
    expectFullText(tester, find.byKey(shippingText));
  });

  testWidgets('Checkout stays usable with a simulated keyboard', (
    tester,
  ) async {
    await showDemo(tester, const CheckoutDemo(), textScale: 1);
    final address = find.byKey(addressField);
    await tester.showKeyboard(address);
    await tester.enterText(address, '42 Pine Street');
    const keyboardHeight = 280.0;
    tester.view.viewInsets = const FakeViewPadding(bottom: keyboardHeight);
    addTearDown(tester.view.resetViewInsets);
    await tester.pumpAndSettle();

    final visibleBottom = tester.view.physicalSize.height - keyboardHeight;
    expect(tester.getBottomLeft(address).dy, lessThanOrEqualTo(visibleBottom));
    final action = find.byKey(submitButton);
    await revealAction(tester, action, checkoutScroll);
    expect(
      tester.getBottomLeft(action).dy,
      lessThanOrEqualTo(visibleBottom),
      reason: 'Submit action is obscured by the keyboard',
    );
    await tapReachable(tester, action);
    expect(find.text('Order sent'), findsOneWidget);
  });

  testWidgets('Confirmation action is reachable in a short sheet', (
    tester,
  ) async {
    await showDemo(tester, const SheetDemo(), size: const Size(320, 300));
    await tester.tap(find.text('Open sheet'));
    await tester.pumpAndSettle();
    final action = find.byKey(confirmButton);
    await revealAction(tester, action, sheetScroll);
    await tapReachable(tester, action);
    expect(find.text('Order confirmed'), findsOneWidget);
  });

  testWidgets('Intentional horizontal scrolling reaches the final photo', (
    tester,
  ) async {
    await showDemo(tester, const CarouselDemo());
    final lastPhoto = find.text('Photo 5');
    expect(lastPhoto.hitTestable(), findsNothing);
    await tester.scrollUntilVisible(lastPhoto, 160);
    await tester.pumpAndSettle();
    expect(lastPhoto.hitTestable(), findsOneWidget);
  });
}
