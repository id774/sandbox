// main.ts: Bootstrap entry of the Angular sample app
//
// Description:
// Composition root of a small standalone Angular application. It declares the
// root component and starts it with bootstrapApplication(), passing providers
// directly instead of through an NgModule. The root component uses
// counter.component.ts and todo-list.component.ts, and the todo list uses
// todo.service.ts. See README.md in this directory for what each file shows.
//
// Author: id774 (More info: https://id774.net)
// Source Code: https://github.com/id774/sandbox
// License: The GPL version 3, or LGPL version 3 (Dual License).
// Contact: idnanashi@gmail.com
//
// Usage:
//     npm install -g @angular/cli
//     ng new angular-demo --style=css
//     cd angular-demo
//     cp ../*.ts src/
//     ng serve
//
//     Copy all four .ts files together: this file imports the others by
//     relative path, and src/main.ts is the entry point the CLI builds.
//
// Requirements:
// - Node.js ^22.22.3, ^24.15.0, or 26.0.0 or later (the engines range of
//   Angular 22)
// - npm
// - Angular 22 or later within the 22.x line, with the Angular CLI

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
