import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localization_demo/blocs/l10n_bloc/action.dart';
import 'package:localization_demo/blocs/l10n_bloc/bloc.dart';
import 'package:localization_demo/repository/language_repo.dart';
import 'package:localization_demo/presentation/app/app.dart';

class AppDependencies extends StatelessWidget {
  const AppDependencies({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<LanguageRepository>(
          create: (_) => LanguageRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<LanguageBloc>(
            create: (context) => LanguageBloc(
              repo: context.read<LanguageRepository>(),
            )..add(const LoadSavedLangauage()),
          ),
        ],
        child: const MyApp(),
      ),
    );
  }
}
