import { makeHistogramProvider } from '@willsoto/nestjs-prometheus';

export const HttpRequestDuration = makeHistogramProvider({
  name: 'http_request_duration_seconds',
  help: 'Duration of HTTP requests in seconds',
  labelNames: ['method', 'route'],
});
