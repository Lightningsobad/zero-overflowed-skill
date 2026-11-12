"""Check the published skill and local Markdown links."""

import re
from pathlib import Path
from urllib.parse import unquote, urlsplit

ROOT = Path(__file__).resolve().parents[1]
SKILL = ROOT / "skills/zero-overflowed/SKILL.md"

content = SKILL.read_text(encoding="utf-8")
frontmatter = re.match(r"\A---\nname: ([a-z0-9-]+)\ndescription: ([^\n]+)\n---\n", content)
if not frontmatter:
    raise SystemExit("Expected a name and description in SKILL.md frontmatter")

name, description = frontmatter.groups()
if name != SKILL.parent.name or len(name) > 64:
    raise SystemExit("Skill name must match its directory and fit the Agent Skills limit")
if len(description) > 1024 or ": " in description or " #" in description:
    raise SystemExit("Expected a plain YAML description within the Agent Skills limit")

documents = [*ROOT.glob("*.md"), SKILL]
for directory in ("docs", "skills/zero-overflowed/references"):
    documents.extend((ROOT / directory).rglob("*.md"))
documents.append(ROOT / "examples/overflow_lab/README.md")

errors = []
for document in documents:
    for link in re.findall(r"\[[^\]\n]+\]\(([^)\s]+)\)", document.read_text(encoding="utf-8")):
        url = urlsplit(link)
        if url.scheme or not url.path:
            continue
        target = (document.parent / unquote(url.path)).resolve()
        if not target.is_relative_to(ROOT) or not target.exists():
            errors.append(f"{document.relative_to(ROOT)}: {link}")

if errors:
    raise SystemExit("Invalid relative links:\n" + "\n".join(errors))
print("Skill metadata and relative links passed")
