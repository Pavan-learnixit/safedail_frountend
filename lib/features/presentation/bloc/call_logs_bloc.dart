import 'package:flutter_bloc/flutter_bloc.dart';

import '../../auth/data/repositories/call_logs_repository.dart';
import 'call_logs_event.dart';
import 'call_logs_state.dart';

class CallLogsBloc extends Bloc<CallLogsEvent, CallLogsState> {
  final CallLogsRepository repository;

  CallLogsBloc({required this.repository}) : super(CallLogsInitial()) {
    on<LoadCallLogs>(_onLoad);
    on<FilterCallLogs>(_onFilter);
    on<DeleteAllCallLogs>(_onDeleteAll);
  }

  Future<void> _onLoad(LoadCallLogs event, Emitter<CallLogsState> emit) async {
    emit(CallLogsLoading());
    try {
      final logs = await repository.fetchAll();
      if (logs.isEmpty) {
        emit(CallLogsEmpty());
      } else {
        emit(CallLogsLoaded(callLogs: logs, activeFilter: null));
      }
    } catch (e) {
      emit(CallLogsError(e.toString()));
    }
  }

  Future<void> _onFilter(
      FilterCallLogs event, Emitter<CallLogsState> emit) async {
    emit(CallLogsLoading());
    try {
      final logs = await repository.fetchByType(event.filterType);
      if (logs.isEmpty) {
        emit(CallLogsEmpty());
      } else {
        emit(CallLogsLoaded(callLogs: logs, activeFilter: event.filterType));
      }
    } catch (e) {
      emit(CallLogsError(e.toString()));
    }
  }

  Future<void> _onDeleteAll(
      DeleteAllCallLogs event, Emitter<CallLogsState> emit) async {
    emit(CallLogsLoading());
    try {
      await repository.deleteAll();
      final logs = await repository.fetchAll();
      if (logs.isEmpty) {
        emit(CallLogsEmpty());
      } else {
        emit(CallLogsLoaded(callLogs: logs, activeFilter: null));
      }
    } catch (e) {
      emit(CallLogsError(e.toString()));
    }
  }
}
