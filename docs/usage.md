# Use Zero Overflowed

## Declare your app's support scope

Keep these values in the app's existing engineering documentation or include them in the prompt. The example values are illustrative. Use the constraints and settings your team actually supports.

```text
Platforms: Android and iOS
Minimum usable layout: 320 logical px wide in portrait, 320 logical px high in landscape
Portrait and landscape: both supported
Text sizing: default and highest supported OS text setting
Locales: en, vi, ar (RTL)
Required device flows: checkout with keyboard open, landscape with system insets
Required content/actions: full delivery instructions, editable address, reachable Submit
```

Define whether each dimension refers to the window or usable space inside a surface. For embedded components, include the smallest supported parent where it differs from the window. If limits are unknown, ask the agent to state its exploratory settings and mark the supported scope `NOT VERIFIED`.

## Prompts

**Write**

> Use zero-overflowed to implement the product card. The title can wrap, the price must stay readable, and Add to cart must remain reachable. Add and run layout tests at the baseline and narrowest supported parent with large text and a long title.

**Check**

> Use zero-overflowed to audit the checkout screen. Keep the source unchanged. Verify the focused address field and submit action with keyboard insets, and list any device cases you could not run.

**Fix**

> Use zero-overflowed to fix the checkout button being covered by the keyboard. Reproduce it in a widget test, fix the layout, run the same test again, and verify a normal case. Record whether the real keyboard flow ran on a device.

## Example report

| Case | Settings and interaction | Result |
| --- | --- | --- |
| Checkout, broken fixture | 320 × 500 logical px, 1× text, 280 px simulated keyboard inset. Enter an address and try to reach Send order. | `FAIL` — the submit action extends into the keyboard area. |
| Checkout, fixed fixture | Same settings. Enter the address, scroll, tap Send order. | `PASS` — the action fits above the inset and tapping it shows Order sent. |
| Checkout on iOS | Real software keyboard and system text setting. | `NOT VERIFIED` — no iOS simulator or device run. |

Example commands from the lab root are `flutter test --dart-define=BROKEN_LAYOUTS=true --plain-name Checkout` and `flutter test --plain-name Checkout`. Keep the exact command, configuration, data and interaction with the result. Use the [fixture guide](../examples/overflow_lab/README.md) to reproduce all cases.
