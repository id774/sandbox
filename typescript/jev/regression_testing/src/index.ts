export default {
  fetch(): Response {
    return new Response("Jev regression testing sample\n");
  },
} satisfies ExportedHandler<Env>;
