import { addNote, deleteNote, listNotes } from './actions';

// A server component with no client JavaScript at all: the forms below post
// to the actions directly, so this page works before (and without) hydration.
export default async function NotesPage() {
  const notes = await listNotes();

  return (
    <main>
      <h1>Notes</h1>

      {/* action takes the function itself, not a URL string */}
      <form action={addNote}>
        <input name="text" placeholder="new note" />
        <button type="submit">add</button>
      </form>

      <ul>
        {notes.map((note) => (
          <li key={note.id}>
            {note.text}
            <form action={deleteNote}>
              <input type="hidden" name="id" value={note.id} />
              <button type="submit">x</button>
            </form>
          </li>
        ))}
      </ul>
    </main>
  );
}
