import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tharadtech/core/helper/logger.dart';

class SimpleBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    loggerDebug(change.toString());
    super.onChange(bloc, change);
  }

  @override
  void onClose(BlocBase bloc) {
    loggerError(bloc.toString());
    super.onClose(bloc);
  }

  @override
  void onCreate(BlocBase bloc) {
    loggerInfo(bloc.toString());
    super.onCreate(bloc);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    loggerTrace(bloc.toString());
    super.onTransition(bloc, transition);
  }
}
