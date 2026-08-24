"""Check that the field set documented in ba-user-stories still matches the code.

The workbook vocabularies live in validate_workbook.py, and make_templates.py imports them,
so the templates and the validator cannot drift apart. The field table in the ba-user-stories
skill is the third copy, and it is the one a BA or an AI actually reads. This ties it to the
same source, so a field added to FIELDS cannot leave the documented table quietly describing
a workbook that no longer exists.

Run: python scripts/check_doc_contract.py
"""
import re
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
from validate_workbook import CLOSED, FIELDS  # noqa: E402

SKILL = (Path(__file__).resolve().parent.parent
         / "skills" / "ba-user-stories" / "SKILL.md")

ROW = re.compile(r"^\|\s*(\d+)\s*\|\s*([^|]+?)\s*\|", re.M)


def documented_fields(text):
    """Field names from the numbered table, in declared order."""
    rows = ROW.findall(text)
    return [name for _, name in sorted(rows, key=lambda r: int(r[0]))]


def main():
    text = SKILL.read_text(encoding="utf-8")
    doc = documented_fields(text)
    problems = []

    # The engineer columns are declared as extras, so the canonical set is the leading slice.
    if doc[:len(FIELDS)] != FIELDS:
        problems.append("the field table does not match FIELDS")
        problems.append("  code: " + ", ".join(FIELDS))
        problems.append("  doc:  " + ", ".join(doc[:len(FIELDS)]))

    for field, values in CLOSED.items():
        row = next((r for r in text.splitlines()
                    if re.match(r"^\|\s*\d+\s*\|\s*" + re.escape(field) + r"\s*\|", r)), None)
        if row is None:
            problems.append("closed set " + repr(field) + " has no row in the field table")
            continue
        missing = [v for v in values if v not in row]
        if missing:
            problems.append(repr(field) + " row does not name " + ", ".join(missing))

    if problems:
        print("FAIL. the documented field set and the code disagree:")
        for p in problems:
            print("  " + p)
        return 1
    print("doc contract ok, the field table agrees with FIELDS and the closed sets")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
