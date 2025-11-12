import 'package:get/get.dart';

class TranslationModel extends Translations {
  final Map<String, Map<String, String>>? languages;

  TranslationModel({required this.languages});

  @override
  Map<String, Map<String, String>> get keys {
    return languages!;
  }
}
