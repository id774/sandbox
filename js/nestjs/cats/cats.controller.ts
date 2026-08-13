import {
  Body,
  Controller,
  Delete,
  Get,
  HttpCode,
  Param,
  ParseIntPipe,
  Post,
  Query,
} from '@nestjs/common';

import { CatsService } from './cats.service';
import { CreateCatDto } from './dto/create-cat.dto';

// The prefix for every route below.
@Controller('cats')
export class CatsController {
  // Constructor injection: the type is the token, so nothing is imported by
  // hand and the service can be swapped in tests through the module.
  constructor(private readonly catsService: CatsService) {}

  @Get()
  findAll(@Query('breed') breed?: string) {
    const cats = this.catsService.findAll();
    return breed ? cats.filter((c) => c.breed === breed) : cats;
  }

  @Get(':id')
  // ParseIntPipe converts and rejects: the handler receives a number or the
  // request already failed with a 400.
  findOne(@Param('id', ParseIntPipe) id: number) {
    return this.catsService.findOne(id);
  }

  @Post()
  // The DTO type is what the global ValidationPipe checks against.
  create(@Body() dto: CreateCatDto) {
    return this.catsService.create(dto);
  }

  @Delete(':id')
  @HttpCode(204)
  remove(@Param('id', ParseIntPipe) id: number) {
    this.catsService.remove(id);
  }
}
