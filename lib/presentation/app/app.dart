// lib/presentation/app/app_dependencies.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localization_demo/blocs/l10n_bloc/bloc.dart';
import 'package:localization_demo/blocs/l10n_bloc/state.dart';
import 'package:localization_demo/l10n/app_localizations.dart';
import 'package:localization_demo/presentation/screens/home.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageBloc, LanguageState>(
      builder: (context, state) {
        if (state.status == LanguageStatus.initial) {
          return const MaterialApp(
            home: Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }

        if (state.status == LanguageStatus.error) {
          return MaterialApp(
            home: Scaffold(
              appBar: AppBar(
                title: const Text('Error'),
              ),
              body: const Center(
                child: Text('Failed to load localization'),
              ),
            ),
          );
        }
        return MaterialApp(
          locale: state.currentLanguage.locale,
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          home: const MyHomePage(),
        );
      },
    );
  }
}
