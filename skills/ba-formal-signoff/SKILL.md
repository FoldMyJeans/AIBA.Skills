---
name: ba-formal-signoff
description: Generate a formal, signable requirements specification from an existing story workbook, for engagements where being wrong costs contract money. Use when a client contract, fixed price engagement, audit, or executive mandate requires a signed off spec, or when the formality dial was set to Contract at intake. Trigger on "formal spec", "sign off document", "the client needs to sign", "SRS", "requirements document for the contract", "something they can approve formally".
---

# BA Formal Sign Off

This has not been exercised on a live contract yet, so harden it the first time one runs through. Note that a quarantined set from a rescue appears in the assumptions section by name along with its revisit date, because what was never audited is exactly the thing the client needs to see before signing anything.

The spec is a rendering of the project's source of truth, meaning the story workbook plus the process document where one exists, rather than a second document in its own right. Authoring a parallel SRS by hand creates two versions of the truth that then drift apart, whereas generating it keeps the source single and makes the spec reproducible on demand. If the spec needs to change, change the source and regenerate it. A signable process, such as a policy or a compliance procedure, renders exactly the same way, with the numbered steps becoming the requirements and the document controls and signature block applying unchanged.

## When this fires

It fires when the formality dial says Contract, meaning client money, a signed agreement, a fixed price, or an audit is depending on the requirements being right. Internal work moving at speed never needs this, and running it there is bureaucracy for its own sake.

## What the workbook already provides

Numbered requirements with stable IDs, a statement of each capability, acceptance criteria, priority, dependencies, assumptions, and open questions. That is already most of a spec. Four things are missing, and adding them is what this skill does.

## The four additions

1. **Scope boundary.** In scope and out of scope, lifted straight from 01_Requirements_Source.md and stated as contract language, covering what is included, what is explicitly excluded, and the rule for anything unlisted, which is that unlisted means excluded.
2. **Verification method per requirement.** For each story, how acceptance is going to be demonstrated, whether by test, demonstration, inspection, or analysis. The acceptance criteria usually imply it already, and the spec states it outright. Any story where done is arguable gets this made explicit before signing, because arguable after signing is what costs money.
3. **Change control clause.** What happens when scope moves after signature, meaning a change request in writing, an assessment of impact on hours and dates, and both parties approving before work proceeds. Reference the decisions log as the register of record.
4. **Signature block.** Who signs for each side, with role, name and date, and include the statement being signed, which reads that the requirements in this document are complete and correct as the basis for build and acceptance.

The spec stops at requirements. When a reviewer starts wanting architecture, data flows, or a security design, that document belongs to engineering, and the spec references it rather than absorbing it, because a spec containing design ends up signed by people approving things they never decided.

## Language conversion

MoSCoW maps onto normative language on the way out, so Must becomes shall, Should becomes should, and Could becomes may. Won't items appear in the out of scope list. Avoid will and must in normative statements, because shall, should and may carry defined obligation levels in contractual review while the others blur them.

Convert story phrasing into system phrasing where the audience expects it, so "As a Client User, I want to submit a request" renders as "The system shall allow a Client User to submit a request", with the acceptance criteria sitting underneath as the verifiable conditions.

## Document controls

The spec carries a document ID, version, date, author, status from Draft, In Review, Approved or Baselined, plus reviewers, approvers and a change log. Version stays at 0.x while it is in draft, hits 1.0 at first signature, and the major digit increments only on an approved scope change.

## Before it goes out

- Every open question on an in scope story is either resolved or explicitly listed in the spec as an agreed exclusion or assumption. A signed document with silent unknowns inside it is a dispute with a countdown attached.
- No in scope requirement rests on a proceed at risk approval, which ba-change covers. Either the approval gets obtained before signature, or the requirement moves into the assumptions section where the client can see what was never confirmed.
- Every assumption appears in an Assumptions section the client actually sees, since unstated assumptions turn into unpaid scope after award.
- Somebody who was not involved reads it cold and marks every place they had a question. Each mark is a defect to fix before signature, because the client's reviewer is going to find exactly the same ones.
