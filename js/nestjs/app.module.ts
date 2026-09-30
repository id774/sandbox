// app.module.ts: Root module of the NestJS sample app
//
// Description:
// Root module that composes the cats feature module.
// Part of the NestJS sample project; see main.ts and
// README.md in this directory for setup and requirements.
//
// Author: id774 (More info: https://id774.net)
// Source Code: https://github.com/id774/sandbox
// License: The GPL version 3, or LGPL version 3 (Dual License).
// Contact: idnanashi@gmail.com

import { Logger, MiddlewareConsumer, Module, NestModule } from '@nestjs/common';

import { CatsModule } from './cats/cats.module';

// The root module. `imports` is the composition point: nothing is global
// unless a module says so.
@Module({
  imports: [CatsModule],
  controllers: [],
  providers: [],
})
export class AppModule implements NestModule {
  private readonly logger = new Logger(AppModule.name);

  // Middleware is bound to routes here rather than in a decorator.
  configure(consumer: MiddlewareConsumer) {
    consumer
      .apply((req: any, _res: any, next: () => void) => {
        this.logger.log(`${req.method} ${req.url}`);
        next();
      })
      .forRoutes('*');
  }
}
