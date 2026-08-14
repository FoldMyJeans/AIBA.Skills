---
name: ba-project-intake
description: Start a business analysis project properly in under an hour. Use whenever a new project, feature request, tool build, process change, analysis request ("figure out why"), or experiment lands on the BA, whether it arrived as a real elicitation or as a directive from above. Sets the four rigor dials, creates the standard project folder, and writes a lightweight BRD that records why the work exists, what is out of scope, and how the work arrived. Also covers what a live project owes when a dial no longer matches reality, including a tier or formality upshift, ceremony that must come back, and approvals built up under Lean. Trigger on "new project", "we got asked to build", "start the BA work for", "set up the project folder", "write the BRD", "clients are getting access now", "the tier changed", "we won the renewal", "inherited backlog", "take over this project", or any first conversation about work that does not have a project folder yet.
---

# BA Project Intake

Intake is one sitting that produces three things: the four dials, the project folder, and the BRD. It is deliberately not the place to start analyzing requirements, because all intake is doing is framing the work so that everything downstream has something solid to read.

## Step 1. Set the four dials

Ask these four questions, or answer them from what is already known, and write the answers into `knowledgebase/01_Requirements_Source.md` under a Dials heading. Every downstream skill reads them from there and will not ask you again. They get answered once, but they are not fixed forever, and a dial that moves later has to move through a recorded change event, which ba-change covers. A project running on stale dials is a project where every skill is quietly reading the wrong rules.

1. **Security tier.** Who bears the cost of failure, and whose data does the work handle, whether that means stored, displayed, or just moved through it, since a migration extract counts as much as a database does?
   - Tier 1 covers internal users, internal data, and an internal blast radius. Access control is all that is genuinely required, and speed, accessibility and polish can be fixed when they start to hurt.
   - Tier 2 is where any client logs in, any client data is handled, or external parties bear the failure. Security and integration resilience NFRs stop being negotiable here, and the NFR catalog in ba-user-stories has the detail.
   - Tier 2 plus applies when a named compliance regime is involved or a client security review is coming. The discipline is the same as tier 2, but their numbers replace the catalog defaults before anybody sees them.
2. **Formality.** Who pays if we are wrong, and how big is the blast radius?
   - Lean means your own organization absorbs the rework, so stay light.
   - Firm means there is no contract but the stakes are real anyway, which covers a money path, a politically loaded multi team program, or an MVP attached to a deal. Recorded approvals become mandatory, while the signable spec stays on the shelf.
   - Contract means client money, a signed agreement, or an audit is depending on it. Recorded approvals are mandatory, every story carries a verification method, and ba-formal-signoff becomes available.
3. **Mandate mode.** Did we decide to do this, or were we told to?
   - Mode A, mandated, means the decision was made above the BA, and it is often tied to a deal. Do not spend weeks chasing the sponsor for success measures. Record their absence honestly and go hunting through the message trail instead, which step 3 covers.
   - Mode B, delegated, means leadership said they want the thing and handed over fragments, leaving the BA to design the logic. Keep a decisions log from day one here, because nobody else will be able to reconstruct the reasoning later, and that includes the BA a year from now.
4. **Handoff.** Who builds it? The options are self build, engineer, vendor builds, buy a product, or inherited, where the thing already exists and the work is acceptance rather than construction. Choosing engineer means the story workbook carries the two estimate columns and round trips through them. Vendor builds tends to push the formality dial toward Contract, whereas buying a product does not do that on its own. "Undecided, decision by [date]" is a perfectly legitimate answer when build versus buy is the whole engagement question, so record it that way and re run the dependent settings on the day it lands. Choosing buy a product routes the evaluation over to ba-vendor-selection.

   Handoff is the one dial that can differ epic by epic, since buying the core product and building the integration layer around it is how most product selections actually end up. When that happens, write it under the Dials heading in 01 as a short epic to value table keyed to the epic list in 01, and the renderings follow from there: the vendor RFP covers the bought epics, the estimate round trip covers the built ones, and rows outside the engineer epics carry N/A in the estimate columns rather than a blank. The other three dials stay project wide, and where they would otherwise differ the strictest value governs, so a single client facing epic is enough to make the whole project tier 2.

## Step 2. Create the project folder

This shape has held up in practice, so use it as it stands. The folder `assets/project/` in this repo is exactly it, ready to copy and rename.

```
project-name/
├── README.md                                what this is, status, who is who, how to read the folder
├── knowledgebase/
│   ├── 01_Requirements_Source.md            the stable foundation: problem, dials, scope, stakeholders, data sources, epics, roles
│   ├── 02_Conventions.md                    story ID format, story form, AC format, phases, MoSCoW, status lifecycle, declared registers and windows
│   ├── 03_Backlog_and_Tracking.md           where stories live, the field set, the transcript workflow
│   └── 04_Worklog.md                        running log of what changed and when, plus the decisions log
├── sources/                                 raw transcripts, notes, exported email threads. Git ignored if sensitive.
├── prototype/                               the clickable HTML mock, when one exists
└── <project>_User_Stories.xlsx              the handoff workbook. Lives here or in the document store, README says which.
```

A few rules keep the folder healthy:

- Each fact lives in exactly one place. 01 holds why and what, the workbook holds the build detail, and 04 holds history. Nothing restates anything.
- 01 should rarely change. Meeting level detail belongs in sources and in the workbook and never in 01, so only touch 01 for genuine fundamentals such as a new owner, a major scope change, a new data source, a new phase, or a dial that has moved.
- People are referred to by role wherever possible. Real names are allowed in private repos, but roles are what survive turnover.
- Lean and tier 1 together are allowed to shrink the ceremony, so 02 and 03 can collapse into the README until the project earns them back. 01 and 04 always stay separate, because why and history are the two files that disputes actually need.

## Step 3. Write the BRD into 01

This runs to a few pages rather than forty, and unless the formality dial says otherwise it is the BA's own thinking space. The sections are:

- **Business problem.** What hurts today, written in the words of the people it hurts, with no solution language in it.
- **How this work arrived.** Mode A or B, who asked for it, and what it is attached to, in one honest paragraph. This is the section textbooks forget about and disputes remember.
- **Success measures.** Numbers, if any exist. If nobody ever defined any, write exactly that: "Success measures: not defined at initiation. Project mandated to support [deal or directive]. [ASSUMPTION] Success = delivery of agreed scope by [date]." Recording the absence is not a form of pushback, it is the record that ends up protecting everyone. In Mode B the BA proposes the numbers and brings them along for confirmation, which is the same posture as with NFRs, where you arrive with a proposal rather than a question.
- **Scope, in.** The epics or capability areas.
- **Scope, out.** Explicit, with one line of reasoning against each, so that none of it gets re litigated later. Every scope dispute you will ever have walks in through a missing out of scope list.
- **Stakeholders.** The roles, and what each one actually decides. Include the engineer and the approver. A small real cast is worth more than a page of stakeholder theory. When approval is joint, which happens across two organizations or a shared program, name every approving role now, because finding out about the second approver on the day of signoff is what turns a signoff into another two weeks.
- **Data sources and systems touched.** Every external system the work depends on, since each one of them is a future integration resilience question waiting to happen.
- **Roles.** The user roles that the workbook's User Role column draws from. These are distinct from stakeholders, in that they are who uses the thing rather than who decides about it.
- **Constraints.** Budget posture, deadline, licensing, and anything else that is already fixed.

In Mode A, before you write "unknown" against the why, go and check the message trail. The business case usually does exist, scattered across a chat thread, a meeting invite, or the deal paperwork, and reconstructing it from there is legitimate BA work that beats an awkward question upward. On an external engagement there is no internal trail to hunt through, because the client's reasoning has to be elicited rather than excavated, and asking about it is billable work rather than an imposition.

Watch out for the solution as requirement trap. When somebody says "we need a dashboard" they have handed you a proposed solution, and the requirement underneath it is usually a decision that somebody currently cannot make. Dig one layer down before accepting any stated need, and then record both layers.

## When a dial moves

Clients arrive on what was an internal tool, a contract attaches itself to what was a favour, a compliance regime lands, or build turns into buy. The change event itself belongs to ba-change, and what follows here is what intake owes afterward.

- **Dials move in packs.** When one of them moves, re answer the other three in the same sitting. An internal tool that gets sold to two clients moves the tier, and it usually drags formality to Contract as well, where the formality consequences turn out to be the larger half of the bill.
- **A tier or formality upshift is the expensive one.** Re run the review pass at the new tier across every story that is not Deprecated or Out of Scope, including the ones already marked Done, because the bar has moved underneath work that already shipped. The one exception is a tier 2 to tier 2 plus move, which changes the numbers rather than the categories, so it only needs a pass over the NFR rows and whatever cites them. A formality upshift is always the full pass, because verification per story is by definition per story. Whatever fails becomes new rows. Security and integration resilience gaps on a tier 2 project become rows prioritized like any other work rather than debt records, since those two categories are not deferrable.
- **Ceremony that was collapsed comes back.** Lean and tier 1 may have folded 02 and 03 into the README, and an upshift unfolds them again.
- **Approval debt gets recorded late rather than backdated.** Work built from Draft tickets under Lean is legitimate history and should not be rewritten. Hold one session over the affected stories and record the approvals with today's date, noting on them that they cover work which was already built.
- **Price it, and price it at somebody.** The change event's impact line is the artifact here, and the addressee is whoever sold or agreed the change rather than the project's own file. A tier jump that arrives as good news, because we won the renewal, and then lands as unpriced remediation is how a win turns into unpaid overtime.

## Landing in flight

Not every project starts at the start. Landing in the middle of one, whether that is an inherited backlog, a disputed build, or an outright rescue, runs the same intake with the direction reversed, in that the folder gets created around what already exists and evidence takes the place of elicitation.

- Set the dials from evidence rather than from questions. The contract, the tracker history, and the message trail will usually answer all four between them.
- Inherited documents are sources to mine, not BRDs to keep. A ninety page legacy spec goes into sources/ and gets mined into 01 and the story store with provenance attached per claim, along the lines of "per legacy BRD §4.2".
- Audit the existing backlog using the review pass from ba-user-stories, meaning the failure path check, the no blanks rule, and the vague word scan, before you write anything new. Whatever fails that sweep is your work list.
- When the client mandates their own tools, treat the four knowledgebase files as roles rather than filenames, and map 01 to 04 onto whatever holds why, conventions, backlog, and history over there. The closed vocabularies may well be the client's own, such as WSJF or PIs, and those get declared in 02_Conventions.
- "How this work arrived" matters twice as much in a rescue, so write down who decided what before you landed, honestly, with the trail attached.

When the backlog runs to seventy tickets and the landing is a week long, the audit gets scoped rather than skipped. Audit the tickets in the current phase plus anything they depend on, and quarantine the rest behind one debt record naming the unaudited set, its owner, the authority under which you are landing without a full audit, and a revisit date, plus a marker in Assumptions on those rows reading unaudited, treat as unverified; revisit [date]. Declare it in 02_Conventions.md the way you would declare any register, and note that carrying the date on the row itself is what puts the set in front of the sweep rather than into a file nobody reads. A quarantined ticket gets audited before anyone works it, and nothing new is allowed to declare a dependency on one until that has happened. A ticket leaves quarantine the moment it is audited, at which point the marker comes off and it is struck from the named set with the date. The record closes when the set finally empties, and it blocks if its revisit date arrives first. An all or nothing audit is the rule that ends up skipped in full, and a rescue that skips it inherits the previous BA's fiction as fact.

## Other shapes of work

Everything above assumes a build. Two other shapes run the same intake and then stop earlier.

**Analysis.** This is the figure out why and what to do request, covering things like churn, a cost spike, or an opportunity. It uses the same folder minus the workbook, and the deliverable is a findings document plus an opportunity one pager rather than stories. Success measures read along the lines of "Success = [decision] can be made with confidence by [date]", because analysis succeeds when a decision becomes possible rather than when scope ships. Stop before stories, since writing a backlog for a build that nobody has decided on is how analysis quietly turns into commitment. The findings run on exactly the same epistemics as everything else, with facts unmarked, inferences recorded as assumptions with owners, and provenance per claim, which here means data lineage. If a build does come out the other side of it, that build starts its own intake with the findings as a source.

When the deadline lands before the verification does, because the data owner is away or the source cannot be confirmed in time, the findings ship as a draft rather than not shipping at all, and the epistemic marks you already have are the caveats. Two things keep that honest. The document stays marked draft until the owner confirms, and it opens with what could not be verified, who owns each item, and when it will be resolved. Never soften the marks to make the draft read more smoothly, and keep the caveats at the front, because an unverified claim that reads like a finding is precisely the one that gets quoted back in the decision.

**Experiment.** This is a hypothesis to test rather than a feature to ship. The BRD slims down to an experiment brief in 01 covering the hypothesis, the primary metric, the guardrail metrics, the segment exclusions, which are the scope out list wearing experiment clothes, the sample size and duration, and the rollback rule. Stories exist only for the build tasks of the variant, and the design parameters live in the brief rather than in story rows, because "As a visitor, I want to see two tiers" is fiction and nobody has ever wanted a variant. Run it Lean with the collapsed folder. The guardrail metrics and the rollback rule both come out of the usual question, which is what the worst thing that could happen here would be.

## Done when

The dials are written into 01, the folder exists, every BRD section has either content or an honest [OPEN] against it, and the README explains how to read the folder. From there you move to ba-user-stories for a build, ba-process-mapping for a process, or straight into the findings work itself for analysis.
