import { fail } from '@sveltejs/kit';

// Stand-in for a database; module state resets when the server restarts.
const notes = [{ id: 1, text: 'first note' }];
let nextId = 2;

// Server-only: this file never reaches the browser, so credentials and direct
// database access belong here rather than in +page.js.
/** @type {import('./$types').PageServerLoad} */
export async function load() {
  return { notes };
}

/** @type {import('./$types').Actions} */
export const actions = {
  // Named actions are posted to ?/add and ?/delete respectively.
  add: async ({ request }) => {
    const data = await request.formData();
    const text = String(data.get('text') ?? '').trim();

    // fail() re-renders the page with `form` populated and a 4xx status,
    // instead of throwing away what the user typed.
    if (!text) return fail(400, { text, missing: true });

    notes.push({ id: nextId++, text });
    return { success: true };
  },

  delete: async ({ request }) => {
    const data = await request.formData();
    const id = Number(data.get('id'));
    const index = notes.findIndex((n) => n.id === id);
    if (index >= 0) notes.splice(index, 1);
    return { success: true };
  },
};
