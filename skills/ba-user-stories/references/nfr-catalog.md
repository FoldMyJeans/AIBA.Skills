# NFR Catalog

Twelve categories. The defaults here are starting proposals rather than mandates, so bring them to the stakeholder as numbers they can accept or override. They are calibrated for small team, internal and portal scale work, and at enterprise or platform scale they are simply the wrong numbers rather than a reasonable starting point. On Contract formality, numbers taken from the contract, the SLA, or the organization's own published commitments replace these defaults before any stakeholder lays eyes on them, because proposing 99.5 percent to a client whose contract already says 99.9 costs credibility that does not come back. Categories 3 and 4 are non negotiable on tier 2 projects, meaning any project where a client logs in or client data is stored. Everything else scales with the tier and the formality dial.

The standards referenced below are the Core Web Vitals thresholds, which Google measures at the 75th percentile of real users, and WCAG 2.2 Level AA. Verify the current values whenever a contract cites them, since they move slowly but they do move.

| # | Category | Default target | Stakeholder phrasing |
|---|---|---|---|
| 1 | Performance | Page substantially visible in 2.5 s, response to a click within 200 ms, no content jumping while loading. (Core Web Vitals: LCP 2.5 s, INP 200 ms, CLS 0.1, at p75.) | "Pages load in about two and a half seconds. Fast enough, or is this a speed critical workflow?" |
| 2 | Availability | 99.5 percent during business hours. Planned maintenance announced 5 business days ahead. | "If it is down for an hour on a Tuesday, what actually happens?" |
| 3 | Security | SSO for internal users. MFA or one time emailed code for external users. TLS in transit, encrypted at rest. Idle timeout 60 minutes. Lockout after 5 failed attempts. Where more than one client's data sits in one system, every read and write is filtered by tenant at the point the data is fetched rather than in the interface, enforced in one shared place rather than repeated in every query, and a standing test tries to read another client's row using a real client login and fails. That filter has to cover the jobs nobody is watching as well, because a scheduled export or an emailed report running with no user context is the leak that reaches somebody's inbox. Rate limits go on login, password reset, and any endpoint a client's own script can call: start at 5 attempts per minute on the credential paths and 60 requests per minute per client elsewhere. | "Any client contract or audit that sets a stricter bar than our default?" and, the moment a second client exists, "what stops one client seeing the other's data?" |
| 4 | Integration resilience | Every external call has a timeout, a retry, and a visible failure message. Never fail silently. On critical paths, define exactly what the user sees when the other system is down. | "When the ticketing system is unreachable and a client submits a critical incident, what should they see?" |
| 5 | Capacity | Sized for 2x expected peak in year one. | "How many people use this, and how fast is that number growing?" |
| 6 | Usability | Primary task reachable in 3 clicks from landing. | "What is the one thing users will do most often here?" |
| 7 | Accessibility | WCAG 2.2 Level AA for anything client facing. On internal tools, fix it when somebody needs it. On an MVP clock, AA can be deferred as an accepted risk with a recorded approval and a revisit date, and it goes in as an NFR row at Status Deferred so that it becomes a debt record the sweep can see rather than a row that quietly disappears. | "Any client with an accessibility clause in their contract?" |
| 8 | Compatibility | Last 2 versions of evergreen browsers. Responsive down to 375 px if phones are plausible. | "Will anyone use this on a phone, or is it desktop only?" |
| 9 | Data retention | Portal or app stores nothing beyond what the source system keeps, so retention follows the source. When the deliverable is itself the record, such as an audit log or an export, retention becomes a requirement set by the contract or the regime rather than something inherited. | "How long must this data be kept, and who says so?" |
| 10 | Maintainability | The build is documented well enough that a different engineer could take it over. Config over hardcoding for values that will change. | Internal question for the engineer, not the stakeholder. |
| 11 | Data integrity and auditability | On any path that moves money or writes a record of record: writes are idempotent, so a retry never double charges or double books, totals reconcile against the source with a stated tolerance, and every change to a priced or approved figure leaves a who, when and what trail. | "If this number were challenged in three months, could we show where it came from?" |
| 12 | AI features | Model vendor data handling gets stated before client data flows out, covering retention, training use, and the DPA. Output quality carries an eval set and a threshold, which ba-user-stories covers. Generation latency and cost per call both have targets. Prompt injection is a named failure path on anything reading untrusted input. | "This sends your data to the model vendor, so is there a contract clause about where client data may go?" |

Category 4 is the house addition. It does not appear in the standard textbook lists, and it is here because nearly everything built in practice reads from or writes to another system, whether that is ticketing, a document store, or vendor feeds. The recurring failure mode is not slow pages, it is the other system going down and the app going quiet about it.

## Glossary, plain words

- **LCP** (Largest Contentful Paint): how long it takes until the biggest thing on the page shows up. A blank Reports page for four seconds is bad LCP.
- **INP** (Interaction to Next Paint): how long passes between clicking and something visibly happening. A Submit button that does nothing for a second gets clicked twice, and then two tickets get filed.
- **CLS** (Cumulative Layout Shift): content jumping around while the page loads, so the user ends up clicking the wrong thing.
- **p75**: 75 percent of users get this experience or better. Averages hide the people who are having a terrible time.
- **TLS**: the encryption behind https, which is the padlock.
- **SSO** (Single Sign On): logging in once with the work account.
- **MFA** (Multi Factor Authentication): a password plus a second proof, usually a code.
- **Tenant isolation**: one system holding several clients' data, with each client able to reach only their own. The failure looks like a client seeing a row that is not theirs, and it is usually a missing filter rather than a broken login.
- **Rate limit**: a cap on how often one caller may hit something, so that one client's runaway script does not take the service down for everybody else.
- **WCAG** (Web Content Accessibility Guidelines): the standard covering screen readers, keyboard only use, and low vision. AA is the level that contracts tend to require.
- **DPA** (Data Processing Agreement): the contract clause saying what a vendor is allowed to do with data you send it.
- **Eval set / golden set**: a fixed collection of real examples that an AI feature gets scored against, so that quality comes out as a number rather than a vibe.
