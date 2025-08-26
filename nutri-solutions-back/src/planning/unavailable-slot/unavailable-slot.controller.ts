import {
  Controller,
  Post,
  Get,
  Param,
  Body,
  NotFoundException,
  Delete,
  HttpCode,
  HttpStatus,
  Patch,
} from '@nestjs/common';
import { CreateReservedSlotDto } from '../dtos/create-slot.dto';
import { EmailService } from 'src/common/email/email.service';
import { UpdateReservedSlotDto } from '../dtos/update-slot.dto';
import { ReservedSlotService } from '../reserved-slot/reserved-slot.service';
import { UnavailableSlotService } from './unavailable-slot.service';
import { UnavailableSlot } from './unavailable-slot.entity';
import { ReservedSlot } from '../reserved-slot/reserved-slot.entity';
import { CreateUnavailableSlotDto } from './dtos/create-unavailable-slot.dto';
import { UpdateResult } from 'typeorm';
import { MessagesService } from 'src/messenger/messenger.service';

@Controller('planning')
export class UnavailableSlotController {
  constructor(
    private readonly reservedSlotService: ReservedSlotService,
    private readonly unavailableSlotService: UnavailableSlotService,
    private emailService: EmailService,
  ) {}

  /**
   * Create a new reserved slot
   * @param createSlotDto The data for the slot to create
   * @returns The created reserved slot
   */
  @Post()
  async create(
    @Body() createUnavailableSlotDto: CreateUnavailableSlotDto,
  ): Promise<UnavailableSlot> {
    const slot = await this.unavailableSlotService.createSlot(
      createUnavailableSlotDto,
    );
    return slot;
  }

  /**
   * Get all reserved slots
   * @returns A list of all reserved slots
   */
  @Get(':nutritionistId')
  async findAll(
    @Param('nutritionistId') nutritionistId: string,
  ): Promise<UnavailableSlot[]> {
    return this.unavailableSlotService.findAllByNutritionist(nutritionistId);
  }

  /**
   * Get a reserved slot by its ID
   * @param id The ID of the reserved slot
   * @returns The reserved slot with the given ID
   */
  @Get(':id')
  async findOne(@Param('id') id: string): Promise<ReservedSlot> {
    const slot = await this.reservedSlotService.findOne(id);
    if (!slot) {
      throw new NotFoundException(`Reserved slot with ID ${id} not found`);
    }
    return slot;
  }

  /**
   * Delete a reserved slot by its ID
   * @param id The ID of the reserved slot to delete
   * @returns A success response
   */
  @Delete(':id')
  @HttpCode(HttpStatus.NO_CONTENT)
  async delete(@Param('id') id: string): Promise<UpdateResult> {
    const slot = await this.unavailableSlotService.findOne(id);
    if (!slot) {
      throw new NotFoundException(`Slot with ID ${id} not found`);
    }

    const result = await this.unavailableSlotService.softDelete(id);
    if (!result) {
      throw new NotFoundException(`Slot with ID ${id} not found`);
    }
    if (slot.isReservation) {
      const reservationDate = `${new Date(slot.date).toLocaleDateString()} at ${slot.time}`;
      await this.emailService.sendReservationCancelNotification(
        slot.nutritionist.email,
        slot.nutritionist.name,
        (slot as ReservedSlot).client.name,
        reservationDate,
      );
    }
    return result;
  }

  @Patch(':id')
  async update(
    @Param('id') id: string,
    @Body() updateSlotDto: UpdateReservedSlotDto,
  ) {
    return this.reservedSlotService.update(id, updateSlotDto);
  }
}
