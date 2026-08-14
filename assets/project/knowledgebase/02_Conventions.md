# 02 Conventions, [Project Name]

This is what the project has declared. Anything closed is genuinely closed, so to add a value you change it here first and then use it.

## Story IDs

Prefix: [ABC]. Sequential, zero padded, never reused. A deleted story keeps its ID at Status Deprecated with a pointer to whatever replaced it.

## Closed vocabularies

Type, Phase, Priority and Status are the standard sets from ba-user-stories, and the workbook template's dropdowns already carry them, so they are not restated here, because a second copy is a copy that drifts. Epic, User Role and Data Source are all drawn from 01.

Project additions or overrides: [none]

## Declared registers

Change events run as CH-001 and upward, sequentially. [Add process steps P1, P2, or a client's requirement IDs, if this project uses them.]

## Dates

Every date in the workbook is written as 2026-05-06, 6 May 2026, or May 6, 2026. Never 06/05/2026, because that is two different days depending on who typed it, and these dates end up being read during a dispute. This one is not a project setting, since the sweep reads those three formats and nothing else.

## Windows

The three defaults from ba-change apply here unless they are overridden below. Silence never turns into a yes in any of them, it turns into a proceed at risk record.

This project's overrides: [none]

## Extra workbook columns

These get declared here before they are used. [Estimated Hours and Estimate Notes when the handoff dial says engineer.]

## Authoritative store

The story workbook is authoritative for structure and intent. [If a tracker or database is the native store instead, say so here.] Once tickets exist, the tracker becomes the live status source.
