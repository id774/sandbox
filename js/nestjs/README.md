# NestJS

Written against Nest 11. Angular's architecture applied to the server:
decorators, modules, and constructor injection over Express (or Fastify, by
swapping the adapter).

## Files

- `main.ts` — bootstrap, global pipes, graceful shutdown.
- `app.module.ts` — the root module composing the feature module.
- `cats/cats.module.ts` — what the module provides and what it exports.
- `cats/dto/create-cat.dto.ts` — a DTO with `class-validator` decorators; the
  global `ValidationPipe` enforces them.
- `cats/cats.service.ts` — an injectable holding the logic.
- `cats/cats.controller.ts` — routing decorators, and nothing else.

## Running

    npm install -g @nestjs/cli
    nest new nest-demo
    cd nest-demo
    npm install class-validator class-transformer
    cp -r ../main.ts ../app.module.ts ../cats src/
    npm run start:dev

    curl localhost:3000/cats
