import { computed, Injectable, signal } from '@angular/core';

export interface Todo {
  id: number;
  text: string;
  done: boolean;
}

// providedIn: 'root' means one instance for the whole app, created lazily and
// dropped by the bundler if nothing injects it.
@Injectable({ providedIn: 'root' })
export class TodoService {
  #nextId = 1;
  // The writable signal stays private; callers only get the readonly view, so
  // state can change only through the methods below.
  readonly #todos = signal<Todo[]>([]);

  readonly todos = this.#todos.asReadonly();
  readonly remaining = computed(() => this.#todos().filter((t) => !t.done).length);

  add(text: string): void {
    const trimmed = text.trim();
    if (!trimmed) return;
    this.#todos.update((current) => [
      ...current,
      { id: this.#nextId++, text: trimmed, done: false },
    ]);
  }

  toggle(id: number): void {
    this.#todos.update((current) =>
      current.map((t) => (t.id === id ? { ...t, done: !t.done } : t)),
    );
  }

  remove(id: number): void {
    this.#todos.update((current) => current.filter((t) => t.id !== id));
  }
}
