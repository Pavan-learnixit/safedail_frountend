import 'package:equatable/equatable.dart';

enum CallType { incoming, outgoing, missed, blocked }

class CallLogModel extends Equatable {
  final String id;
  final String name;
  final String number;
  final DateTime time;
  final int durationSeconds;
  final CallType type;

  const CallLogModel({
    required this.id,
    required this.name,
    required this.number,
    required this.time,
    required this.durationSeconds,
    required this.type,
  });

  @override
  List<Object?> get props => [id, name, number, time, durationSeconds, type];

  CallLogModel copyWith({
    String? id,
    String? name,
    String? number,
    DateTime? time,
    int? durationSeconds,
    CallType? type,
  }) {
    return CallLogModel(
      id: id ?? this.id,
      name: name ?? this.name,
      number: number ?? this.number,
      time: time ?? this.time,
      durationSeconds: durationSeconds ?? this.durationSeconds,
      type: type ?? this.type,
    );
  }
}
