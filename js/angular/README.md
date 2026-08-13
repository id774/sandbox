# Angular

Written against Angular 22. Two things changed the shape of Angular code since
the NgModule era, and both are used here: standalone components (the default —
no `@NgModule`, dependencies listed on the component itself) and signals for
reactive state.

## Files

- `main.ts` — bootstrapping without an AppModule.
- `counter.component.ts` — `signal` / `computed` / `effect`, signal-based
  `input()` and `output()`.
- `todo.service.ts` — a root-provided service exposing readonly signals.
- `todo-list.component.ts` — `inject()` instead of a constructor parameter, and
  the built-in control flow blocks `@for` / `@if` / `@empty`.

## Running

    npm install -g @angular/cli
    ng new angular-demo --style=css
    cd angular-demo
    cp ../*.ts src/app/   # main.ts belongs in src/
    ng serve
