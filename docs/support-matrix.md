# Compatibility and verification

This matrix tracks evidence for the current checkout. Manual skill discovery depends on the agent version and the scope where you install it.

| Surface | Platform/version | Install path checked against docs | End-to-end install and invocation |
| --- | --- | --- | --- |
| Claude Code CLI | Windows, 2.1.289 | Project and user | Project copy checked. Invocation requires login and is `NOT VERIFIED`. |
| Codex CLI | Windows, 0.157.0 | Project and user | `PASS` for project installation and explicit invocation on 2026-11-12. User-scope discovery is `NOT VERIFIED`. |
| Codex app | Desktop | Project and user | `NOT VERIFIED` |
| Antigravity App, CLI, IDE | Desktop | Project and shared user | `NOT VERIFIED` |

| Runtime case | Evidence |
| --- | --- |
| Flutter host widget tests, Windows, Flutter 3.44.8 | Six fixed cases passed. The broken fixtures produced four intended failures and two control passes. |
| Manual skill folder copy, PowerShell on Windows | Project copies contain `SKILL.md` and the referenced Flutter guidance. |
| Android keyboard and checkout, 2026-11-12 | `PASS` on Android 13 emulator, 360 × 500 logical px, default system text size. Entered an address, scrolled to Send order, and saw Order sent after tapping with the software keyboard open. Other Android configurations are `NOT VERIFIED`. |
| iOS system IME and insets | `NOT VERIFIED` |
| Agent behavior with and without the skill | `NOT VERIFIED` |

Use [the lab](../examples/overflow_lab/README.md) for the host-side widget tests. A passing widget test with injected keyboard insets verifies that simulated layout case.
