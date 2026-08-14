---
name: ba-bid-response
description: Respond to an RFP, RFI, or tender as the bidder, before any project exists. Use for writing the BA method section of a proposal, building a sample artifact pack, and answering a client's written requirements line by line in a compliance matrix. Trigger on "RFP response", "RFI", "tender", "bid", "proposal due", "compliance matrix", "respond to these requirements", "the client sent 40 requirements", or any pre sales request to demonstrate or apply the BA method before a contract is signed.
---

# BA Bid Response

A bid is not a project. There is no folder, no BRD, and no elicitation loop until award, because the client's document is the only stakeholder in the room and the deadline is measured in hours rather than weeks. Two deliverables matter here, and the client scores both of them.

## What to run and what to skip

Run the dials as framing, since they answer in minutes from the RFP itself, giving you tier, formality Contract, mode A and handoff, and they sharpen the proposal considerably. Skip the folder, the BRD, and the meeting loop until award. If the bid wins, intake runs properly on day one and the bid materials all go into sources/.

## Deliverable 1: the method section and sample pack

The README of this repo is the quarry for this, since the pipeline diagram, the dials table and the principles together make a genuinely differentiated method narrative. Most bidders promise requirements workshops, and very few can show the machinery behind them. A sample workbook page, genericized from a past project with roles renamed, systems generalized and numbers rounded, demonstrates more than a page of prose ever will. Build the sample pack once and then reuse it on every bid.

## Deliverable 2: the compliance matrix

The client's requirement IDs are law. They are a declared register in the sense ba-user-stories gives that term, declared in the bid materials themselves since no project folder exists yet, and the matrix echoes their numbering exactly, so REQ-014 stays REQ-014, because the evaluator is reading your answers against their own document. Do not renumber anything and do not merge rows.

One row per client requirement, with four columns:

- **Response.** Comply, Partial, Alternative, or Cannot. It is a closed set, because evaluators filter on it.
- **How.** One or two sentences on how it is met, written in their vocabulary rather than the method's.
- **Assumption.** What the answer is taking as true, stated per line. Unstated assumptions turn into unpaid scope after award, and every Partial and Alternative carries at least one.
- **Reference.** Where in the proposal the full answer lives, if it lives anywhere.

The file `assets/compliance_matrix_template.xlsx` is those four columns sitting alongside the client's requirement ID and text, with the response set wired up as a dropdown. Running `validate_workbook.py --matrix` checks for the deadline's usual casualties, meaning a Response that is outside the closed set or missing entirely, a duplicated or merged requirement row, and any Partial or Alternative that shipped without its assumption.

Run the vague word scan, using [the list](../ba-user-stories/references/vague-words.md), across the client's requirements as you answer them, because "intuitive", "performant" and "secure" sitting in their text are pricing risks sitting in yours. Each one gets an assumption naming what the answer actually priced, along the lines of "assumes WCAG 2.2 AA scope; formal audit excluded".

The [NFR catalog](../ba-user-stories/references/nfr-catalog.md) will answer most non functional lines without any research at all, so quote the default, mark it as the proposed baseline, and note that contract figures supersede it.

## Rules that survive the deadline

- Never claim Comply on a line the delivery team has not seen. A Comply that turns into a Partial after award is a dispute that arrives with the client's own evidence attached to it.
- Every Cannot should be honest and short. Evaluators forgive gaps readily, and they do not forgive discovering one later.
- The matrix is a commitment register that the delivery BA inherits, so on award each Partial and Alternative row becomes an Open Question or an Assumption on a story, with the matrix standing as its provenance.
