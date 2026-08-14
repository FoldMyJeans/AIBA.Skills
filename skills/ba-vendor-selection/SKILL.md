---
name: ba-vendor-selection
description: Select a product or vendor instead of building, running requirements to vendor RFP to demo scripts to a weighted scoring matrix to a recommendation. Use when the engagement question is which CRM, ERP, ticketing, or SaaS tool to buy, when build versus buy is undecided, when part of the scope will be bought and the rest built, or when a client needs a defensible product recommendation. Trigger on "vendor selection", "choose a CRM", "which tool should we buy", "build vs buy", "buy the core and build around it", "hybrid buy and build", "RFP to vendors", "demo scripts", "scoring matrix", "TCO comparison", "shortlist", or any request to evaluate products against requirements rather than build them.
---

# BA Vendor Selection

The requirements half of a selection runs on the ordinary pipeline, meaning intake, the dials with handoff set to buy a product, or buy a product for some epics, or undecided with a decision date, and a workbook written solution agnostic, since "As a [role], I want [capability]" serves build and buy equally well without any rewriting. The evaluation half is what this skill covers.

## The RFP rendering

The workbook renders into a vendor RFP by dropping the build only fields, which are the Status values past In Review, Estimated Hours and Estimate Notes, and keeping ID, story, acceptance criteria, MoSCoW, dependencies and assumptions. When the handoff dial differs by epic, the RFP covers only the bought epics. Vendors answer per row with met out of the box, met with configuration, met with customization, roadmap, or not met, and that is a closed set, because "yes" from a salesperson is not a value you can score.  NFR rows go in as questions using the catalog's stakeholder phrasing.

Read the acceptance criteria properly before they go out. Criteria written while the project was still building tend to carry internal design inside them, such as a named service, a retry count, or a queue, and as RFP lines those ask vendors to answer for an architecture that is now theirs to choose. Restate them as the behaviour the business actually needs, along the lines of "the request is never silently lost when the billing system is unavailable", and let the vendor answer how they do it. Whatever survives that rewrite was a requirement, and whatever does not was build design wearing a requirement's clothes. Skipping this pass costs you twice, because vendors score badly on rows that were never requirements in the first place, and the ones who answer honestly lose out to the ones who just say yes.

## Demo scripts

Acceptance criteria convert into demo scripts almost mechanically, in that each Given / When / Then becomes "show us [Given context], do [When action], we expect [Then]". Scripts go out ahead of the session, run in workbook order, and get scored live. An unscripted demo is really a product tour, where the vendor shows you their strengths and the gaps stay comfortably dark.

## The scoring matrix

One row per requirement, one column per vendor, and a weight per row, with Must at 3, Should at 2 and Could at 1 unless the client sets their own. Scores run 0 to 2 per cell for not met, partial and met. Every cell that is not obvious carries provenance, along the lines of "per the vendor SE, premium tier required, 14 Aug", because the losing vendor's account team is going to ask why, and "we scored it in the room" is not an answer that holds up. Demo sessions run through the meeting loop like any other meeting, with quotes going in and scores coming out.

Weighted totals rank the vendors, they do not decide between them. What the matrix is really for is surfacing the two or three requirements where vendors genuinely differ, and the recommendation argues from those rather than from a 3 percent gap in the totals.

## TCO, in lines rather than models

The lines are licenses, priced per user per month at the tier actually needed, implementation from either a vendor quote or a partner estimate, migration, integrations, training, and the run cost delta. Use a three year horizon. Every line has either a source or an [ASSUMPTION] against it, because a TCO without provenance is just a number the CFO will re derive in the meeting.

## The recommendation

One page, shaped around the decision: the recommendation itself in the first sentence, the two or three differentiating requirements with their scores, the TCO comparison, the risks of the recommended path with owners against them, and what the reader has to do, whether that is approve, fund, or name the implementation owner. The same rule applies here as to the one pager, in that a recommendation which asks for nothing changes nothing.

Approvals get recorded at the shortlist gate and again at the final decision, with a role and a date, exactly as they are on stories. A selection nobody signed re opens itself the day the license invoice lands.
