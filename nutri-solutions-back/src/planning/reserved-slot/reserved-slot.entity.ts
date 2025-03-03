import { Client } from 'src/user/client/client.entity';
import { Column, ManyToOne, ChildEntity, AfterSoftRemove } from 'typeorm';
import { UnavailableSlot } from '../unavailable-slot/unavailable-slot.entity';

@ChildEntity()
export class ReservedSlot extends UnavailableSlot {
  @Column('simple-array')
  notes: string[];

  @ManyToOne(() => Client, (client) => client.reservedSlots, {
    onDelete: 'CASCADE',
    eager: true,
  })
  client: Client;

  @Column({ type: 'float', default: 0 })
  rating: number;
}
