# Zero Overflowed Skill

An Agent Skill for Flutter mobile layout. It helps coding agents build adaptive layouts, reproduce overflow, and verify that people can still read required content and use essential controls.

## Quickstart

1. Clone `https://github.com/Lightningsobad/zero-overflowed-skill.git`. Use a release tag when available to keep the skill and examples on the same version.
2. Install the complete `skills/zero-overflowed/` folder into your Flutter project. Follow the guide for [Claude Code](docs/installation/claude-code.md), [Codex](docs/installation/codex.md), or [Antigravity](docs/installation/antigravity.md). Each guide covers project and user installation, invocation, updates, and removal.
3. Tell the agent what your app supports and ask it to run a check. Use the [scope template and prompts](docs/usage.md).

> Use zero-overflowed to check the checkout form on the narrowest supported phone with large text and the keyboard open. Verify that the focused field and submit button remain reachable. Report the tests you ran and any unverified cases.

## Try the Overflow Lab

From this repository, using Flutter 3.44.8:

```sh
cd examples/overflow_lab
flutter pub get
flutter test
flutter test --dart-define=BROKEN_LAYOUTS=true
```

The first run should pass. The second run should fail for the four intentional defects and pass the normal-width product card and horizontal carousel checks. Both runs use the same assertions. See the [fixture guide](examples/overflow_lab/README.md) for expected failures and device setup.

## How verification works

The skill checks framework errors and user outcomes, including full text, visible actions, and intended scrolling. It reports `PASS`, `FAIL`, or `NOT VERIFIED` per case. Define the app's supported viewport, text settings, locales, and device-dependent flows before using the results as release evidence.

- [Compatibility and verification status](docs/support-matrix.md)
- [Agent evaluation protocol](docs/evaluation.md)
- [Quickstart tiếng Việt](docs/quickstart.vi.md)
- [Contributing](CONTRIBUTING.md)
- [Changelog](CHANGELOG.md)
- [MIT license](LICENSE)
