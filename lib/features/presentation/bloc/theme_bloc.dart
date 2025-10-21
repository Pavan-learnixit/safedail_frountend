import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Events
abstract class ThemeEvent {}

class SetLightTheme extends ThemeEvent {}
class SetDarkTheme extends ThemeEvent {}
class SetSystemTheme extends ThemeEvent {}

/// State
class ThemeState {
  final ThemeMode themeMode;
  const ThemeState(this.themeMode);
}

/// Bloc
class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(const ThemeState(ThemeMode.system)) {
    on<SetLightTheme>((event, emit) => emit(const ThemeState(ThemeMode.light)));
    on<SetDarkTheme>((event, emit) => emit(const ThemeState(ThemeMode.dark)));
    on<SetSystemTheme>((event, emit) => emit(const ThemeState(ThemeMode.system)));
  }
}
