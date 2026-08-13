import { Injectable, NotFoundException } from '@nestjs/common';

import { CreateCatDto } from './dto/create-cat.dto';

export interface Cat extends CreateCatDto {
  id: number;
}

// @Injectable makes the class available to the injector; the controller asks
// for it by type and Nest constructs it once per module.
@Injectable()
export class CatsService {
  private readonly cats: Cat[] = [{ id: 1, name: 'Mikan', age: 3, breed: 'calico' }];
  private nextId = 2;

  findAll(): Cat[] {
    return this.cats;
  }

  findOne(id: number): Cat {
    const cat = this.cats.find((c) => c.id === id);
    // Built-in exceptions map to status codes, so no res object is needed.
    if (!cat) throw new NotFoundException(`no cat with id ${id}`);
    return cat;
  }

  create(dto: CreateCatDto): Cat {
    const cat = { id: this.nextId++, ...dto };
    this.cats.push(cat);
    return cat;
  }

  remove(id: number): void {
    const index = this.cats.findIndex((c) => c.id === id);
    if (index < 0) throw new NotFoundException(`no cat with id ${id}`);
    this.cats.splice(index, 1);
  }
}
