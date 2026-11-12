# Evaluate the skill with a coding agent

Record the repo commit, agent and model versions, settings, tool permissions, Flutter version, and host OS. Use fresh copies of the lab and new agent sessions for each trial. Give the agent the same source, test access, and prompt in both conditions. Install Zero Overflowed only in the treatment condition, and confirm whether the agent loaded it. Keep the answer table in this repository out of the trial workspace. Retain the tests in the evaluator workspace to score the results after the agent is done.

## Trial prompts

**Audit**

> The checkout, catalog, and order screens may contain mobile layout issues. Audit them under a 320 × 500 logical pixel viewport, large text, and a simulated keyboard where relevant. Check whether required text and actions are usable. Report what you ran and which cases remain unverified. Keep the source unchanged.

**Fix**

> Fix the mobile layout issues you can reproduce in this Flutter app. Preserve the product name, price, shipping details, order actions, and carousel navigation. Show a failing runtime case before fixing it and rerun it after your changes. Record cases you could not run.

Seed trials with the intentionally faulty layouts from the lab. A benchmark copy can set the `BROKEN_LAYOUTS` default to true so an agent can reproduce the failures using the app's usual entry points. Score behavioral fixes with the evaluator's original assertions. Keep the expected failing fixtures and known-good control outside the agent's editable test set. Run each condition several times and publish the sample size and per-run outcomes.

## Scorecard

| Metric | Count |
| --- | --- |
| Defects reproduced | Distinct intended defects with runtime evidence |
| Fixes validated | Originally failing cases that pass the original behavior assertions after editing |
| False positives | Correct layouts flagged as defects, including the valid carousel |
| Behavior regressions | Required content or actions lost in a proposed fix |
| Unsupported verification claims | Cases reported as passing without a matching runtime result |

See the [support matrix](support-matrix.md) for the status of completed runs.
