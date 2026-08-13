// Bootstrapping a standalone app: no AppModule, no declarations array.
// Providers that used to live in an NgModule are passed here instead.

import { Component } from '@angular/core';
import { bootstrapApplication } from '@angular/platform-browser';
import { provideHttpClient } from '@angular/common/http';

import { CounterComponent } from './counter.component';
import { TodoListComponent } from './todo-list.component';

@Component({
  selector: 'app-root',
  // A standalone component names what it uses; nothing is globally available.
  imports: [CounterComponent, TodoListComponent],
  template: `
    <h1>Angular</h1>
    <app-counter [step]="2" (changed)="lastValue = $event" />
    <p>last counter value: {{ lastValue }}</p>
    <app-todo-list heading="Today" />
  `,
})
export class AppComponent {
  lastValue = 0;
}

bootstrapApplication(AppComponent, {
  providers: [provideHttpClient()],
}).catch((err) => console.error(err));
