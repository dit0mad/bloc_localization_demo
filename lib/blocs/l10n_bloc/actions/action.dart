import 'package:localization_demo/blocs/l10n_bloc/model/language_model.dart';

abstract class BaseLanguageAction {
  final LanguageModel language;

  const BaseLanguageAction({required this.language});
}

class ChangeLanguageAction extends BaseLanguageAction {
  const ChangeLanguageAction({required super.language});
}

class InitializeLanguageAction extends BaseLanguageAction {
  const InitializeLanguageAction({required super.language});
}

class LoadSavedLangauage extends BaseLanguageAction {
  const LoadSavedLangauage({required super.language});
}

class SaveLanguage extends BaseLanguageAction {
  const SaveLanguage({required super.language});
}
