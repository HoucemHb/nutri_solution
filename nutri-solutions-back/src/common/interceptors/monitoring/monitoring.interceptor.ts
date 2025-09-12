// import {
//   Injectable,
//   NestInterceptor,
//   ExecutionContext,
//   CallHandler,
// } from '@nestjs/common';
// import { Observable } from 'rxjs';
// import { tap } from 'rxjs/operators';
// import { MonitoringService } from '../../../monitoring/monitoring.service';

// @Injectable()
// export class MonitoringInterceptor implements NestInterceptor {
//   constructor(private readonly monitoringService: MonitoringService) {}

//   intercept(context: ExecutionContext, next: CallHandler): Observable<any> {
//     const request = context.switchToHttp().getRequest();
//     const response = context.switchToHttp().getResponse();
//     const startTime = Date.now();

//     return next.handle().pipe(
//       tap(() => {
//         const duration = (Date.now() - startTime) / 1000;
//         const { method, route } = request;
//         const statusCode = response.statusCode.toString();

//         // Track metrics
//         this.monitoringService.incrementHttpRequest(
//           method,
//           route?.path || 'unknown',
//           statusCode,
//         );
//         this.monitoringService.observeHttpDuration(
//           method,
//           route?.path || 'unknown',
//           duration,
//         );
//       }),
//     );
//   }
// }
