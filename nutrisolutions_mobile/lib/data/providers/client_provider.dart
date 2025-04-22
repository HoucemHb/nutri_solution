import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/client_service.dart';
import '../models/client_model.dart';

// Service instance provider
final clientServiceProvider = Provider<ClientService>((ref) => ClientService());

// All clients
final allClientsProvider = FutureProvider<List<ClientModel>>((ref) async {
  final service = ref.read(clientServiceProvider);
  return service.getAllClients();
});

// Client count
final clientsCountProvider = FutureProvider<int>((ref) async {
  final service = ref.read(clientServiceProvider);
  return service.getClientsCount();
});

// Client by ID
final clientByIdProvider = FutureProvider.family<ClientModel, String>((ref, id) async {
  final service = ref.read(clientServiceProvider);
  return service.getClientById(id);
});

// Selected client (for selection purposes)
final selectedClientProvider = StateProvider<ClientModel?>((ref) => null);
