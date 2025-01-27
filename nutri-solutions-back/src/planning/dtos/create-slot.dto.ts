import { IsUUID, IsDateString, IsNotEmpty, IsString } from 'class-validator';
import { CreateUnavailableSlotDto } from '../unavailable-slot/dtos/create-unavailable-slot.dto';

export class CreateSlotDto extends CreateUnavailableSlotDto {
  @IsUUID()
  @IsNotEmpty()
  clientId: string;
}
