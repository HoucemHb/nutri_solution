// import { Injectable } from '@nestjs/common';
// import { InjectMetric } from '@willsoto/nestjs-prometheus';
// import { Counter, Histogram, Gauge } from 'prom-client';

// @Injectable()
// export class MonitoringService {
//   constructor(
//     @InjectMetric('http_requests_total')
//     private readonly httpRequestsTotal: Counter<string>,
//     @InjectMetric('http_request_duration_seconds')
//     private readonly httpRequestDuration: Histogram<string>,
//     @InjectMetric('active_users') private readonly activeUsers: Gauge<string>,
//     @InjectMetric('database_connections')
//     private readonly databaseConnections: Gauge<string>,
//   ) {}

//   incrementHttpRequest(method: string, route: string, statusCode: string) {
//     this.httpRequestsTotal
//       .labels({ method, route, status_code: statusCode })
//       .inc();
//   }

//   observeHttpDuration(method: string, route: string, duration: number) {
//     this.httpRequestDuration.labels({ method, route }).observe(duration);
//   }

//   setActiveUsers(count: number) {
//     this.activeUsers.set(count);
//   }

//   setDatabaseConnections(count: number) {
//     this.databaseConnections.set(count);
//   }
// }
