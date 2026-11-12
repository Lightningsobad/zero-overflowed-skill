# Flutter layout

Identify the available space at the parent that constrains the component. Account for local padding, sibling minimum sizes, and system insets as handled by the surrounding layout. Use `LayoutBuilder` where the component needs to react to its local constraints. Use `MediaQuery` for window and accessibility state.

| Symptom | Decision |
| --- | --- |
| Long text in a bounded `Row` | Give the text a width budget with `Flexible` or `Expanded` where the flex axis is bounded. Let required text wrap. Move actions to a second row or stack the layout if the fixed items already exceed the width. |
| Chips or actions exceed one line | Use `Wrap` when groups can flow across lines. Check each item at the smallest width. Switch to a vertical layout when items need more width to preserve text and touch targets. |
| Fixed-height card cuts multiline content | Allow content to grow. Keep fixed dimensions for elements with an intentional size, such as an avatar. |
| Flex inside a scrollable throws an unbounded-axis error | Find where the axis becomes unbounded. Let content size itself or bound the viewport at the owner. Use one primary scroll region or compose slivers for a shared scrolling layout. |
| Keyboard or system UI obscures a form action | Check how the surrounding scaffold, route, and safe areas consume insets. Give the form a bounded scroll viewport and verify that the focused field and primary action are reachable. |
| Dialog or sheet clips controls | Bound the surface to the space available, then give overflowing content a scrollable area. Check that actions are visible or reachable by scrolling. |

Use ellipsis, clipping, and intentional overlap only where the UI design allows them. Preserve access to full content where it is required. Fix the constraint or layout strategy that causes the issue before considering a visual treatment.

[Flutter constraints](https://docs.flutter.dev/ui/layout/constraints) · [Common layout errors](https://docs.flutter.dev/testing/common-errors)
