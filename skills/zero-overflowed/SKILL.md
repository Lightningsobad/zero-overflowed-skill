---
name: zero-overflowed
description: Prevent, reproduce, verify, and fix Flutter mobile layout overflow, clipped content, and controls obscured by the keyboard or system UI. Use when writing or reviewing affected Flutter screens and widgets, or investigating RenderFlex overflow and related layout regressions.
---

# Zero Overflowed

Use the project's existing layout conventions, test harness, and supported device and settings scope. Identify required content and actions, parent constraints, and the screen states affected by the change. If support limits are unknown, run representative exploratory cases and record the assumptions. Mark the support scope `NOT VERIFIED` until it is defined and checked.

## Choose the workflow

- **Write UI.** Identify what can wrap, grow, scroll, or rearrange as space shrinks. Read [Flutter layout](references/flutter-layout.md) for the relevant layout pattern. Add or extend runtime coverage of the changed layout, then run it.
- **Check UI.** Use [Flutter testing](references/flutter-testing.md) to select and run a normal case and the relevant supported limits. Report findings and reproduction steps. Respect requests for a read-only audit.
- **Fix UI.** Reproduce the failure first and capture the failed expectation. Trace the offending axis back to the parent constraint or obscuring surface. Make the smallest fix that preserves content and actions. Run the same regression case and a normal case after the change.

## Verify and report

Check framework layout errors and user-visible behavior. A quiet test log or a widget finder alone cannot establish that the full text is readable or the action can be reached. For intentional clipping, overlap, or scrolling, test its expected behavior, including access to required content and controls. Preserve supported text scaling and touch targets. Truncation requires product intent for that content.

Report the widget or screen, case configuration, data and interaction, test command, and observed result. Use `PASS` when every required assertion in the case ran and passed, `FAIL` for an observed failed assertion or layout error, and `NOT VERIFIED` for cases without runtime evidence. Report any failed or unverified required cases before declaring the supported scope verified.
