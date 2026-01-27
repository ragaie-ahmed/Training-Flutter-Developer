import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tharadtech/core/helper/shared_pref_service.dart';

part 'app_localization_state.dart';

class AppLocalizationCubit extends Cubit<AppLocalizationState> {
  AppLocalizationCubit() : super(AppLocalizationInitial());

  changeLanguage(LanguageEvent languageEvent) async {
    switch (languageEvent) {
      case LanguageEvent.initLanguage:
        if (SharedPrefService.getSecuredString( "lang") == "ar")
          {
            emit(AppLocalizationChange(appLocal: "ar"));
          }
        else{
          emit(AppLocalizationChange(appLocal: "en"));
        }
          break;
      case LanguageEvent.arabicLanguage:
        await SharedPrefService.setSecuredString( "lang",  "ar");
        emit(AppLocalizationChange(appLocal: "ar"));
        break;

      case LanguageEvent.englishLanguage:
        await SharedPrefService.setSecuredString( "lang",  "en");
        emit(AppLocalizationChange(appLocal: "en"));
        break;
    }
  }
}
