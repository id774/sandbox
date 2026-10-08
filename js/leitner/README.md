# Leitner system

A small, deterministic sample of the Leitner system, a flashcard scheme in which
cards move between boxes and each box is reviewed at its own interval.

## Sample

`leitner.js` walks a few cards through five boxes, numbered 1 to 5.

- A correct answer moves the card up one box. Box 5 is the top, so a correct
  answer there keeps the card in box 5.
- An incorrect answer sends the card back to box 1.
- After a review, the card's next due day is the review day plus the interval of
  the box it landed in.
- A card is due when `due day <= current day`.

The intervals are values this sample picked so that the transitions are easy to
follow. They are not a standard for the Leitner system.

| Box | Interval |
| ---: | ---: |
| 1 | 1 day |
| 2 | 2 days |
| 3 | 4 days |
| 4 | 8 days |
| 5 | 16 days |

Days are plain integers, not calendar dates, and the sample never reads the
clock, so every run prints the same output. It uses no random numbers and keeps
all state in memory.

The program shows one card going through correct, correct, and incorrect
reviews, a card in box 5 answered correctly, and the selection of the cards due
on one fixed day. For each review it prints the card, the review day, the
result, the box change, and the next due day.

The program checks with `node:assert` that:

- a correct review advances one box;
- box 5 does not advance beyond 5;
- an incorrect review resets the card to box 1;
- the next due day is calculated from the resulting box;
- the due selection includes cards whose due day equals the current day;
- the due selection excludes cards whose due day is later than the current day.

A failed check ends the program with a non-zero exit status.

## Requirements

Node.js 20 or later. There is no third-party dependency.

## Run

    node leitner.js
