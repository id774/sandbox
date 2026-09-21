export default {
  fetch(): Response {
    return new Response("Jev metamorphic testing sample\n");
  },
} satisfies ExportedHandler<Env>;
