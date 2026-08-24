# AGENTS.md

Operating rules for this repo, for any coding agent (Claude Code, Codex, Cursor) and any
human editing it. This file is committed on purpose, because the repo is the instructions.

## What this repo is

A business analysis method, packaged as task specific agent skills under `skills/`, plus the
templates and scripts a project runs on. Each skill owns one slice of the work. README.md has
the pipeline and the skill table.

This file governs editing the repo. It is not the method. When you are doing BA work rather
than repo maintenance, read the matching skill instead.

## How the skills are structured

- One folder per skill under `skills/`, each with a `SKILL.md`, and a `references/` folder
  where a skill has depth worth loading separately.
- `SKILL.md` frontmatter has two keys, `name` (matching the folder name) and `description`,
  written as a `>-` folded block so a long description stays readable and diffs line by line.
  The description is the trigger, so make it pushy and packed with trigger phrases. Keep it
  under 1024 characters.
- Keep the `SKILL.md` body under 150 lines. Depth goes in `references/`.
- Every skill folder is self contained. Never point outside it with a path. Name another
  skill instead ("the vague word list in the `ba-user-stories` skill"), because a skill folder
  has to survive being copied on its own into `~/.agents/skills/`.
- Every reference file must be named in its own SKILL.md, or an agent will never load it.
- `assets/` is the exception, since the xlsx templates cannot sensibly live inside every
  skill. A skill may point at them as long as it names the repo, so a reader who only
  installed the skill has somewhere to go.

## One source for the workbook vocabulary

The story field set and the closed sets exist in three places: `FIELDS` and `CLOSED` in
`scripts/validate_workbook.py`, the dropdowns in the generated templates, and the field table
in the `ba-user-stories` skill. The first two are tied together by an import, and
`scripts/check_doc_contract.py` ties in the third. Change the vocabulary in
`validate_workbook.py`, regenerate the templates, update the field table, and run the check.
Never edit the templates by hand.

## Writing rules (apply to every file here)

These govern files in this repo. They are not style advice for a BA's own deliverables, and
nothing here should be applied to a user's documents unless they ask for it.

- Plain and direct. Explain the why, not marketing filler.
- Never use an em dash or an en dash. Use commas, periods, or parentheses.
- Never state a count of things this repo contains. Not the number of skills, not "sixteen
  canonical fields". Every such number is a promise to come back and edit it, the edit gets
  missed, and the number then quietly lies. Counts inside the method are different: the
  dials, the three handoffs and the three outputs are designed sets, not inventory, and
  changing one of those is a redesign rather than an edit.
- Show the evidence, do not announce it. Write what happens and why it matters, not "this is
  critical". The detail is what makes the point.
- Say what has not been proven yet. A skill that has not survived a live engagement says so.

## Redaction (everything here is public)

- Organizations and people appear as roles, never as names.
- Vendor names for project tools and AI assistants stay generic, hence "your project
  management tool" and "a leading LLM".
- Sample data is fictional. No real email addresses, hosts, or client documents.

`tools\check.ps1` enforces the mechanical part. For terms specific to your own clients, put
one regex per line in `tools\banned.local.txt`. Git ignores that file, so your terms never
reach the repo, and the check picks them up automatically.

## Keep the method honest

The method is only worth what it reflects. When a live engagement contradicts a skill, fix
the skill the same session. When a skill gets its first live run, update the note in README.md
that says it has not had one.

## Changes via pull request

Make each change on a branch and open a pull request. Do not commit straight to main. A brand
new skill folder needs no manifest change, `.claude-plugin/plugin.json` already exposes every
folder under `skills/`. Bump the `version` in plugin.json so installed copies pick the change
up on the next `/plugin update`.

## Verify before committing

```
pwsh -File tools\check.ps1
```

Exit code 0 means clean. It checks the writing rules, the frontmatter, the size caps, skill
self containment, that every reference resolves and is named in its SKILL.md, that every named
skill exists, that every skill is listed in README.md, that every JSON parses, redaction, and
the workbook vocabulary contract across the validator, the templates, and the field table.

What it cannot check, so read for it yourself: whether the method still describes what
actually happens on a live engagement.
