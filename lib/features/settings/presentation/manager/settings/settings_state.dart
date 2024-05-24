part of 'settings_cubit.dart';

class SettingsState {
  final LanguageModel language;
  final bool darkMode;
  SettingsState({
    required this.language,
    this.darkMode = false,
  });


  String get locale {
    if (language.locale.languageCode == 'uz') {
      return 'O`zbek';
    }
    if (language.locale.languageCode == 'ru') {
      return 'Русский';
    }
    return 'English';
  }

  SettingsState copyWith({
    LanguageModel? language,
    bool? darkMode,
  }) {
    return SettingsState(
      language: language ?? this.language,
      darkMode: darkMode ?? this.darkMode,
    );
  }
}

