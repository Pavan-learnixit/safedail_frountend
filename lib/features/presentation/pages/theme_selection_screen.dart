import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/theme_bloc.dart';

class ThemeSelectionScreen extends StatelessWidget {
  const ThemeSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Choose Theme',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.background,
        foregroundColor: Theme.of(context).colorScheme.onBackground,
        elevation: 0,
      ),

      body: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          final currentMode = state.themeMode;

          return ListView(
            children: [
              _buildOption(
                context,
                label: 'System Default',
                mode: ThemeMode.system,
                selected: currentMode == ThemeMode.system,
              ),
              _buildOption(
                context,
                label: 'Light Theme',
                mode: ThemeMode.light,
                selected: currentMode == ThemeMode.light,
              ),
              _buildOption(
                context,
                label: 'Dark Theme',
                mode: ThemeMode.dark,
                selected: currentMode == ThemeMode.dark,
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildOption(BuildContext context,
      {required String label,
        required ThemeMode mode,
        required bool selected}) {
    return ListTile(
      title: Text(
        label,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
      ),
      trailing: selected ? const Icon(Icons.check, color: Colors.blue) : null,
      onTap: () {
        final bloc = context.read<ThemeBloc>();
        switch (mode) {
          case ThemeMode.system:
            bloc.add(SetSystemTheme());
            break;
          case ThemeMode.light:
            bloc.add(SetLightTheme());
            break;
          case ThemeMode.dark:
            bloc.add(SetDarkTheme());
            break;
        }
      },
    );
  }
}
