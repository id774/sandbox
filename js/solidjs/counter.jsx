// The body of a Solid component runs once, at creation. Anything that should
// change over time has to be a signal read *inside* the JSX, which is where
// the fine-grained subscription is set up.
//
//   import { render } from "solid-js/web";
//   render(() => <Counter step={2} />, document.getElementById("root"));

import { createEffect, createMemo, createSignal, onCleanup } from "solid-js";

export default function Counter(props) {
  const [count, setCount] = createSignal(0);
  const doubled = createMemo(() => count() * 2);

  // No dependency array: the effect tracks whatever signals it reads.
  createEffect(() => {
    document.title = `count: ${count()}`;
  });

  return (
    <p>
      {/* `count()` here, not `count` — the call is the subscription */}
      <output>{count()} (doubled: {doubled()})</output>
      <button onClick={() => setCount((c) => c + (props.step ?? 1))}>
        +{props.step ?? 1}
      </button>
      <button onClick={() => setCount(0)} disabled={count() === 0}>
        reset
      </button>
    </p>
  );
}

export function Ticker() {
  const [seconds, setSeconds] = createSignal(0);
  const id = setInterval(() => setSeconds((s) => s + 1), 1000);

  // Runs when the owning component is disposed.
  onCleanup(() => clearInterval(id));

  return <p>{seconds()}s elapsed</p>;
}
