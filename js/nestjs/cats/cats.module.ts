import { Module } from '@nestjs/common';

import { CatsController } from './cats.controller';
import { CatsService } from './cats.service';

@Module({
  controllers: [CatsController],
  // Providers are singletons within this module's injector.
  providers: [CatsService],
  // Only what is exported can be injected by modules importing this one;
  // everything else stays private to the module.
  exports: [CatsService],
})
export class CatsModule {}
