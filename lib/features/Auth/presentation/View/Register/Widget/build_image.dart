import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tharadtech/core/helper/app_locclization.dart';
import 'package:tharadtech/features/Auth/presentation/View/Register/Widget/dashed_border_painter.dart';
import 'package:tharadtech/features/Auth/presentation/manage/register/register_cubit.dart';
import 'package:tharadtech/generated/assets.dart';

class BuildImage extends StatelessWidget {
  const BuildImage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterCubit, RegisterState>(
      builder: (context, state) {
        final cubit = context.read<RegisterCubit>();
        final selectedImage = cubit.selectedImage;

        return Column(
          children: [
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                AppLocalizations.of(context).translate('profile_picture_label'),
                style: TextStyle(fontFamily: "Tajawal", fontSize: 14.sp),
              ),
            ),
            SizedBox(height: 8.h),

            GestureDetector(
              onTap: () {
                if (selectedImage == null) {
                  _showImageSourceDialog(context);
                }
              },
              child: CustomPaint(
                painter: DashedBorderPainter(
                  color: const Color(0xFF1B523D),
                  radius: 16.r,
                ),
                child: Container(
                  height: 100.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: selectedImage != null
                      ? _buildSelectedImage(context, selectedImage, cubit)
                      : _buildImagePlaceholder(context),
                ),
              ),
            ),
            
            // Show error message if there's an image picker error
            if (state is ImagePickedError) ...[
              SizedBox(height: 8.h),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(color: Colors.red.withOpacity(0.3)),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.error_outline,
                      color: Colors.red,
                      size: 16.w,
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Text(
                        state.error,
                        style: TextStyle(
                          fontFamily: "Tajawal",
                          fontSize: 12.sp,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        );
      },
    );
  }

  Widget _buildSelectedImage(BuildContext context, File image, RegisterCubit cubit) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 100.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            image: DecorationImage(
              image: FileImage(image),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          top: 8.h,
          right: 8.w,
          child: GestureDetector(
            onTap: () {
              cubit.removeImage();
            },
            child: Container(
              width: 28.w,
              height: 28.h,
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.8),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.close,
                color: Colors.white,
                size: 16.w,
              ),
            ),
          ),
        ),
        if (cubit.state is ImagePickingLoading)
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.3),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Center(
                child: SizedBox(
                  width: 24.w,
                  height: 24.h,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.w,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildImagePlaceholder(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(Assets.camera, width: 30.w),
        SizedBox(height: 8.h),
        Text(
          AppLocalizations.of(context).translate('allowed_files_hint'),
          style: TextStyle(
            fontSize: 10.sp,
            color: Colors.grey,
            fontFamily: "Tajawal",
          ),
        ),
        Text(
          AppLocalizations.of(context).translate('max_size_hint'),
          style: TextStyle(
            fontSize: 10.sp,
            color: Colors.grey,
            fontFamily: "Tajawal",
          ),
        ),
      ],
    );
  }

  void _showImageSourceDialog(BuildContext context) {
    final cubit = context.read<RegisterCubit>();
    
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text(
            'Select Image Source',
            style: TextStyle(
              fontFamily: "Tajawal",
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.photo_library, size: 24.w),
                title: Text(
                  'Gallery',
                  style: TextStyle(
                    fontFamily: "Tajawal",
                    fontSize: 14.sp,
                  ),
                ),
                onTap: () {
                  Navigator.pop(dialogContext);
                  cubit.pickImageFromGallery();
                },
              ),
              ListTile(
                leading: Icon(Icons.camera_alt, size: 24.w),
                title: Text(
                  'Camera',
                  style: TextStyle(
                    fontFamily: "Tajawal",
                    fontSize: 14.sp,
                  ),
                ),
                onTap: () {
                  Navigator.pop(dialogContext);
                  cubit.pickImageFromCamera();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

