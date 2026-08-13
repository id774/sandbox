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
