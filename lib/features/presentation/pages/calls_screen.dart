import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:truecaller_clone/features/presentation/pages/profile_page.dart';
import 'package:truecaller_clone/features/presentation/widgets/search_bar.dart';
import 'package:truecaller_clone/features/presentation/widgets/call_widget.dart';

import '../../auth/data/repositories/call_logs_repository.dart';
import '../bloc/call_logs_bloc.dart';
import '../bloc/call_logs_event.dart';
import '../bloc/call_logs_state.dart';
import 'call_logs_page.dart';
import 'contacts_page.dart';

class CallsScreen extends StatelessWidget {
  const CallsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (_) => CallLogsRepository(),
      child: BlocProvider(
        create: (context) =>
        CallLogsBloc(repository: context.read<CallLogsRepository>())
          ..add(LoadCallLogs()),
        child: const CallsView(),
      ),
    );
  }
}

class CallsView extends StatefulWidget {
  const CallsView({super.key});

  @override
  State<CallsView> createState() => _CallsViewState();
}

class _CallsViewState extends State<CallsView> {
  TextEditingController searchController = TextEditingController();
  bool isEnabled = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              buildSearchBar(
                context: context,
                controller: searchController,
                suffixOnPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const CallLogsPage()),
                  );
                },
                prefixOnPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const ProfilePage()),
                  );
                },
                onSubmitted: (value) {},
                height: 60,
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buttons(
                    theme: theme,
                    icon: Icons.contact_phone,
                    text: "Contacts",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const ContactsPage()),
                      );
                    },
                  ),
                  _buttons(
                    theme: theme,
                    icon: Icons.favorite,
                    text: "Favorites",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) =>
                            const PlaceholderPage(title: "Favorites Page")),
                      );
                    },
                  ),
                  _buttons(
                    theme: theme,
                    icon: Icons.whatshot,
                    text: "Voice HD",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) =>
                            const PlaceholderPage(title: "Voice HD Page")),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              if (isEnabled) customCard(theme),
              if (isEnabled) const SizedBox(height: 10),

              Expanded(
                child: BlocBuilder<CallLogsBloc, CallLogsState>(
                  builder: (context, state) {
                    if (state is CallLogsLoading || state is CallLogsInitial) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is CallLogsEmpty) {
                      return const Center(child: Text("No call logs"));
                    } else if (state is CallLogsError) {
                      return Center(child: Text("Error: ${state.message}"));
                    } else if (state is CallLogsLoaded) {
                      return ListView.separated(
                        itemCount: state.callLogs.length,
                        separatorBuilder: (_, __) => const Divider(height: 15),
                        itemBuilder: (context, index) {
                          final log = state.callLogs[index];
                          final name = log.name;
                          final char =
                          name.isNotEmpty ? name[0].toUpperCase() : '?';
                          final duration = "${log.durationSeconds}s";
                          final time =
                          TimeOfDay.fromDateTime(log.time).format(context);

                          return CallWidget(
                            char: char,
                            label: duration,
                            name: name,
                            time: time,
                            isFraud: name.toLowerCase().contains("spam"),
                            onCallPressed: () {
                              // TODO: implement call action
                            },
                          );
                        },
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buttons({
    required ThemeData theme,
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceVariant,
          borderRadius: const BorderRadius.all(Radius.circular(15)),
        ),
        height: MediaQuery.sizeOf(context).height * 0.09,
        width: MediaQuery.sizeOf(context).width * 0.25,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 30, color: theme.colorScheme.onSurface),
              const SizedBox(height: 10),
              Text(
                text,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget customCard(ThemeData theme) {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.23,
      width: MediaQuery.sizeOf(context).width,
      decoration: BoxDecoration(
        border: Border.all(color: theme.dividerColor),
        borderRadius: const BorderRadius.all(Radius.circular(15)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Enable Advanced Blocking",
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Unlock premium for stronger offline protection and auto block spammers",
                    style: theme.textTheme.bodyMedium,
                  ),
                  Row(
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: const Text("Learn More"),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            isEnabled = false;
                          });
                        },
                        child: const Text("Dismiss"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 20),
            const SizedBox(height: 70, width: 50, child: Placeholder()),
          ],
        ),
      ),
    );
  }
}

/// Placeholder page for Favorites / Voice HD
class PlaceholderPage extends StatelessWidget {
  final String title;
  const PlaceholderPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Text(
          "$title content coming soon...",
          style: theme.textTheme.bodyLarge,
        ),
      ),
    );
  }
}
