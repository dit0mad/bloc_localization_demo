import 'package:localization_demo/blocs/l10n_bloc/models/language_model.dart';

abstract class BaseLanguageAction {
  const BaseLanguageAction();
}

class ChangeLanguageAction extends BaseLanguageAction {
  final LanguageModel language;
  const ChangeLanguageAction({required this.language});
}

class InitializeLanguageAction extends BaseLanguageAction {
  const InitializeLanguageAction();
}

class LoadSavedLangauage extends BaseLanguageAction {
  const LoadSavedLangauage();
}

class RecoverFromErrorAction extends BaseLanguageAction {
  const RecoverFromErrorAction();
}
