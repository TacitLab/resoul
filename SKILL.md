---
name: resoul
description: Give your OpenClaw a fresh soul by replacing the workspace bootstrap state with the latest official BOOTSTRAP.md from upstream after an explicit second confirmation. Use when the user wants to resoul, reset startup identity files, restore the official bootstrap, or intentionally wipe the current SOUL.md and USER.md before starting over. Triggers on requests like "resoul", "reset my soul", "restore official bootstrap", "clear soul and user", or "start over with the official bootstrap".
---

# ReSoul

Reset the workspace bootstrap state so the next fresh session can start from the official upstream `BOOTSTRAP.md`.

## Primary workflow

1. Warn that running `resoul` will download the official `BOOTSTRAP.md` and clear the current `SOUL.md` and `USER.md` from the workspace root.
2. Require an explicit second confirmation before executing anything. Do not treat vague replies like "ok" or "继续" as sufficient; require a clear confirmation that the user agrees to remove the current `SOUL.md` and `USER.md`.
3. Archive the current `SOUL.md` and `USER.md` into `.trash/` if they exist.
4. Fetch the latest official upstream template.
5. Write it to the workspace root as `BOOTSTRAP.md`.
6. Tell the user to run `/new` after completion so the next session starts from the restored bootstrap flow.

Use the bundled script:

```bash
bash {{SKILL_DIR}}/scripts/fetch_official_bootstrap.sh <workspace-dir>
```

Example:

```bash
bash {{SKILL_DIR}}/scripts/fetch_official_bootstrap.sh /root/.openclaw/workspace
```

Upstream source:

```bash
https://raw.githubusercontent.com/openclaw/openclaw/main/docs/reference/templates/BOOTSTRAP.md
```

## Constraints

- Do not execute this skill without a second explicit confirmation in the current conversation.
- Do not hand-author a replacement bootstrap unless the user explicitly asks for a customized variant after syncing the official file.
- Only clear `SOUL.md` and `USER.md` in the workspace root; do not delete memory, project files, skills, or other workspace content.
- Archive replaced files before removal when possible.
- Do not execute the bootstrap ritual automatically after syncing; stop after preparing the workspace and instruct the user to run `/new`.
- Mention that the official template is written for a fresh workspace and should be reviewed before reuse in an existing workspace.

## Fallback

If the script cannot be used, run equivalent shell commands with an explicit backup first.

## Report back

Briefly report:
- that the user gave the destructive confirmation
- whether `SOUL.md` and `USER.md` were archived/cleared
- that the latest official upstream template was fetched
- the destination path
- that the user should run `/new` to trigger the re-bootstrap flow
