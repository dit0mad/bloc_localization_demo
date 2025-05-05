import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localization_demo/blocs/l10n_bloc/actions/action.dart';
import 'package:localization_demo/blocs/l10n_bloc/states/state.dart';
import 'package:localization_demo/repository/language_repo.dart';

class LanguageBloc extends Bloc<BaseLanguageAction, LanguageState> {
  final LanguageRepository repo;
  LanguageBloc({
    required this.repo,
  }) : super(
          LanguageState.initial(),
        ) {
    on<ChangeLanguageAction>((event, emit) {
      final languageWanted = event.language;

      final nextState = state.copyWith(
        currentLanguage: languageWanted,
        status: LanguageStatus.initialized,
      );

      emit(nextState);
    });

    on<LoadSavedLangauage>((event, emit) {
      //get repo

      try {} catch (e) {
        emit(LanguageState.initial());
      }
    });
  }
}
