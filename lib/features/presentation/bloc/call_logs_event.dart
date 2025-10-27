import 'package:equatable/equatable.dart';

import '../../auth/domain/entities/call_log-model.dart';


abstract class CallLogsEvent extends Equatable {
  const CallLogsEvent();

  @override
  List<Object?> get props => [];
}

class LoadCallLogs extends CallLogsEvent {}

class FilterCallLogs extends CallLogsEvent {
  final CallType? filterType; // null => all

  const FilterCallLogs(this.filterType);

  @override
  List<Object?> get props => [filterType];
}

class DeleteAllCallLogs extends CallLogsEvent {}
