"""Require each faulty fixture to fail on its intended assertion."""

import json
import os
import shutil
import subprocess
import sys
from collections import defaultdict
from pathlib import Path

LAB = Path(__file__).resolve().parents[1] / "examples/overflow_lab"
sys.stdout.reconfigure(errors="backslashreplace")
EXPECTED = {
    "Product card preserves text, price and action (narrow with large text)": "RenderFlex overflowed",
    "Product card preserves text, price and action (baseline)": None,
    "Shipping details are not silently truncated": "Required text was truncated",
    "Checkout stays usable with a simulated keyboard": "Submit action is obscured by the keyboard",
    "Confirmation action is reachable in a short sheet": "Action is unreachable",
    "Intentional horizontal scrolling reaches the final photo": None,
}

flutter = shutil.which("flutter.bat" if os.name == "nt" else "flutter")
if flutter is None:
    raise SystemExit("Flutter must be on PATH")
result = subprocess.run(
    [flutter, "test", "--no-pub", "--machine", "--dart-define=BROKEN_LAYOUTS=true"],
    cwd=LAB,
    stdout=subprocess.PIPE,
    encoding="utf-8",
    check=False,
)

names = {}
messages = defaultdict(list)
observed = {}
for line in result.stdout.splitlines():
    try:
        event = json.loads(line)
    except json.JSONDecodeError:
        print(line)
        continue
    if not isinstance(event, dict) or "type" not in event:
        continue
    if event["type"] == "testStart":
        test = event["test"]
        names[test["id"]] = test["name"]
    if event["type"] in {"error", "print"}:
        message = event.get("error", event.get("message", ""))
        messages[event.get("testID")].append(message)
    if event["type"] == "testDone" and not event["hidden"]:
        name = names[event["testID"]]
        status = "skipped" if event["skipped"] else event["result"]
        observed[name] = (status, "\n".join(messages[event["testID"]]))

valid = result.returncode != 0 and set(observed) == set(EXPECTED)
for name, diagnostic in EXPECTED.items():
    status, details = observed.get(name, ("missing", ""))
    matches = status == "success" if diagnostic is None else (
        status in {"error", "failure"} and diagnostic in details
    )
    valid = valid and matches
    print(f"{'OK' if matches else 'UNEXPECTED'}: {name} ({status})")
    if not matches and details:
        print(details)

if not valid:
    raise SystemExit("Broken fixture results did not match the expected cases")
