# 01 Requirements Source, [Project Name]

This is the stable foundation, covering why this work exists, what is in and out, and who decides. Meeting level detail does not live here. Touch this file only for genuine fundamentals, meaning a new owner, a major scope change, a new data source, a new phase, or a dial that has moved.

## Dials

These get set once at intake and change only through a recorded change event, which ba-change covers.

**Security tier:** [choose: Tier 1, Tier 2, Tier 2 plus] with [who bears the cost of failure, whose data is handled]
**Formality:** [choose: Lean, Firm, Contract] with [who pays if we are wrong]
**Mandate mode:** [choose: Mode A mandated, Mode B delegated] with [who decided this]
**Handoff:** [choose: Self build, Engineer, Vendor builds, Buy a product, Inherited, Undecided with a decision date]

Delete the options you did not choose and leave one value on each line. If they are left in brackets the validator reports the tier as unset and skips the checks that depend on it, which is intended behaviour, because an unset dial ought to be loud rather than quietly read as the lightest option available.

<!-- When handoff differs by epic, replace the single value with this table:
| Epic | Handoff |
|---|---|
| [epic] | [value] |
-->

## Business problem

What hurts today, written in the words of the people it hurts, with no solution language in it.

## How this work arrived

Mode A or B, who asked for it, and what it is attached to, in one honest paragraph.

## Success measures

Numbers, if any exist. If nobody ever defined any, say exactly that and record the absence.

## Scope, in

The epics or capability areas. This list is the closed set that the workbook's Epic column draws from.

## Scope, out

Explicit, with one line of reasoning against each.

## Stakeholders

| Role | Decides |
|---|---|
| | |

Name every approving role now, including joint approvers on both sides.

## Data sources and systems touched

Every external system this work depends on. This list is the closed set that the workbook's Data Source column draws from.

## Roles

The user roles that the workbook's User Role column draws from.

## Constraints

Budget posture, deadline, licensing, and anything else already fixed.
