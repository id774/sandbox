// leitner.js: The Leitner system with five boxes
//
// Description:
// Walk a few flashcards through the Leitner system: a correct answer moves a
// card up one box, an incorrect answer sends it back to box 1, and each box
// has its own review interval. The sample also picks the cards that are due on
// a given day. Days are plain integers, so the output never depends on the
// clock.
//
// Author: id774 (More info: https://id774.net)
// Source Code: https://github.com/id774/sandbox
// License: The GPL version 3, or LGPL version 3 (Dual License).
// Contact: idnanashi@gmail.com
//
// Usage:
//     node leitner.js
//
// Requirements:
// - Node.js 20 or later
// - No third-party package is required
//
// Notes:
// - The intervals below are values this sample picked so that the transitions
//   are easy to follow. They are not a standard for the Leitner system.

const assert = require("node:assert/strict");

const MAX_BOX = 5;

// Review interval in days, indexed by box number (index 0 is unused).
const INTERVAL_DAYS = [0, 1, 2, 4, 8, 16];

function review(card, day, correct) {
  const box = correct ? Math.min(card.box + 1, MAX_BOX) : 1;
  return { id: card.id, box, dueDay: day + INTERVAL_DAYS[box] };
}

function isDue(card, day) {
  return card.dueDay <= day;
}

function selectDue(cards, day) {
  return cards.filter((card) => isDue(card, day));
}

function show(before, day, correct, after) {
  console.log(
    `${after.id}: day ${day}, ${correct ? "correct" : "incorrect"}, ` +
      `box ${before.box} -> ${after.box}, next due day ${after.dueDay}`,
  );
}

function reviewAndShow(card, day, correct) {
  const after = review(card, day, correct);
  show(card, day, correct, after);
  return after;
}

// 1. A new card in box 1 is answered correctly on day 0.
let card = { id: "card-a", box: 1, dueDay: 0 };
card = reviewAndShow(card, 0, true);
assert.deepEqual(card, { id: "card-a", box: 2, dueDay: 2 });

// 2. The same card is answered correctly again on its due day.
card = reviewAndShow(card, 2, true);
assert.deepEqual(card, { id: "card-a", box: 3, dueDay: 6 });

// 3. The same card is answered incorrectly on day 6 and goes back to box 1.
card = reviewAndShow(card, 6, false);
assert.deepEqual(card, { id: "card-a", box: 1, dueDay: 7 });

// 4. A card in box 5 stays in box 5 after a correct answer.
const top = reviewAndShow({ id: "card-b", box: 5, dueDay: 6 }, 6, true);
assert.deepEqual(top, { id: "card-b", box: 5, dueDay: 22 });

// 5. Pick the cards due on day 10.
const deck = [
  { id: "card-c", box: 1, dueDay: 9 },
  { id: "card-d", box: 2, dueDay: 10 },
  { id: "card-e", box: 3, dueDay: 11 },
  { id: "card-f", box: 4, dueDay: 10 },
  { id: "card-g", box: 5, dueDay: 22 },
];
const due = selectDue(deck, 10);
console.log(`due on day 10: ${due.map((c) => c.id).join(", ")}`);
assert.deepEqual(
  due.map((c) => c.id),
  ["card-c", "card-d", "card-f"],
);

// Invariants over every box.
for (let box = 1; box <= MAX_BOX; box += 1) {
  const start = { id: "x", box, dueDay: 0 };

  const right = review(start, 3, true);
  assert.equal(right.box, Math.min(box + 1, MAX_BOX));
  assert.equal(right.dueDay, 3 + INTERVAL_DAYS[right.box]);

  const wrong = review(start, 3, false);
  assert.equal(wrong.box, 1);
  assert.equal(wrong.dueDay, 3 + INTERVAL_DAYS[1]);
}
assert.equal(review({ id: "x", box: MAX_BOX, dueDay: 0 }, 0, true).box, MAX_BOX);
assert.equal(isDue({ id: "x", box: 1, dueDay: 5 }, 5), true);
assert.equal(isDue({ id: "x", box: 1, dueDay: 6 }, 5), false);

console.log("all checks passed");
