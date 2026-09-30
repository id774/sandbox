// cats.module.ts: Cats feature module
//
// Description:
// Feature module that provides CatsService, registers CatsController, and
// exports the service.
// Part of the NestJS sample project; see main.ts and
// README.md in this directory for setup and requirements.
//
// Author: id774 (More info: https://id774.net)
// Source Code: https://github.com/id774/sandbox
// License: The GPL version 3, or LGPL version 3 (Dual License).
// Contact: idnanashi@gmail.com

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
