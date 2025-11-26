import 'package:call_log/call_log.dart' as device_log;
import 'package:flutter/cupertino.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../domain/entities/call_log-model.dart';

class CallLogsRepository {
  Future<List<CallLogModel>> fetchAll() async {
    final phoneStatus = await Permission.phone.request();
    if (!phoneStatus.isGranted) return [];

    final Iterable<device_log.CallLogEntry> entries = await device_log.CallLog.get();
    debugPrint("Fetched ${entries.length} call logs");
    return entries.map((entry) {
      return CallLogModel(
        id: entry.hashCode.toString(),
        name: entry.name ?? "Unknown",
        number: entry.number ?? "Unknown",
        time: DateTime.fromMillisecondsSinceEpoch(entry.timestamp ?? 0),
        durationSeconds: entry.duration ?? 0,
        type: _mapCallType(entry.callType),
      );
    }).toList();
  }

  Future<List<CallLogModel>> fetchByType(CallType? type) async {
    final all = await fetchAll();
    if (type == null) return all;
    return all.where((c) => c.type == type).toList();
  }

  Future<void> deleteAll() async {
    // ⚠️ Not supported by call_log package
    // Would require native Android code
  }

  CallType _mapCallType(device_log.CallType? type) {
    switch (type) {
      case device_log.CallType.incoming:
        return CallType.incoming;
      case device_log.CallType.outgoing:
        return CallType.outgoing;
      case device_log.CallType.missed:
        return CallType.missed;
      case device_log.CallType.rejected:
        return CallType.blocked;
      default:
        return CallType.missed;
    }
  }
}
