// counter.component.ts: Signal-based counter component
//
// Description:
// Counter component using signal, computed, effect, and the signal-based
// input() and output().
// Part of the Angular sample project; see main.ts and
// README.md in this directory for setup and requirements.
//
// Author: id774 (More info: https://id774.net)
// Source Code: https://github.com/id774/sandbox
// License: The GPL version 3, or LGPL version 3 (Dual License).
// Contact: idnanashi@gmail.com

import { Component, computed, effect, input, output, signal } from '@angular/core';

@Component({
  selector: 'app-counter',
  template: `
    <p>
      <output>{{ count() }} (doubled: {{ doubled() }})</output>
      <button (click)="add(step())">+{{ step() }}</button>
      <button (click)="add(-step())">-{{ step() }}</button>
      <button (click)="reset()" [disabled]="count() === 0">reset</button>
    </p>

    @if (count() > 10) {
      <p class="warn">over ten</p>
    }
  `,
  styles: `.warn { color: crimson; }`,
})
export class CounterComponent {
  // Signal inputs replace @Input(): read as step(), and usable inside computed.
  readonly step = input(1);
  readonly changed = output<number>();

  // Writable state. In templates a signal is called, never read as a field.
  protected readonly count = signal(0);
  protected readonly doubled = computed(() => this.count() * 2);

  constructor() {
    // Re-runs whenever a signal it read changes; cleaned up with the component.
    effect(() => {
      document.title = `count: ${this.count()}`;
    });
  }

  protected add(delta: number): void {
    this.count.update((current) => current + delta);
    this.changed.emit(this.count());
  }

  protected reset(): void {
    this.count.set(0);
    this.changed.emit(0);
  }
}
