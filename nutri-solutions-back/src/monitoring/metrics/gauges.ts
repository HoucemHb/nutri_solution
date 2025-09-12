import { makeGaugeProvider } from '@willsoto/nestjs-prometheus';

export const ActiveUsersGauge = makeGaugeProvider({
  name: 'active_users',
  help: 'Number of active users',
});

export const DatabaseConnectionsGauge = makeGaugeProvider({
  name: 'database_connections',
  help: 'Number of active database connections',
});
