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
