import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:tharadtech/features/Profile/data/model/profile_user_model.dart';
import 'package:tharadtech/features/Profile/domain/usecase/get_profile_use_case.dart';
import 'package:tharadtech/features/Profile/domain/usecase/update_profile_use_case.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this.getProfileUseCase, this.updateProfileUseCase)
    : super(ProfileInitial());

  static ProfileCubit get(context) => BlocProvider.of(context);
  final ImagePicker _imagePicker = ImagePicker();

  File? selectedImage;
  final GetProfileUseCase getProfileUseCase;
  final UpdateProfileUseCase updateProfileUseCase;

  Future<void> pickImageFromGallery() async {
    emit(ImagePickedProfileLoading());
    try {
      final XFile? pickedFile = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
        maxWidth: 800,
        maxHeight: 800,
      );

      if (pickedFile != null) {
        selectedImage = File(pickedFile.path);
        emit(ImagePickedProfileSuccess(image: selectedImage!));
      } else {
        emit(ImagePickedProfileError(error: 'No image selected'));
      }
    } catch (e) {
      String errorMessage = 'Failed to pick image';

      if (e.toString().contains('permission')) {
        errorMessage = 'Permission denied. Please grant storage access.';
      } else if (e.toString().contains('cancelled')) {
        errorMessage = 'Image selection was cancelled';
      } else {
        errorMessage = 'Failed to pick image: ${e.toString()}';
      }

      emit(ImagePickedProfileError(error: errorMessage));
    }
  }

  Future<void> pickImageFromCamera() async {
    emit(ImagePickedProfileLoading());
    try {
      final XFile? pickedFile = await _imagePicker.pickImage(
        source: ImageSource.camera,
        imageQuality: 80,
        maxWidth: 800,
        maxHeight: 800,
      );

      if (pickedFile != null) {
        selectedImage = File(pickedFile.path);
        emit(ImagePickedProfileSuccess(image: selectedImage!));
      } else {
        emit(ImagePickedProfileError(error: 'No image captured'));
      }
    } catch (e) {
      String errorMessage = 'Failed to capture image';

      if (e.toString().contains('permission')) {
        errorMessage = 'Permission denied. Please grant camera access.';
      } else if (e.toString().contains('cancelled')) {
        errorMessage = 'Camera capture was cancelled';
      } else {
        errorMessage = 'Failed to capture image: ${e.toString()}';
      }
      (errorMessage);
      emit(ImagePickedProfileError(error: errorMessage));
    }
  }

  void removeImage() {
    selectedImage = null;
    emit(ImagePickedProfileRemoved());
  }

  ProfileUserModel? userInMemo;

  Future<void> getProfile() async {
    if (userInMemo == null) emit(ProfileGetLoading());

    var data = await getProfileUseCase.execute();
    data.fold(
          (error) {
        if (userInMemo == null) emit(ProfileGetError(error: error));
      },
          (data) {
        userInMemo = data;
        emit(ProfileGetLoaded(profileUserModel: data));
      },
    );
  }

  void updateProfile({
    required String username,
    required String email,
    required String password,
    required String newPassword,
    required String newPasswordConfirmation,
    File? image,
  }) async {
    emit(ProfileUpdateLoading());
    var data = await updateProfileUseCase.execute(
      username: username,
      email: email,
      password: password,
      newPassword: newPassword,
      newPasswordConfirmation: newPasswordConfirmation,
      image: image,
    );
    data.fold(
      (error) {
        emit(ProfileGetError(error: error));
      },
      (r) async {
        selectedImage = null;
        await getProfile();
        emit(ProfileUpdateLoaded());
      },
    );
  }

  bool oldPassWord = false;
  bool passWord = false;
  bool confirm = false;

  void changeOldPassWord() {
    oldPassWord = !oldPassWord;
    emit(OldPassWordSuccessChange());
  }

  void changePassWord() {
    passWord = !passWord;
    emit(PassWordSuccessChange());
  }

  void changeConfirmPassWord() {
    confirm = !confirm;
    emit(ConfirmPassWordSuccessChange());
  }
}
