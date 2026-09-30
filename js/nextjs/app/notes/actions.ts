// actions.ts: Server actions for the notes page
//
// Description:
// Server actions that list, add, and delete notes and revalidate the cached
// render.
// Part of the Next.js sample project; see app/layout.tsx and
// README.md in this directory for setup and requirements.
//
// Author: id774 (More info: https://id774.net)
// Source Code: https://github.com/id774/sandbox
// License: The GPL version 3, or LGPL version 3 (Dual License).
// Contact: idnanashi@gmail.com

// Everything in this file is a server action: Next turns each export into an
// endpoint, and importing one from a client component gives back a callable
// reference, not the function body.
'use server';

import { revalidatePath } from 'next/cache';

export interface Note {
  id: number;
  text: string;
}

// Stand-in for a database. Module state resets on every server restart.
const notes: Note[] = [{ id: 1, text: 'first note' }];
let nextId = 2;

export async function listNotes(): Promise<Note[]> {
  return notes;
}

export async function addNote(formData: FormData) {
  const text = String(formData.get('text') ?? '').trim();
  // Never trust the form: the action is a public endpoint, validated here
  // rather than in the browser.
  if (!text) return;

  notes.push({ id: nextId++, text });

  // Drops the cached render of /notes so the next visit shows the new row.
  revalidatePath('/notes');
}

export async function deleteNote(formData: FormData) {
  const id = Number(formData.get('id'));
  const index = notes.findIndex((n) => n.id === id);
  if (index >= 0) notes.splice(index, 1);
  revalidatePath('/notes');
}
