import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:tharadtech/features/Auth/domain/usecase/opt_use_case.dart';

part 'otp_state.dart';

class OtpCubit extends Cubit<OtpState> {
  OtpCubit(this.otpUseCase) : super(OtpInitial());
  static OtpCubit get(context)=>BlocProvider.of(context);
  final OtpUseCase otpUseCase;

  void otp({  required String email,
    required String otp,})async{
    emit(OtpLoading());
    var data=await otpUseCase.execute(email: email, otp: otp);
    data.fold((error) {
      emit(OtpError(error: error));
    }, (data) {
      emit(OtpLoaded());
    },);
  }
}
