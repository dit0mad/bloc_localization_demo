import 'package:localization_demo/blocs/l10n_bloc/models/language_model.dart';

//lets define our states

enum LanguageStatus { initial, initializing, initialized, error }

class LanguageState {
  final LanguageStatus status;
  final LanguageModel currentLanguage;

  const LanguageState({
    required this.currentLanguage,
    required this.status,
  });

  //we gurantee that the first language is available.
  factory LanguageState.initial() => LanguageState(
        status: LanguageStatus.initial,
        currentLanguage: LanguageModel.supportedLanguages.first,
      );

  LanguageState copyWith({
    LanguageModel? currentLanguage,
    LanguageStatus? status,
  }) {
    return LanguageState(
      currentLanguage: currentLanguage ?? this.currentLanguage,
      status: status ?? this.status,
    );
  }
}
