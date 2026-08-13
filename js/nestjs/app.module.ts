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
