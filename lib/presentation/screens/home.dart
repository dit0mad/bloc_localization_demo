import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localization_demo/blocs/l10n_bloc/action.dart';
import 'package:localization_demo/blocs/l10n_bloc/bloc.dart';
import 'package:localization_demo/blocs/l10n_bloc/models/language_model.dart';
import 'package:localization_demo/l10n/app_localizations.dart';



class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final LanguageBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = context.read<LanguageBloc>();
  }

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;

    final currentLanguage = bloc.state.currentLanguage;

    return Scaffold(
      appBar: AppBar(
        title: Text(locale.appTitle),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              locale.helloUser,
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            DropdownButton<LanguageModel>(
              value: currentLanguage,
              onChanged: (LanguageModel? newLanguage) {
                if (newLanguage != null) {
                  bloc.add(ChangeLanguageAction(language: newLanguage));
                }
              },
              items: LanguageModel.supportedLanguages.map((lang) {
                return DropdownMenuItem(
                  value: lang,
                  child: Text(lang.name),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
