# Overflow Lab

Run from this directory with Flutter 3.44.8.

```sh
flutter pub get
flutter test
flutter test --dart-define=BROKEN_LAYOUTS=true
```

The first command resolves dependencies. The normal test run expects six passes. The broken run expects a nonzero exit status with four failures and two passes.

| Case | What the regression test checks | Broken run |
| --- | --- | --- |
| Product, narrow parent and 2× text | Flutter reports no layout exception. Product name, price, and cart action remain usable. | `RenderFlex` overflow |
| Product, baseline | Same checks at 720 × 500 logical pixels and 1× text. | Pass |
| Shipping details | The paragraph shows all required content. | Text is silently truncated |
| Checkout | A focused field fits above a simulated IME, and scrolling makes Send order visible and tappable. | The action extends into the keyboard area |
| Confirmation sheet | The user can reach and tap Confirm order in the short viewport. | The action is clipped |
| Carousel | Horizontal scrolling reaches the final photo. | Pass |

## Android or iOS device run

Generate the local platform runners once using `flutter create --platforms=android,ios .` from this directory. Use a configured Android emulator or device, or an iOS simulator or device on macOS. Use `flutter devices` to find its ID, then run `flutter run -d <device-id>` for the fixed examples or `flutter run -d <device-id> --dart-define=BROKEN_LAYOUTS=true` to see the faulty layouts. Select Checkout form, focus the address, and check whether you can scroll to and submit while the real keyboard is open. Record the device, OS, display/text settings, and what happened.
