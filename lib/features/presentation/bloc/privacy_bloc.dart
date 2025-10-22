import 'package:flutter_bloc/flutter_bloc.dart';

/// Events
abstract class PrivacyEvent {}

class LoadPrivacySettings extends PrivacyEvent {}

class TogglePrivacySetting extends PrivacyEvent {
  final String key;
  final bool value;
  TogglePrivacySetting(this.key, this.value);
}

/// State
class PrivacyState {
  final Map<String, bool> settings;
  const PrivacyState(this.settings);
}

/// Bloc
class PrivacyBloc extends Bloc<PrivacyEvent, PrivacyState> {
  PrivacyBloc() : super(const PrivacyState(_initialSettings)) {
    on<LoadPrivacySettings>((event, emit) {
      // In real app, load from local storage
      emit(PrivacyState(state.settings));
    });

    on<TogglePrivacySetting>((event, emit) {
      final updated = Map<String, bool>.from(state.settings);
      updated[event.key] = event.value;
      emit(PrivacyState(updated));
      // In real app, persist to local storage
    });
  }

  static const Map<String, bool> _initialSettings = {
    'availability': false,
    'profile_notifications': true,
    'view_privately': false,
    'search_privately': false,
    'ad_personalization': true,
    'share_fraud': true,
    'social_graph': false,
  };
}
