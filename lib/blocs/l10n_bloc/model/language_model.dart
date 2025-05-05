class LanguageModel {
  final String code;
  final String name;

  const LanguageModel({required this.code, required this.name});

  //add all supported language models
  static const List<LanguageModel> supportedLanguages = [
    LanguageModel(
      code: 'en',
      name: 'English',
    ),
    LanguageModel(
      code: 'es',
      name: 'Spanish',
    ),
  ];
}
