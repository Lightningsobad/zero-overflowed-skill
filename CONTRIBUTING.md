# Contributing

For an overflow that the skill misses, open an issue with the Flutter version, platform, usable dimensions, text settings, locale, keyboard state, and the affected content or action. Include a small Flutter reproducer if possible. For installation issues, report the tool, version, scope, installed directory, and command or UI steps.

Keep agent-specific setup in `docs/installation/` and reusable instructions in `skills/zero-overflowed/`. Add a regression fixture when changing what the skill detects. Run `flutter analyze` and `flutter test` from `examples/overflow_lab`. For changes to the lab, also run `flutter test --dart-define=BROKEN_LAYOUTS=true` and check the failure matrix in the [lab guide](examples/overflow_lab/README.md). Record any new manual integration results in the [support matrix](docs/support-matrix.md).
