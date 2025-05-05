import 'package:shared_preferences/shared_preferences.dart';

import '../blocs/l10n_bloc/models/language_model.dart';

class LanguageRepository {
  static const String _key = 'language_code';

  Future<String> getSavedLanguageCode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_key) ?? 'en';
  }

  Future<LanguageModel> getSavedLanguage() async {
    final code = await getSavedLanguageCode();

    try {
      return LanguageModel.supportedLanguages
          .firstWhere((lang) => lang.code == code);
    } catch (_) {
      return LanguageModel.supportedLanguages.first;
    }
  }

  Future<bool> saveLanguage(String languageCode) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return await prefs.setString(_key, languageCode);
    } catch (e) {
      throw Exception('Failed to save language preference: $e');
    }
  }
}
