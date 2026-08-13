import { component$, useComputed$, useSignal, useVisibleTask$ } from '@builder.io/qwik';

interface CounterProps {
  step?: number;
}

export const Counter = component$<CounterProps>(({ step = 1 }) => {
  // A signal is a serialisable box: the value survives the server render and
  // is picked up again in the browser without re-running this component.
  const count = useSignal(0);
  const doubled = useComputed$(() => count.value * 2);

  // Explicitly opting out of resumability: this runs eagerly in the browser.
  // The awkward name is deliberate — it is the escape hatch, not the default.
  useVisibleTask$(({ cleanup }) => {
    const id = setInterval(() => console.log('still here'), 5000);
    cleanup(() => clearInterval(id));
  });

  return (
    <p>
      <output>
        {count.value} (doubled: {doubled.value})
      </output>
      {/* The handler is a separate chunk, fetched on first click */}
      <button onClick$={() => (count.value += step)}>+{step}</button>
      <button onClick$={() => (count.value -= step)}>-{step}</button>
      <button onClick$={() => (count.value = 0)} disabled={count.value === 0}>
        reset
      </button>
    </p>
  );
});
