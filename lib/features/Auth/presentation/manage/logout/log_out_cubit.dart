import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:tharadtech/core/helper/shared_pref_service.dart';
import 'package:tharadtech/features/Auth/domain/usecase/log_out_use_case.dart';

part 'log_out_state.dart';

class LogOutCubit extends Cubit<LogOutState> {
  LogOutCubit(this.logOutUseCase) : super(LogOutInitial());
  static LogOutCubit get(context)=>BlocProvider.of(context);
  final LogOutUseCase logOutUseCase;
  void logOut()async{
    emit(LogOutLoading());
    var data =await logOutUseCase.execute();
    data.fold((error) {
      emit(LogOutError(error: error));
    }, (data) async{
await SharedPrefService.deleteData(SharedPrefService.storedToken);
      emit(LogOutLoaded());

    },);
  }
}
