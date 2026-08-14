---
name: ba-meeting-loop
description: Turn a meeting transcript, recording notes, or walkthrough feedback into project updates without inventing anything. Use whenever a meeting happened on a BA project: a prototype walkthrough, a requirements session, a stakeholder review, an estimation call. Produces three lists (new stories, updated stories, approvals) plus knowledgebase updates, each change carrying a verbatim quote as provenance. Also covers leaving a project mid flight and coming back to it after an interruption, meaning what to write on the way out and what changed while the BA was away. Trigger on "here is the transcript", "meeting notes from", "we met about", "update the stories from this meeting", "what changed in the meeting", "catch me up", "where were we", "I have been away from this project", "I am going on leave", "pausing this project", "handing this project to another BA", "I have been pulled onto", or a transcript file landing in sources/.
---

# BA Meeting Loop

A raw transcript works perfectly well as input once the project folder exists, because the knowledgebase is what keeps it honest. The loop puts the human in control at exactly one point, which is that changes get proposed before they are applied.

## The loop

1. **File the source.** A transcript, chat thread, forum thread, email chain, or document, meaning anything decisions live inside, goes into `sources/` under a dated name. It is the evidence that everything else points back to. For async sources the verbatim quote's provenance is the message link or the section number, and when the author cannot be reached to clarify something, that gap becomes an Open Question owned by whoever represents that audience rather than a guess.
2. **Read against the knowledgebase.** Walk the transcript organized by theme or epic, taking one theme at a time and not jumping ahead. Ask clarifying questions one at a time for anything ambiguous. If the BA does not know, the BA asks the stakeholder and comes back. Never fill a gap with a plausible guess, because plausible and wrong is the expensive kind of wrong, in that it reads as right and so nobody ever goes back to review it.
3. **Propose, do not apply.** Produce a change list before touching any file at all. Every entry carries a verbatim quote from the transcript along with who said it. A decision that has no recording to quote is not lost, since you can read it back in writing and use the reply as your quote, which ba-change covers. Transcripts are messy places where people contradict themselves, say maybe, and trail off, and the quote is what separates something that was decided from something that was merely mentioned. Where there is no quote there is no change, and it goes to Open Questions instead.
4. **BA approves the list.** Accept, reject, or correct each entry.
5. **Apply.** Only at this point do any files actually change.

## The three outputs

**New stories.** These come out as paste ready rows in the full field format from ba-user-stories, with IDs continuing from the highest one in the backlog, Status set to Draft and Approved By left blank.

**Updated stories.** A Story ID plus the exact fields that change. The rule that keeps history honest here is that an answered open question moves rather than simply being deleted. The answer lands in Description or Acceptance Criteria with provenance attached, along the lines of "per the MS Portal Owner, 12 Aug 2026", and the question then comes out of Open Questions. Deleting it without moving it destroys the record of whether the thing was decided or assumed.

**Approvals.** This is the list everyone forgets. It holds the story IDs the stakeholder confirmed in this meeting, with Status moving to Approved and Approved By filled in with a role and a date. While producing it, ask explicitly what they actually said yes to, because a yes given in a meeting that never reaches the workbook does not exist once scope is being disputed. Be careful to distinguish what was approved, since the scope, a specific story, the prototype, and the go ahead to build are four quite different yeses. When more than one party has to say yes, which happens across two organizations or a joint program, Approved By carries every approving role with its own date and the story is not Approved until the last one lands. Recording one side's yes as though it were the project's yes is how a political program manufactures a dispute out of nothing.

## Where updates land

| What the meeting produced | Destination |
|---|---|
| Why, outcome, success measure | BRD section of 01 |
| New epic, or something ruled out | 01 scope, in or out |
| How a feature behaves | That story's Description or Acceptance Criteria |
| A new unknown | That story's Open Questions, with an owner |
| An answered unknown | Moves: answer into Description or AC with provenance, question out |
| New constraint or reliance | Assumptions or Dependencies on the story, or 01 constraints if project wide |
| A research or analysis finding | The findings document, when the deliverable is analysis |
| Feedback on a process document | That process document's steps or exceptions |
| Evaluation evidence (a vendor demo answer, a score) | The scoring record, with the quote as provenance |
| A decision and its reasoning | Decisions log in 04_Worklog.md |
| A directive that reprioritizes, cuts, or reverses scope | One change event in the decisions log, with rows citing it, per ba-change |
| Anything else that changed | One line in 04_Worklog.md |

Only touch 01_Requirements_Source.md for genuine fundamentals, meaning a new owner, a major scope addition, a primary data source change, a new phase, or a dial that has moved. Meeting level detail belongs in sources and in the workbook, and keeping it out of 01 is what leaves 01 stable enough to trust.

## Leaving and coming back to a project

An interruption is the normal case rather than the exception, since a bid takes the week, another project catches fire, or leave happens. The method quietly assumes a BA who never leaves, and the cost of that assumption gets paid on the morning of the return, reconstructing state from four places at once.

Leaving costs one line and saves that whole reconstruction. On the way out, write a dated pause into 04 along the lines of "paused [date]; in flight: [IDs]; waiting on: [who, for what]", so that the return anchors on something written rather than on what the BA can remember two weeks later. Then hand the open approval chases to somebody named, or accept in writing that they stall until the BA is back, because an approval nobody is chasing is the one that has quietly aged six days by the time anyone looks at it.

On return, before touching anything, spend five minutes on four questions and answer them in around ten lines. Any longer than that and it stops being something anyone reads.

- What does the record say changed? That means the decisions log and worklog in 04 since the pause line.
- What is stale? Run the validator over the workbook for debt records past their revisit date and anything else blocking. Once tickets exist, add the tracker filtered to what changed since the pause, since updated since is one filter and it is read for status only.
- What arrived and was never filed? New files in sources/ that no change list has processed yet, and, the part no tool can see, answers that came back by email or chat while the BA was away. Those are decisions sitting in an inbox with no provenance until somebody files them. List them here, since filing them is a run of the loop above rather than part of the brief.
- What is owed to somebody else today? Open questions whose owner is waiting on the BA, and approvals the BA is waiting on.

Then work the list. What this deliberately does not do is judge whether a directive that settled while the BA was away got applied correctly, because that is reading rather than listing.

## Prototype walkthroughs

The prototype is the best failure path elicitation tool available, because people cannot imagine what breaks in the abstract but will happily put a screen in front of them and say "wait, what happens if I click that twice?" Walk it screen by screen. On each screen, beyond confirming that you both understand it the same way, run the three questions from ba-user-stories: the worst thing that could happen, how they find out today when this goes wrong, and whether anyone has ever complained. Feed the answers straight into acceptance criteria through this loop.

When there is nothing to click, which is the case for an API, an integration, or a data pipeline, the walkthrough runs on a substitute such as a sequence diagram, a vendor sandbox, or a pilot run with one friendly user. The questions stay exactly the same, and the artifact is simply whatever makes the behaviour concrete enough to break.
