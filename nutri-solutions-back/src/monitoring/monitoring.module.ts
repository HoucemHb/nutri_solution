// import { Module } from '@nestjs/common';
// import { PrometheusModule } from '@willsoto/nestjs-prometheus';
// import { MonitoringService } from './monitoring.service';
// import { MonitoringController } from './monitoring.controller';

// @Module({
//   imports: [
//     PrometheusModule.register({
//       path: '/metrics',
//       defaultMetrics: {
//         enabled: true,
//         config: { prefix: 'nutri_solutions_' },
//       },
//     }),
//   ],
//   providers: [MonitoringService],
//   controllers: [MonitoringController],
//   exports: [MonitoringService],
// })
// export class MonitoringModule {}
