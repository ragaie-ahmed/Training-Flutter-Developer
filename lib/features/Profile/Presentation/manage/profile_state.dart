part of 'profile_cubit.dart';

@immutable
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}



class ProfileGetLoading extends ProfileState {}

class ProfileGetLoaded extends ProfileState {
  final ProfileUserModel profileUserModel;
  final bool isFromCache;

  ProfileGetLoaded({
    required this.profileUserModel,
    this.isFromCache = false,
  });
}

class ProfileGetError extends ProfileState {
  final String error;
  ProfileGetError({required this.error});
}



class ProfileUpdateLoading extends ProfileState {}

class ProfileUpdateLoaded extends ProfileState {}

class ProfileUpdateError extends ProfileState {
  final String error;
  ProfileUpdateError({required this.error});
}



class ImagePickedProfileLoading extends ProfileState {}

class ImagePickedProfileSuccess extends ProfileState {
  final File image;
  ImagePickedProfileSuccess({required this.image});
}

class ImagePickedProfileError extends ProfileState {
  final String error;
  ImagePickedProfileError({required this.error});
}

class ImagePickedProfileRemoved extends ProfileState {}



class OldPassWordSuccessChange extends ProfileState {}

class PassWordSuccessChange extends ProfileState {}

class ConfirmPassWordSuccessChange extends ProfileState {}