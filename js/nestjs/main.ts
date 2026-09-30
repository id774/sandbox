// main.ts: Bootstrap entry of the NestJS sample app
//
// Description:
// Bootstraps the Nest application from AppModule, installs a global
// ValidationPipe that validates DTO request bodies, and enables shutdown
// hooks. The cats feature module under cats/ provides the /cats routes; see
// README.md in this directory.
//
// Author: id774 (More info: https://id774.net)
// Source Code: https://github.com/id774/sandbox
// License: The GPL version 3, or LGPL version 3 (Dual License).
// Contact: idnanashi@gmail.com
//
// Usage:
//     npm install -g @nestjs/cli
//     nest new nest-demo
//     cd nest-demo
//     npm install class-validator class-transformer
//     cp -r ../main.ts ../app.module.ts ../cats src/
//     npm run start:dev
//     curl localhost:3000/cats
//
// Requirements:
// - Node.js 20.11 or later (Nest 11 needs Node.js 20, and the current Nest
//   CLI needs 20.11)
// - npm
// - Nest 11 or later within the 11.x line, with the Nest CLI
// - class-validator and class-transformer, which the ValidationPipe and the
//   DTO use
//
// Notes:
// - The app listens on the port in the PORT environment variable, or 3000
//   when it is unset.

import { ValidationPipe } from '@nestjs/common';
import { NestFactory } from '@nestjs/core';

import { AppModule } from './app.module';

async function bootstrap() {
  const app = await NestFactory.create(AppModule);

  // One pipe for the whole app: every @Body() typed as a DTO class is
  // validated against its decorators before a controller sees it.
  app.useGlobalPipes(
    new ValidationPipe({
      whitelist: true, // drop properties with no decorator
      forbidNonWhitelisted: true, // …or reject the request outright
      transform: true, // instantiate the DTO class, coerce param types
    }),
  );

  app.enableShutdownHooks();

  await app.listen(process.env.PORT ?? 3000);
  console.log(`listening on ${await app.getUrl()}`);
}

bootstrap();
