# 03 Backlog and Tracking, [Project Name]

Where the work lives and how it moves.

## Where the stories are

[Path or link to the workbook.] One row per story, using the 16 fields from ba-user-stories.

## Where the tickets are

[Tracker and project.] Which stories are allowed to become tickets depends on the formality dial, and ba-handoff holds that rule.

Once they are created, the tracker holds live status and the workbook holds structure and intent.

## The loop

A meeting or a source lands in `sources/`, the change list gets proposed before anything is applied, the BA approves it, and only then do files change. Directives that reprioritize or reverse scope become change events in 04.

## Before a handoff

```
python <path to AIBA.Skills>/scripts/validate_workbook.py <workbook.xlsx> --kb knowledgebase/
```

The review pass in ba-user-stories is the specification, and the script only automates its mechanical half.
