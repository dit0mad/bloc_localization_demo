import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:localization_demo/blocs/l10n_bloc/action.dart';
import 'package:localization_demo/blocs/l10n_bloc/bloc.dart';
import 'package:localization_demo/blocs/l10n_bloc/models/language_model.dart';
import 'package:localization_demo/blocs/l10n_bloc/state.dart';
import 'package:localization_demo/repository/language_repo.dart';

// Simple mock class (no code generation required)
class MockLanguageRepository extends LanguageRepository {
  bool throwOnSave = false;
  bool throwOnGet = false;
  LanguageModel savedLanguage =
      const LanguageModel(code: 'en', name: 'English');

  @override
  Future<bool> saveLanguage(String languageCode) async {
    if (throwOnSave) throw Exception('Failed to save');
    return true;
  }

  @override
  Future<LanguageModel> getSavedLanguage() async {
    if (throwOnGet) throw Exception('Failed to get');
    return savedLanguage;
  }
}

void main() {
  late MockLanguageRepository mockRepository;
  late LanguageBloc languageBloc;

  const spanishLanguage = LanguageModel(code: 'es', name: 'Spanish');

  setUp(() {
    mockRepository = MockLanguageRepository();
    languageBloc = LanguageBloc(repo: mockRepository);
  });

  tearDown(() {
    languageBloc.close();
  });

  group('LanguageBloc', () {
    test('initial state should be correct', () {
      expect(languageBloc.state.status, equals(LanguageStatus.initial));
      expect(languageBloc.state.currentLanguage.code, equals('en'));
    });

    blocTest<LanguageBloc, LanguageState>(
      'should emit new state when language is changed',
      build: () => languageBloc,
      act: (bloc) =>
          bloc.add(const ChangeLanguageAction(language: spanishLanguage)),
      expect: () => [
        predicate<LanguageState>((state) =>
            state.currentLanguage.code == 'es' &&
            state.currentLanguage.name == 'Spanish'),
      ],
    );

    blocTest<LanguageBloc, LanguageState>(
      'should handle error when saving language fails, status should show error and then initialized',
      build: () {
        mockRepository.throwOnSave = true;
        return languageBloc;
      },
      act: (bloc) =>
          bloc.add(const ChangeLanguageAction(language: spanishLanguage)),
      expect: () => [
        predicate<LanguageState>((state) => state.currentLanguage.code == 'es'),
        predicate<LanguageState>(
            (state) => state.status == LanguageStatus.error),
        predicate<LanguageState>(
            (state) => state.status == LanguageStatus.initialized),
      ],
      wait: const Duration(seconds: 2),
    );

    blocTest(
      'should handle error when getting language fails, status should show error and then initialized',
      build: () {
        mockRepository.throwOnGet = true;
        return languageBloc;
      },
      act: (bloc) => bloc.add(const LoadSavedLangauage()),
      expect: () => [
        predicate<LanguageState>(
            (state) => state.status == LanguageStatus.error),
        predicate<LanguageState>(
            (state) => state.status == LanguageStatus.initialized),
      ],
      wait: const Duration(seconds: 2),
    );
  });
}
