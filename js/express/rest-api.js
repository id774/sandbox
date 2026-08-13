// A CRUD resource on a Router. Run with: node rest-api.js
//
//   curl localhost:3000/notes
//   curl -X POST localhost:3000/notes -H 'content-type: application/json' -d '{"text":"hi"}'
//   curl -X PATCH localhost:3000/notes/1 -H 'content-type: application/json' -d '{"done":true}'

import express from 'express';

const notes = new Map([[1, { id: 1, text: 'first note', done: false }]]);
let nextId = 2;

const router = express.Router();

// Runs for every route in this router carrying an :id, so each handler below
// can assume req.note exists.
router.param('id', (req, res, next, id) => {
  const note = notes.get(Number(id));
  if (!note) return res.status(404).json({ error: 'not found' });
  req.note = note;
  next();
});

router.get('/', (req, res) => {
  const { done } = req.query;
  const list = [...notes.values()];
  res.json(done === undefined ? list : list.filter((n) => String(n.done) === done));
});

router.get('/:id', (req, res) => res.json(req.note));

router.post('/', (req, res) => {
  const text = typeof req.body?.text === 'string' ? req.body.text.trim() : '';
  // 422 rather than 400: the JSON parsed fine, the content is what is wrong.
  if (!text) return res.status(422).json({ error: 'text is required' });

  const note = { id: nextId++, text, done: false };
  notes.set(note.id, note);
  res.status(201).location(`/notes/${note.id}`).json(note);
});

router.patch('/:id', (req, res) => {
  if (typeof req.body?.done === 'boolean') req.note.done = req.body.done;
  if (typeof req.body?.text === 'string') req.note.text = req.body.text.trim();
  res.json(req.note);
});

router.delete('/:id', (req, res) => {
  notes.delete(req.note.id);
  res.sendStatus(204);
});

const app = express();
app.use(express.json());
app.use('/notes', router);

app.listen(3000, () => {
  console.log('listening on http://localhost:3000/notes');
});
