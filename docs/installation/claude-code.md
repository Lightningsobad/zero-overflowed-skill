# Claude Code

| Scope | Skill parent directory |
| --- | --- |
| Flutter project | `.claude/skills/` |
| User | `~/.claude/skills/` |

Use the [PowerShell or Bash steps](manual.md) with the Claude Code directory. Open the Flutter project in Claude Code and type `/zero-overflowed` to invoke the installed skill. For a first run, install into `examples/overflow_lab` and send:

```text
/zero-overflowed Run the Overflow Lab widget tests with and without BROKEN_LAYOUTS. Explain which assertions detect layout failures and which cases still pass.
```

If the slash command is missing, confirm that the current project and the skill path are correct, then start a new session. The [manual guide](manual.md#verify-update-or-remove) covers version checks, updates, and removal.

[Claude Code skills documentation](https://code.claude.com/docs/en/skills)
