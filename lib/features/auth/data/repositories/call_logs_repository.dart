// lib/repository/call_logs_repository.dart

import '../../domain/entities/call_log-model.dart';

/// For now ths is an in-memory repository returning dummy data.
/// Ltr we can implement native call logs nd replace methods.
class CallLogsRepository {
  final List<CallLogModel> _storage = _sampleData();

  Future<List<CallLogModel>> fetchAll() async {
    // simulate small delay
    await Future.delayed(const Duration(milliseconds: 200));
    return List.unmodifiable(_storage);
  }

  Future<void> deleteAll() async {
    _storage.clear();
    await Future.delayed(const Duration(milliseconds: 100));
  }

  // simple helper for filters
  Future<List<CallLogModel>> fetchByType(CallType? type) async {
    final all = await fetchAll();
    if (type == null) return all;
    return all.where((c) => c.type == type).toList();
  }
}

List<CallLogModel> _sampleData() {
  final now = DateTime.now();
  return [
    CallLogModel(
      id: '1',
      name: 'Aditi',
      number: '+91 98765 43210',
      time: now.subtract(const Duration(minutes: 5)),
      durationSeconds: 120,
      type: CallType.incoming,
    ),
    CallLogModel(
      id: '2',
      name: 'Ravi',
      number: '+91 91234 56789',
      time: now.subtract(const Duration(hours: 1, minutes: 10)),
      durationSeconds: 0,
      type: CallType.missed,
    ),
    CallLogModel(
      id: '3',
      name: 'Spam Blocker',
      number: 'Unknown',
      time: now.subtract(const Duration(days: 1)),
      durationSeconds: 0,
      type: CallType.blocked,
    ),
    CallLogModel(
      id: '4',
      name: 'Mom',
      number: '+91 99887 77665',
      time: now.subtract(const Duration(days: 2, hours: 3)),
      durationSeconds: 300,
      type: CallType.outgoing,
    ),
    CallLogModel(
      id: '5',
      name: 'Uber',
      number: '+91 70000 00001',
      time: now.subtract(const Duration(minutes: 30)),
      durationSeconds: 50,
      type: CallType.incoming,
    ),
  ];
}
