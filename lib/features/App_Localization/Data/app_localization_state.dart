part of 'app_localization_cubit.dart';
enum LanguageEvent{initLanguage,arabicLanguage,englishLanguage}

@immutable
abstract class AppLocalizationState {}

class AppLocalizationInitial extends AppLocalizationState {}
class AppLocalizationChange extends AppLocalizationState {
  final String?appLocal;

  AppLocalizationChange({required this.appLocal});
}
