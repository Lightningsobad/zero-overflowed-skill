# Google Antigravity

| Scope | Skill parent directory |
| --- | --- |
| Flutter workspace | `.agents/skills/` |
| User, shared | `~/.gemini/config/skills/` |

Use the [PowerShell or Bash steps](manual.md) and open the Flutter project as a workspace. Check discovery on your surface:

- **App** — check the skills list in Customizations for the project. Type `/zero-overflowed` to invoke it.
- **CLI** — start `agy` from the project and check `/skills`. After a change, use `/skills reload` or start a new conversation. Type `/zero-overflowed` to invoke it.
- **IDE** — inspect Customizations in the agent side panel. Ask the agent to use `zero-overflowed` by name.

For a first run, install into `examples/overflow_lab` and ask:

```text
Use zero-overflowed to run the Overflow Lab widget tests with and without BROKEN_LAYOUTS. Explain which assertions detect layout failures and which cases still pass.
```

If the CLI and App show different versions, check for a CLI-only copy in `~/.gemini/antigravity-cli/skills/` or `~/.gemini/skills/`. See the [manual guide](manual.md#verify-update-or-remove) for version checks, updates, and removal.

[Antigravity skills documentation](https://antigravity.google/docs/skills)
