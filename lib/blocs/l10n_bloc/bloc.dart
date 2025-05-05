import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localization_demo/blocs/l10n_bloc/action.dart';
import 'package:localization_demo/blocs/l10n_bloc/state.dart';
import 'package:localization_demo/repository/language_repo.dart';

class LanguageBloc extends Bloc<BaseLanguageAction, LanguageState> {
  final LanguageRepository repo;
  LanguageBloc({
    required this.repo,
  }) : super(
          LanguageState.initial(),
        ) {
    on<ChangeLanguageAction>((event, emit) async {
      try {
        final languageWanted = event.language;

        final nextState = state.copyWith(
          currentLanguage: languageWanted,
        );

        emit(nextState);

        await saveLanguage(languageWanted.code, emit);
      } catch (e) {
        handleError(emit);
      }
    });

    on<LoadSavedLangauage>((event, emit) async {
      try {
        final savedLanguage = await repo.getSavedLanguage();

        final nextState = state.copyWith(
          currentLanguage: savedLanguage,
          status: LanguageStatus.initialized,
        );

        emit(nextState);
      } catch (e) {
        handleError(emit);
      }
    });

    on<RecoverFromErrorAction>((event, emit) {
      emit(state.copyWith(
        status: LanguageStatus.initialized,
      ));
    });
  }

  Future<void> saveLanguage(
      String languageCode, Emitter<LanguageState> emit) async {
    try {
      await repo.saveLanguage(languageCode);
    } catch (e) {
      handleError(emit);
    }
  }

  Future<void> handleError(Emitter<LanguageState> emit) async {
    final nextState = state.copyWith(
      status: LanguageStatus.error,
    );

    emit(nextState);

    await Future.delayed(const Duration(seconds: 2)).then((_) {
      if (!isClosed) {
        add(const RecoverFromErrorAction());
      }
    });
  }
}
