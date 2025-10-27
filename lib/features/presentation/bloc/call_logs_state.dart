import 'package:equatable/equatable.dart';

import '../../auth/domain/entities/call_log-model.dart';


abstract class CallLogsState extends Equatable {
  const CallLogsState();

  @override
  List<Object?> get props => [];
}

class CallLogsInitial extends CallLogsState {}

class CallLogsLoading extends CallLogsState {}

class CallLogsLoaded extends CallLogsState {
  final List<CallLogModel> callLogs;
  final CallType? activeFilter;

  const CallLogsLoaded({required this.callLogs, this.activeFilter});

  @override
  List<Object?> get props => [callLogs, activeFilter];
}

class CallLogsEmpty extends CallLogsState {}

class CallLogsError extends CallLogsState {
  final String message;

  const CallLogsError(this.message);

  @override
  List<Object?> get props => [message];
}
