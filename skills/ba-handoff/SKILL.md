---
name: ba-handoff
description: Move a finished story workbook into the hands that act on it: an engineer who estimates, a tracker that holds tickets, a stakeholder who needs one page. Use when stories are ready for estimation, when creating tickets from the workbook via the project management tool's MCP, when an engineer's estimates come back, or when a stakeholder or executive needs a summary. Trigger on "send this for estimates", "create the tickets", "push to the tracker", "make a one pager", "summarize the project for", "the estimates are back", "rollout plan", "migration cohorts", "comms plan", or "who needs to be told".
---

# BA Handoff

There are three handoffs and one source of truth. The workbook feeds all three of them, and nothing is maintained separately anywhere. Four more sections load in at the edges, covering rollout and comms when the ship is staged or an absent audience needs telling, closure at the end, and acceptance for when what arrived is a finished build rather than a backlog.

## 1. Engineer estimation round trip

Send the workbook across with the two extra columns empty, meaning Estimated Hours and Estimate Notes. When handoff differs epic by epic, send only the engineer epics, since the rest already carry N/A. The engineer fills in both columns. The notes matter every bit as much as the hours, because they capture the technical read of the story, along the lines of "configuration only on the auth service" or "depends on selecting a vendor", and they often surface dependencies the BA had no way of seeing. Treat whatever comes back in them as input, since returned notes frequently spawn new Open Questions or Assumptions on the story. An engineer who lives inside the tracker can estimate there instead, and the numbers sync back to the workbook so that the baseline still gets priced in one place.

Once estimates land, the baseline is priced. From that point on, any change to a priced story gets one change event in the decisions log in 04_Worklog.md. The fields for it are in ba-change, and note that one decision touching many stories is one entry carrying all their IDs rather than one line each. Scope that moves after pricing is where budget disputes get born, and the log is the difference between having a conversation about it and having an argument.

If the total hours surprise anybody, that is a scoping conversation to have with the approver before the build starts rather than after.

## 2. Tickets via the project management tool MCP

The workbook is built so an AI connected to your project management tool can read it, and one row becomes one ticket. The mapping is:

- Story ID leads the ticket title, giving you something like "MSP-008: Submit a standard service request"
- User Story plus Description form the body
- Acceptance Criteria go in as a checklist or a clearly marked section, with the exception of eval type criteria, meaning a threshold on an eval set, which link to the eval spec instead, because a checkbox reading "95 percent grounded" is not something QA can tick
- Epic maps to the tool's grouping concept, Phase to the milestone or cycle, and MoSCoW to priority if the tool has one
- Dependencies become ticket links wherever the tool supports them
- Assumptions and Open Questions get carried in the body and never dropped, because the engineer needs them where the work is actually happening

Create tickets only from stories at Status Approved, unless the formality dial is Lean and the BA decides Draft is good enough. On Firm, a story carrying a proceed at risk record, which ba-change covers, also qualifies. On Contract it never does, with the single exception of a fix that has already shipped, whose ticket gets created from the debt record it left behind. After creation the tracker becomes the live status source while the workbook remains the reference for structure and full detail. When a story's content changes after its ticket exists, update the ticket body and flag a re estimate if the story was priced, because the engineer builds from the ticket and so a workbook only change is a change the build never hears about. Directive driven changes propagate here once the directive has settled rather than the moment it lands, which the settling window in ba-change explains, since a reprioritization that reverses on Wednesday ought to cost the tracker nothing at all.

The path also runs in reverse. When tickets already exist, whether that is an inherited backlog or a landed rescue, read the tracker into workbook rows first, taking one ticket to one row with provenance pointing at the ticket ID. Then dedupe and normalize against 02_Conventions.md before anything new gets written. Reconciliation is a proposal list in the same way the meeting loop is, covering what merges, what deprecates, and what survives, all approved by the owner before any of it is applied. If a story conflicts between the two, the tracker wins on status and the workbook, or whichever store 02_Conventions.md names as authoritative, wins on intent. Where 02_Conventions.md names the tracker itself as the authoritative store, none of that applies and you normalize in place, because seventy tickets transcribed into a workbook the client is never going to read is a day of typing plus a second record to keep true.

## 3. Stakeholder one pager

This gets generated on demand from 01_Requirements_Source.md and whatever the project's deliverable is, meaning the workbook, the process document, or the findings document. It is never maintained as a document in its own right, because a maintained copy drifts and a drifted summary is worse than having none at all.

The contents run to one page in this order: the business problem in two sentences, what ships in the current phase as an epic list, what is explicitly out, the headline numbers covering story count, estimated hours and a target date if one exists, the open items that need the reader, meaning unanswered questions owned by their side and approvals waiting on them, and finally the dials in plain words, covering who can log in and how formally this is running.

That last section is the entire point of the page, because a one pager that asks for nothing changes nothing. Put what the reader owes at the end, and name them.

Stakeholders increasingly hand documents to their own AI and start asking it questions. The knowledgebase files are already the right shape for that, being plain markdown with one topic per file and no cross document ID chains, so offer the folder rather than the one pager when the stakeholder is the kind who will actually dig into it.

## 4. Rollout

When shipping is staged, whether through flags, cohorts, or a migration of existing users, the rollout is scope rather than an afterthought, and it lives in the workbook like everything else does. It comes in three parts:

- **Cohorts.** Who moves when, recorded as rows or as a declared column in 02_Conventions.md, rather than as prose in a chat thread. An 80,000 customer migration is a sequence of approvals, and each one gets recorded.
- **Rollback.** The trigger, which needs to be a number rather than a feeling, who calls it, and what the user sees when it happens. A rollback nobody defined before launch is a rollback that gets defined in the middle of the incident.
- **Flag retirement.** A flag that ships permanently on is scope that never closed, so give it a story and a date.

Changes to a priced baseline mid rollout follow the same rule as any other priced change, meaning a change event in the decisions log, per ba-change. A compression ordered verbally is a verbal decision, so read it back and get it confirmed in writing before any cohort dates move.

## 5. Comms plan

When a change lands on people who never attend the meetings, such as a deprecation hitting partners or a migration hitting customers, the comms plan goes in as a table in the knowledgebase covering audience, message, channel, date and owner, with one row per audience per moment. The rule that keeps it honest is the same one the one pager runs on, in that every message names what its reader has to do and by when. A comms plan that only announces things changes nothing.

External audiences cannot approve stories, they can only be represented. The internal owner of that audience, such as a DevRel lead or an account manager, is the approver of record for what gets said to them, and that gets recorded like any other approval.

## 6. Closing the project

A project is closed when three things are true, written up as the final entry in the decisions log, although on Lean and tier 1 a single worklog line covering all three is enough:

- The review pass runs clean at the project's current tier.
- Every debt record is either closed or has moved to a named owner outside the project with a date attached. An open one at closure is a promise nobody is left around to keep.
- Somebody is named for whatever arrives afterward, meaning the defects, the questions, and the next phase.

## 7. When the build already exists

On the inherited handoff value the pipeline runs backwards, in that the delivered build is the proposal and the workbook gets written against it. Run the review pass at the project's tier across what was delivered, one row per capability, with the build itself standing as provenance. Whatever the build does and the row does not is scope nobody agreed to, and it gets recorded rather than silently kept. Whatever the row says and the build does not is the acceptance list, prioritized like any other backlog. On Contract the sign off runs through ba-formal-signoff, and below that, closing the acceptance list is the acceptance.
