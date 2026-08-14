# Data Mapping

For migrations and integrations, the story workbook holds the entity layer while a companion mapping workbook holds the field layer. That split keeps the stories readable and the mappings usable, with each one pointing at the other.

## The two layers

**The entity layer, which lives in story rows.** One story per entity migrated or synced, along the lines of "As the Controller, I want open AR migrated so collections continue." The acceptance criteria are the reconciliation itself: "Given cutover complete, When counts are compared, Then source open invoice count = target count minus documented exclusions." The story's Description points at its mapping sheet.

**The field layer, which lives in the mapping workbook.** One sheet per entity, one row per target field:

| Column | Rule |
|---|---|
| Target field | The destination system's name |
| Source field | Or "constant", or "derived" with the rule |
| Transform | The conversion, stated so an engineer can code it and a tester can check it |
| Cleansing rule | What happens to bad source data, with provenance ("write off pre 2019 invoices, per the Controller, 14 Aug") |
| Default | What happens when the source is blank. Never leave this undefined, because blank in and undefined out is how migrations fail quietly |
| Open question | With an owner named, same as on stories |

The same hallucination proofing applies here as in the story workbook, meaning no blanks, provenance on decisions, and closed vocabularies. Cleansing decisions are business decisions rather than technical ones, so they go through the meeting loop with quotes attached, and the material ones land in the decisions log.

## Reconciliation

Every entity gets a reconciliation check with a stated tolerance, whether that is an exact count or a named threshold, plus an exclusion register recording what was deliberately left behind, why, and who approved it. The exclusion register is a migration's version of the out of scope list, and every post cutover dispute you will have walks in through it. When data turns out to be missing after go live, that register is what separates a decision from a defect, which ba-change goes into.

## Cutover

The cutover runbook is a process document, so ba-process-mapping handles it, with the exceptions section carrying the rollback branch and the SLA being the cutover window itself.
