import { Component, inject, input } from '@angular/core';

import { TodoService } from './todo.service';

@Component({
  selector: 'app-todo-list',
  template: `
    <h2>{{ heading() }} ({{ todos.remaining() }} left)</h2>

    <form (submit)="add($event, draft)">
      <input #draft placeholder="What next?" />
      <button type="submit">add</button>
    </form>

    <ul>
      <!-- track tells Angular how to identify a row across updates; it is
           required, unlike the optional trackBy of *ngFor -->
      @for (todo of todos.todos(); track todo.id) {
        <li [class.done]="todo.done">
          <input type="checkbox" [checked]="todo.done" (change)="todos.toggle(todo.id)" />
          {{ todo.text }}
          <button (click)="todos.remove(todo.id)">x</button>
        </li>
      } @empty {
        <li>nothing here yet</li>
      }
    </ul>
  `,
  styles: `.done { color: #999; text-decoration: line-through; }`,
})
export class TodoListComponent {
  readonly heading = input('Todo');

  // inject() in a field initialiser: no constructor, and the type is inferred.
  protected readonly todos = inject(TodoService);

  protected add(event: Event, input: HTMLInputElement): void {
    event.preventDefault();
    this.todos.add(input.value);
    input.value = '';
  }
}
