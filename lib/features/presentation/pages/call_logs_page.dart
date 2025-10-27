import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:truecaller_clone/features/presentation/pages/settings_page.dart';
import '../../auth/data/repositories/call_logs_repository.dart';
import '../../auth/domain/entities/call_log-model.dart';
import '../bloc/call_logs_bloc.dart';
import '../bloc/call_logs_event.dart';
import '../bloc/call_logs_state.dart';
import '../widgets/call_log_item.dart';

class CallLogsPage extends StatelessWidget {
  const CallLogsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (_) => CallLogsRepository(),
      child: BlocProvider(
        create: (context) =>
        CallLogsBloc(repository: context.read<CallLogsRepository>())
          ..add(LoadCallLogs()),
        child: const CallLogsView(),
      ),
    );
  }
}

class CallLogsView extends StatelessWidget {
  const CallLogsView({super.key});

  void _onMenuSelected(BuildContext context, _MenuAction action) {
    final bloc = context.read<CallLogsBloc>();
    switch (action) {
      case _MenuAction.all:
        bloc.add(const FilterCallLogs(null));
        break;
      case _MenuAction.outgoing:
        bloc.add(const FilterCallLogs(CallType.outgoing));
        break;
      case _MenuAction.incoming:
        bloc.add(const FilterCallLogs(CallType.incoming));
        break;
      case _MenuAction.missed:
        bloc.add(const FilterCallLogs(CallType.missed));
        break;
      case _MenuAction.blocked:
        bloc.add(const FilterCallLogs(CallType.blocked));
        break;
      case _MenuAction.deleteAll:
        _confirmDeleteAll(context);
        break;
      case _MenuAction.settings:
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => const SettingsPage()));
        break;
    }
  }

  static void _confirmDeleteAll(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete all calls'),
        content: const Text(
            'Are you sure you want to delete all call logs? This action cannot be undone.'),
        actions: [
          TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              context.read<CallLogsBloc>().add(DeleteAllCallLogs());
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Call Logs'),
        actions: [
          PopupMenuButton<_MenuAction>(
            icon: const Icon(Icons.more_vert),
            onSelected: (action) => _onMenuSelected(context, action),
            itemBuilder: (ctx) => [
              const PopupMenuItem(
                  value: _MenuAction.all, child: Text('All calls')),
              const PopupMenuItem(
                  value: _MenuAction.outgoing, child: Text('Outgoing calls')),
              const PopupMenuItem(
                  value: _MenuAction.incoming, child: Text('Incoming calls')),
              const PopupMenuItem(
                  value: _MenuAction.missed, child: Text('Missed calls')),
              const PopupMenuItem(
                  value: _MenuAction.blocked, child: Text('Blocked calls')),
              const PopupMenuDivider(),
              const PopupMenuItem(
                  value: _MenuAction.deleteAll,
                  child: Text('Delete all calls')),
              const PopupMenuItem(
                  value: _MenuAction.settings, child: Text('Settings')),
            ],
          ),
        ],
      ),
      body: BlocBuilder<CallLogsBloc, CallLogsState>(
        builder: (context, state) {
          if (state is CallLogsLoading || state is CallLogsInitial) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CallLogsEmpty) {
            return const Center(child: Text('No call logs'));
          } else if (state is CallLogsError) {
            return Center(child: Text('Error: ${state.message}'));
          } else if (state is CallLogsLoaded) {
            return Column(
              children: [
                if (state.activeFilter != null)
                  Container(
                    width: double.infinity,
                    color: Colors.blue.shade50,
                    padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Filter: ${_friendlyFilter(state.activeFilter!)}'),
                        TextButton(
                          onPressed: () => context
                              .read<CallLogsBloc>()
                              .add(const FilterCallLogs(null)),
                          child: const Text('Clear'),
                        )
                      ],
                    ),
                  ),
                Expanded(
                  child: ListView.separated(
                    itemCount: state.callLogs.length,
                    separatorBuilder: (_, __) => const Divider(height: 1),
                    itemBuilder: (context, index) {
                      final item = state.callLogs[index];
                      return CallLogItem(
                        model: item,
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text(
                                    'Tapped ${item.name} (${item.number})')),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }

  String _friendlyFilter(CallType type) {
    switch (type) {
      case CallType.incoming:
        return 'Incoming';
      case CallType.outgoing:
        return 'Outgoing';
      case CallType.missed:
        return 'Missed';
      case CallType.blocked:
        return 'Blocked';
    }
  }
}

enum _MenuAction {
  all,
  outgoing,
  incoming,
  missed,
  blocked,
  deleteAll,
  settings,
}
