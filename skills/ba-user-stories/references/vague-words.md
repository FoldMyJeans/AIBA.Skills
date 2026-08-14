# Vague words

These are the words that pass a review and then fail a build, because every reader quietly supplies their own number for them. This list is the one place they live, and the review pass in ba-user-stories, the client requirement scan in ba-bid-response, and `scripts/validate_workbook.py` all read them from here.

Each one has to become a number, a named control, an eval threshold, or an [OPEN] with an owner against it. When they turn up in a client's own requirements they are pricing risk, and the answer carries an assumption naming exactly what was priced.

```
fast
easy
secure
user friendly
user-friendly
intuitive
flexible
appropriately
as appropriate
accurate
relevant
grounded
helpful
seamless
robust
scalable
performant
best practice
industry standard
minimal effort
```

The list is deliberately short. Words that are usually vague but frequently literal, such as simple, reliable, efficient and modern, are left out of it, because a scan that fires on "a simple form with three fields" teaches its reader to ignore it, and a guardrail that fires constantly gets ignored permanently.

There are two exceptions, and the reader applies them rather than the scan. A word that carries its own number is already answered, so "secure: TLS 1.2 in transit" is a control rather than a vibe. And a word sitting inside a verbatim quote stays exactly as it was spoken, because provenance is not editable, so "per the sponsor, it needs to be fast" is evidence of what somebody said and the requirement it implies gets written elsewhere as a number. The scan itself is cruder than either exception. On a story it reads the User Story and Acceptance Criteria and drops a hit when a number immediately follows the word or the row carries an [OPEN], and on a client's requirements it suppresses nothing at all. It will still flag words that both exceptions cover, including "secure: TLS 1.2", because there the number does not immediately follow. That is the trade you get for it never blocking anything.
