part of 'log_out_cubit.dart';

@immutable
abstract class LogOutState {}

class LogOutInitial extends LogOutState {}
class LogOutLoading extends LogOutState {}
class LogOutLoaded extends LogOutState {}
class LogOutError extends LogOutState {
  final String error;

  LogOutError({required this.error});
}
