# Codex CLI and app

| Scope | Skill parent directory |
| --- | --- |
| Flutter project | `.agents/skills/` |
| User | `~/.agents/skills/` |

Use the [PowerShell or Bash steps](manual.md). Start a new Codex session with the Flutter project as the workspace. Select `zero-overflowed` in the skill picker where available, or name the skill explicitly in the prompt. For a first run, install into `examples/overflow_lab` and send:

```text
$zero-overflowed Run the Overflow Lab widget tests with and without BROKEN_LAYOUTS. Explain which assertions detect layout failures and which cases still pass.
```

If the skill is missing, confirm the project root and check `SKILL.md` and `references/` in the installed directory. If the Flutter command is blocked by workspace permissions, record the runtime result as `NOT VERIFIED` until it runs. See the [manual guide](manual.md#verify-update-or-remove) for version checks, updates, and removal.

[OpenAI skill installation paths](https://developers.openai.com/api/reference/cli)
