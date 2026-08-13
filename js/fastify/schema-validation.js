// Schemas as the contract of a route. Run with: node schema-validation.js
//
//   curl -X POST localhost:3000/notes -H 'content-type: application/json' -d '{"text":"hi"}'
//   curl -X POST localhost:3000/notes -H 'content-type: application/json' -d '{}'

import Fastify from 'fastify';

const app = Fastify({ logger: false });

const notes = [{ id: 1, text: 'first note', done: false }];
let nextId = 2;

// Shared definitions are registered once and referenced by $id.
app.addSchema({
  $id: 'note',
  type: 'object',
  properties: {
    id: { type: 'integer' },
    text: { type: 'string' },
    done: { type: 'boolean' },
  },
});

app.get('/notes', {
  schema: {
    querystring: {
      type: 'object',
      properties: { done: { type: 'boolean' } }, // "true" is coerced to a boolean
    },
    // The response schema is not a check: Fastify compiles it into a
    // serialiser, which is both faster than JSON.stringify and a guarantee
    // that no extra field leaks out.
    response: {
      200: { type: 'array', items: { $ref: 'note#' } },
    },
  },
  handler: async (request) => {
    const { done } = request.query;
    return done === undefined ? notes : notes.filter((n) => n.done === done);
  },
});

app.post('/notes', {
  schema: {
    body: {
      type: 'object',
      required: ['text'],
      properties: {
        text: { type: 'string', minLength: 1, maxLength: 140 },
        done: { type: 'boolean', default: false },
      },
      // Fastify's ajv is configured with removeAdditional, so unknown keys are
      // stripped rather than rejected: the handler cannot see them either way.
      additionalProperties: false,
    },
    response: { 201: { $ref: 'note#' } },
  },
  handler: async (request, reply) => {
    // Past this line the body is known to match the schema.
    const note = { id: nextId++, text: request.body.text, done: request.body.done };
    notes.push(note);
    return reply.code(201).send(note);
  },
});

// Validation failures arrive here with a `validation` array attached.
app.setErrorHandler(async (error, request, reply) => {
  if (error.validation) {
    return reply.code(422).send({
      error: 'validation failed',
      details: error.validation.map((v) => `${v.instancePath || 'body'} ${v.message}`),
    });
  }
  request.log?.error(error);
  return reply.code(error.statusCode ?? 500).send({ error: error.message });
});

await app.listen({ port: 3000, host: '127.0.0.1' });
console.log('listening on http://localhost:3000/notes');
