import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:tharadtech/features/Auth/domain/usecase/register_use_case.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit(this.registerUseCase) : super(RegisterInitial());

  static RegisterCubit get(context) => BlocProvider.of(context);
  final RegisterUseCase registerUseCase;
  final ImagePicker _imagePicker = ImagePicker();
  
  bool isPasswordVisible = false;
  File? selectedImage;

  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    emit(SuccessToggle());
  }

  bool isConfirmPasswordVisible = false;

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible = !isConfirmPasswordVisible;
    emit(SuccessToggleConfirm());
  }

  Future<void> pickImageFromGallery() async {
    emit(ImagePickingLoading());
    try {
      final XFile? pickedFile = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
        maxWidth: 800,
        maxHeight: 800,
      );
      
      if (pickedFile != null) {
        selectedImage = File(pickedFile.path);
        emit(ImagePickedSuccess(image: selectedImage!));
      } else {
        emit( ImagePickedError(error: 'No image selected'));
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
      
      emit(ImagePickedError(error: errorMessage));
    }
  }

  Future<void> pickImageFromCamera() async {
    emit(ImagePickingLoading());
    try {
      final XFile? pickedFile = await _imagePicker.pickImage(
        source: ImageSource.camera,
        imageQuality: 80,
        maxWidth: 800,
        maxHeight: 800,
      );
      
      if (pickedFile != null) {
        selectedImage = File(pickedFile.path);
        emit(ImagePickedSuccess(image: selectedImage!));
      } else {
        emit( ImagePickedError(error: 'No image captured'));
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
      emit(ImagePickedError(error: errorMessage));
    }
  }

  void removeImage() {
    selectedImage = null;
    emit(ImageRemoved());
  }

  void register({
    required String name,
    required String email,
    required String passWord,
    required String confirmPassWord,
  }) async {
    if (selectedImage == null) {
      emit( RegisterError(error: 'Please select an image'));
      return;
    }
    
    emit(RegisterLoading());
    var data = await registerUseCase.execute(
      name: name,
      email: email,
      image: selectedImage!,
      passWord: passWord,
      confirmPassWord: confirmPassWord,
    );
    data.fold(
      (error) {
        emit(RegisterError(error: error));
      },
      (data) {
        emit(RegisterLoaded());
      },
    );
  }
}
