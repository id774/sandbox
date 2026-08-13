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
