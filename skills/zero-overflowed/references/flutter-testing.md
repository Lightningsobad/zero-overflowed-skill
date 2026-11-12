# Flutter testing

Use the test framework and fixtures already in the app. Pick a baseline and the relevant supported limits. For text-heavy or reused widgets, combine the narrowest supported parent, long realistic content, and the highest supported text size. Add short height, landscape, RTL, safe areas, and keyboard or focus states where the app supports them and the changed UI is affected.

- **Set the conditions explicitly.** Express logical dimensions clearly. When setting `tester.view.physicalSize`, set the device pixel ratio to match the intended logical size and reset both with `addTearDown`. Use a test `MediaQuery` for targeted text scaling. Provide the actual locale and directionality when testing translations or RTL. Use the app theme and representative strings when font metrics matter.
- **Check layout errors after rendering and interaction.** Let `flutter_test` fail on uncaught framework errors. When inspecting exceptions through `tester.takeException()`, assert the expected outcome and preserve failures. An intentional broken fixture may assert a specific overflow diagnostic. A normal regression test must fail when that diagnostic occurs.
- **Check user outcomes separately.** For an ordinary `Text`, `RenderParagraph.didExceedMaxLines` can detect truncation. A parent may still clip or cover that paragraph, so check the visible viewport and any relevant clip or overlay. For controls, scroll or focus through the supported path, verify hit testing inside the usable area, tap, and assert the resulting state. For an intentional carousel, assert that the last item can be reached.
- **Match the environment to the claim.** Simulated `viewInsets` exercise the widget's reaction to reduced space. Verify real IME, native system bars, platform fonts, and system text scaling on an appropriate emulator, simulator, or device where the supported flow depends on them. Record any required run without evidence as `NOT VERIFIED`.
- **Keep the reproducer.** Record constraints, data, interaction, and the failed assertion. Confirm it fails on the faulty code and passes with the fix. Run a normal case to verify baseline layout and behavior.

Start with `flutter test path/to/layout_test.dart` from the Flutter package root and use the project's configured integration commands when needed. `flutter analyze` is useful for code validation. Runtime coverage comes from executing the layout cases.

[Flutter WidgetTester](https://api.flutter.dev/flutter/flutter_test/WidgetTester-class.html) · [Flutter integration testing](https://docs.flutter.dev/testing/integration-tests)
