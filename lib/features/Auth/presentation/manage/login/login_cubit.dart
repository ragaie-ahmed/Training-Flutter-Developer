import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:tharadtech/features/Auth/domain/usecase/log_in_use_case.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.logInUseCase) : super(LoginInitial());
  static LoginCubit get(context)=>BlocProvider.of(context);
  final LogInUseCase logInUseCase;
  bool isPassWord=false;
  void togglePassWord(){
    isPassWord=!isPassWord;
    emit(SuccessTogglePassWord());
  }
  void logIn({required String email, required String passWord})async{
    emit(LoginLoading());
    var data =await logInUseCase.execute(email: email, passWord: passWord);
    data.fold((error) {
      emit(LoginError(error: error));
    }, (data) {
      emit(LoginLoaded());
    },);
  }
}
