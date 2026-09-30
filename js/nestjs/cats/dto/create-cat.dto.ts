// create-cat.dto.ts: DTO validated with class-validator
//
// Description:
// Data transfer object whose class-validator decorators the global
// ValidationPipe enforces.
// Part of the NestJS sample project; see main.ts and
// README.md in this directory for setup and requirements.
//
// Author: id774 (More info: https://id774.net)
// Source Code: https://github.com/id774/sandbox
// License: The GPL version 3, or LGPL version 3 (Dual License).
// Contact: idnanashi@gmail.com

import { IsInt, IsOptional, IsString, Max, Min, MinLength } from 'class-validator';

// The DTO is a class, not an interface: the decorators need something that
// survives compilation, and the ValidationPipe instantiates it at runtime.
export class CreateCatDto {
  @IsString()
  @MinLength(1)
  name!: string;

  @IsInt()
  @Min(0)
  @Max(30)
  age!: number;

  @IsOptional()
  @IsString()
  breed?: string;
}
