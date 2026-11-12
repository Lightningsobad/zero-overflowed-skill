# Install from a checkout

Prerequisites are the target agent, access to a checkout of this repository, and Flutter on `PATH` to run the example. Check `flutter --version` in the same environment where the agent executes commands. The [compatibility matrix](../support-matrix.md) lists verification status.

Set the source to the root of your Zero Overflowed checkout and the destination to the skill parent directory listed in your agent guide. Use the absolute destination for a user-wide install or run from your Flutter project root for a project-relative destination.

## PowerShell

```powershell
$source = 'C:/path/to/zero-overflowed-skill'
$destination = '.agents/skills'  # Use your agent's path.
$target = Join-Path $destination 'zero-overflowed'
if (Test-Path -LiteralPath $target) { throw "Already installed at $target" }
New-Item -ItemType Directory -Force -Path $destination | Out-Null
Copy-Item -LiteralPath (Join-Path $source 'skills/zero-overflowed') -Destination $target -Recurse
Get-Item -LiteralPath (Join-Path $target 'SKILL.md')
```

For a user-wide install, set `$destination` with `Join-Path $HOME '<agent-relative-directory>'` using the guide's user path without `~/`.

## Bash

```bash
source_repo='/path/to/zero-overflowed-skill'
destination='.agents/skills'  # Use your agent's path.
target="$destination/zero-overflowed"
if [ -e "$target" ] || [ -L "$target" ]; then
  printf 'Already installed at %s\n' "$target" >&2
else
  mkdir -p "$destination" && cp -R "$source_repo/skills/zero-overflowed" "$target"
fi
test -f "$target/SKILL.md" && printf '%s\n' "$target/SKILL.md"
```

For a user-wide install, use `$HOME` in the path, for example `destination="$HOME/.agents/skills"`.

## Verify, update, or remove

Open a new agent session in the target project and follow the agent guide's invocation steps. Ask it to identify the loaded skill path and run the example prompt. Compare the installed `SKILL.md` and `references/` with the checkout of your chosen tag or commit when checking the installed version.

To update, obtain the desired tag or commit, move the old `zero-overflowed` folder outside the skill discovery directories, and repeat the copy. To uninstall, remove the installed `zero-overflowed` folder and start a new session. If the skill is still listed, check for a second project, user, or plugin installation.

If discovery fails, confirm the target contains `zero-overflowed/SKILL.md` and `zero-overflowed/references/` at the same level. Check that the agent opened the intended project and that its settings allow project skills. If Flutter works in your terminal but fails inside the agent, check the agent's working directory, `PATH`, and SDK cache permissions. Mark affected runtime checks `NOT VERIFIED` until the command runs.
