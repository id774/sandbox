import { Form, useNavigation } from 'react-router';

import type { Route } from './+types/notes';

// Stand-in for a database; module state resets when the server restarts.
const notes = [{ id: 1, text: 'first note' }];
let nextId = 2;

export async function loader() {
  return { notes };
}

// Non-GET requests to this route land here. After it returns, the loaders on
// the page re-run automatically — no cache to invalidate by hand.
export async function action({ request }: Route.ActionArgs) {
  const form = await request.formData();
  const intent = form.get('intent');

  if (intent === 'delete') {
    const id = Number(form.get('id'));
    const index = notes.findIndex((n) => n.id === id);
    if (index >= 0) notes.splice(index, 1);
    return { ok: true };
  }

  const text = String(form.get('text') ?? '').trim();
  if (!text) return { ok: false, error: 'the note cannot be empty' };

  notes.push({ id: nextId++, text });
  return { ok: true };
}

export default function Notes({ loaderData, actionData }: Route.ComponentProps) {
  const navigation = useNavigation();
  const submitting = navigation.state === 'submitting';

  return (
    <main>
      <h1>Notes</h1>

      {/* <Form> posts like a plain <form> when JavaScript has not loaded,
          and over fetch once it has */}
      <Form method="post">
        <input name="text" placeholder="new note" />
        <button type="submit" disabled={submitting}>
          {submitting ? 'saving…' : 'add'}
        </button>
      </Form>

      {actionData?.error && <p role="alert">{actionData.error}</p>}

      <ul>
        {loaderData.notes.map((note) => (
          <li key={note.id}>
            {note.text}
            <Form method="post">
              <input type="hidden" name="intent" value="delete" />
              <input type="hidden" name="id" value={note.id} />
              <button type="submit">x</button>
            </Form>
          </li>
        ))}
      </ul>
    </main>
  );
}
