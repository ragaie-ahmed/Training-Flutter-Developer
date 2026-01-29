part of 'register_cubit.dart';

@immutable
abstract class RegisterState {}

class RegisterInitial extends RegisterState {}
class SuccessToggle extends RegisterState {}
class SuccessToggleConfirm extends RegisterState {}
class RegisterLoading extends RegisterState {}
class RegisterLoaded extends RegisterState {}
class RegisterError extends RegisterState {
  final String error;

  RegisterError({required this.error});
}


class ImagePickingLoading extends RegisterState {}
class ImagePickedSuccess extends RegisterState {
  final File image;

  ImagePickedSuccess({required this.image});
}
class ImagePickedError extends RegisterState {
  final String error;

  ImagePickedError({required this.error});
}
class ImageRemoved extends RegisterState {}

