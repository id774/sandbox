// index.tsx: Qwik City route with a loader and an action
//
// Description:
// Qwik City route whose routeLoader$ runs on the server before rendering, and
// whose routeAction$ with Form handles a validated POST without client
// code.
//
// Author: id774 (More info: https://id774.net)
// Source Code: https://github.com/id774/sandbox
// License: The GPL version 3, or LGPL version 3 (Dual License).
// Contact: idnanashi@gmail.com
//
// Usage:
//     npm create qwik@latest
//     cd <project>
//     cp -r ../counter.tsx ../todo.tsx ../routes src/
//     npm start
//
// Requirements:
// - Node.js 20.19 or later (the engines of Vite 7, which the Qwik 1.20
//   starter installs)
// - npm
// - Qwik 1.20 or later within the 1.x line (@builder.io/qwik)
// - Qwik City 1.20 (@builder.io/qwik-city), which provides routeLoader$,
//   routeAction$, Form, and the zod$ validation helpers
//
// Notes:
// - The route loader fetches https://api.quotable.io/random, a public API,
//   on the server, so network access is needed.

import { component$ } from '@builder.io/qwik';
import { Form, routeAction$, routeLoader$, zod$, z } from '@builder.io/qwik-city';

// Runs on the server before the component renders. The result is serialised
// into the HTML, so the browser never issues a second request for it.
export const useQuote = routeLoader$(async () => {
  const res = await fetch('https://api.quotable.io/random');
  const data = (await res.json()) as { content: string; author: string };
  return { content: data.content, author: data.author };
});

// A POST endpoint and its form validation in one declaration. With <Form>
// below this still works with JavaScript disabled.
export const useSubscribe = routeAction$(
  async (data) => {
    console.log('subscribing', data.email);
    return { success: true, email: data.email };
  },
  zod$({
    email: z.string().email('that does not look like an email'),
  }),
);

export default component$(() => {
  const quote = useQuote();
  const subscribe = useSubscribe();

  return (
    <main>
      <blockquote>
        {quote.value.content} — <cite>{quote.value.author}</cite>
      </blockquote>

      <Form action={subscribe}>
        <input name="email" type="email" placeholder="you@example.com" />
        <button type="submit">subscribe</button>

        {subscribe.value?.failed && <p>{subscribe.value.fieldErrors?.email}</p>}
        {subscribe.value?.success && <p>subscribed {subscribe.value.email}</p>}
      </Form>
    </main>
  );
});
