import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tharadtech/core/helper/app_locclization.dart';
import 'package:tharadtech/core/utils/app_color.dart';
import 'package:tharadtech/core/utils/pass_word_regular_expression.dart';
import 'package:tharadtech/features/Auth/presentation/View/Register/Widget/custom_button.dart';
import 'package:tharadtech/features/Auth/presentation/View/Register/Widget/custom_text_field.dart';
import 'package:tharadtech/features/Profile/Presentation/manage/profile_cubit.dart';
import 'package:tharadtech/features/Profile/data/model/profile_user_model.dart';
import 'package:tharadtech/generated/assets.dart';

class ProfileForm extends StatefulWidget {
  final ProfileUserModel profileUserModel;

  const ProfileForm({super.key, required this.profileUserModel});

  @override
  State<ProfileForm> createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {

  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _oldPasswordController;
  late final TextEditingController _newPasswordController;
  late final TextEditingController _confirmPasswordController;


  @override
  void initState() {
    super.initState();
    _initializeControllers();
  }

  void _initializeControllers() {
    _nameController = TextEditingController(text: widget.profileUserModel.username);
    _emailController = TextEditingController(text: widget.profileUserModel.email);
    _oldPasswordController = TextEditingController();
    _newPasswordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileCubit, ProfileState>(
      listener: _handleProfileStateChanges,
      child: BlocBuilder<ProfileCubit, ProfileState>(
        buildWhen: _shouldRebuild,
        builder: (context, state) {
          final localization = AppLocalizations.of(context);
          final cubit = context.read<ProfileCubit>();

          return Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildBasicInfoSection(localization),
                SizedBox(height: 24.h),
                _buildImageSection(cubit),
                SizedBox(height: 24.h),
                _buildPasswordSection(localization, cubit),
                SizedBox(height: 32.h),
                _buildSubmitButton(localization, cubit,state),
                SizedBox(height: 20.h),
              ],
            ),
          );
        },
      ),
    );
  }


  Widget _buildBasicInfoSection(AppLocalizations localization) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 16.h),
        CustomTextField(
          title: localization.translate('username_label'),
          hintText: "أدخل اسم المستخدم",
          controller: _nameController,
          validator: _validateUsername,
        ),
        SizedBox(height: 12.h),
        CustomTextField(
          title: localization.translate('email_label'),
          hintText: "أدخل البريد الإلكتروني",
          controller: _emailController,
          validator: _validateEmail,
          keyboardType: TextInputType.emailAddress,
        ),
      ],
    );
  }


  Widget _buildImageSection(ProfileCubit cubit) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "الصورة الشخصية",
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                fontFamily: 'Tajawal',
                color: Colors.grey.shade800,
              ),
            ),
            SizedBox(width: 40.w),
            _buildImagePickerButton(),
          ],
        ),
        SizedBox(height: 16.h),
        _buildImagePreview(cubit),
      ],
    );
  }

  Widget _buildImagePickerButton() {
    return InkWell(
      onTap: () => _showImageSourceDialog(context),
      borderRadius: BorderRadius.circular(12.r),
      child: CircleAvatar(
        radius: 18.r,
        backgroundColor: Color(AppColor.primaryColor),
        child: Image.asset(
          Assets.camera,
          width: 20.w,
          height: 20.h,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildImagePreview(ProfileCubit cubit) {
    if (cubit.selectedImage != null) {
      return _buildImageFrame(
        Stack(
          children: [
            Image.file(
              cubit.selectedImage!,
              width: 170.w,
              height: 100.h,
              fit: BoxFit.cover,
            ),
            Positioned(top: 4, right: 4, child: _buildRemoveImageButton(cubit.removeImage)),
          ],
        ),
      );
    }

    if (widget.profileUserModel.image != null && widget.profileUserModel.image!.isNotEmpty) {
      return _buildImageFrame(
        Image.network(
          widget.profileUserModel.image!,
          width: 170.w,
          height: 100.h,
          fit: BoxFit.cover,
          loadingBuilder: _imageLoadingBuilder,
          errorBuilder: (_, __, ___) => _buildPlaceholderIcon(),
        ),
      );
    }

    return _buildPlaceholderIcon();
  }


  Widget _buildPasswordSection(AppLocalizations localization, ProfileCubit cubit) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "تغيير كلمة المرور",
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, fontFamily: 'Tajawal'),
          ),
          SizedBox(height: 16.h),
          CustomTextField(
            title: localization.translate('old_password_label'),
            hintText: "********",
            controller: _oldPasswordController,
            obscureText: !cubit.oldPassWord,
            suffixIcon: cubit.oldPassWord ? Icons.visibility : Icons.visibility_off,
            onSuffixIconTap: cubit.changeOldPassWord,
            validator: _validateOldPassword,
          ),
          SizedBox(height: 12.h),
          CustomTextField(
            title: localization.translate('new_password_label'),
            hintText: "********",
            controller: _newPasswordController,
            obscureText: !cubit.passWord,
            suffixIcon: cubit.passWord ? Icons.visibility : Icons.visibility_off,
            onSuffixIconTap: cubit.changePassWord,
            validator: _validateNewPassword,
          ),
          SizedBox(height: 12.h),
          CustomTextField(
            title: localization.translate('confirm_new_password_label'),
            hintText: "********",
            controller: _confirmPasswordController,
            obscureText: !cubit.confirm,
            suffixIcon: cubit.confirm ? Icons.visibility : Icons.visibility_off,
            onSuffixIconTap: cubit.changeConfirmPassWord,
            validator: _validateConfirmPassword,
          ),
        ],
      ),
    );
  }


  Widget _buildSubmitButton(AppLocalizations localization, ProfileCubit cubit,ProfileState state) {
    return CustomButton(
      isLoading: state is ProfileUpdateLoading,
      text: localization.translate('save_changes_btn'),
      onPressed: () => _handleSubmit(cubit),
    );
  }


  Widget _buildImageFrame(Widget child) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey.shade300, width: 1.5),
      ),
      child: child,
    );
  }

  Widget _buildRemoveImageButton(VoidCallback onRemove) {
    return GestureDetector(
      onTap: onRemove,
      child: Container(
        padding: EdgeInsets.all(4.w),
        decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
        child: Icon(Icons.close_rounded, color: Colors.white, size: 16.sp),
      ),
    );
  }

  Widget _buildPlaceholderIcon() {
    return Container(
      width: 170.w,
      height: 100.h,
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Icon(Icons.person_rounded, size: 40.sp, color: Colors.grey.shade400),
    );
  }

  Widget _imageLoadingBuilder(context, child, loadingProgress) {
    if (loadingProgress == null) return child;
    return SizedBox(
      width: 170.w,
      height: 100.h,
      child: Center(child: CircularProgressIndicator(color: Color(AppColor.primaryColor))),
    );
  }



  bool _shouldRebuild(ProfileState previous, ProfileState current) {

    return current is PassWordSuccessChange ||
        current is ImagePickedProfileSuccess ||
        current is ImagePickedProfileRemoved ||
        current is OldPassWordSuccessChange ||
        current is ConfirmPassWordSuccessChange ||
        current is ProfileGetLoaded ||
        current is ProfileUpdateLoading ||
        current is ProfileUpdateError ||
        current is ProfileUpdateLoaded;
  }

  void _handleSubmit(ProfileCubit cubit) {

    if (cubit.state is ProfileUpdateLoading) return;

    if (_formKey.currentState!.validate()) {
      cubit.updateProfile(
        username: _nameController.text.trim(),
        email: _emailController.text.trim(),
        password: _oldPasswordController.text.trim(),
        newPassword: _newPasswordController.text.trim(),
        newPasswordConfirmation: _confirmPasswordController.text.trim(),
        image: cubit.selectedImage,
      );
    }
  }
  void _handleProfileStateChanges(BuildContext context, ProfileState state) {
    if (state is ProfileGetLoaded) {
      _nameController.text = state.profileUserModel.username ?? '';
      _emailController.text = state.profileUserModel.email ?? '';
      _oldPasswordController.clear();
      _newPasswordController.clear();
      _confirmPasswordController.clear();
    }
  }



  String? _validateUsername(String? value) {
    if (value == null || value.trim().isEmpty) return 'الاسم مطلوب';
    if (value.trim().length < 3) return 'الاسم قصير جداً';
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) return 'البريد الإلكتروني مطلوب';
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) return 'البريد غير صحيح';
    return null;
  }

  String? _validateOldPassword(String? value) {
    if (_newPasswordController.text.isNotEmpty && (value == null || value.isEmpty)) {
      return 'كلمة المرور الحالية مطلوبة';
    }
    return null;
  }

  String? _validateNewPassword(String? value) {
    if (_oldPasswordController.text.isNotEmpty && (value == null || value.isEmpty)) {
      return 'كلمة المرور الجديدة مطلوبة';
    }
    if (value != null && value.isNotEmpty && !AppValidator.isPasswordStrong(value)) {
      return 'كلمة المرور ضعيفة';
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value != _newPasswordController.text) return 'كلمات المرور غير متطابقة';
    return null;
  }


  void _showImageSourceDialog(BuildContext context) {
    final cubit = context.read<ProfileCubit>();
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        title: Text('اختر مصدر الصورة', style: TextStyle(fontFamily: "Tajawal", fontSize: 16.sp, fontWeight: FontWeight.bold)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildImageSourceOption(Icons.photo_library, 'المعرض', () {
              Navigator.pop(dialogContext);
              cubit.pickImageFromGallery();
            }),
            _buildImageSourceOption(Icons.camera_alt, 'الكاميرا', () {
              Navigator.pop(dialogContext);
              cubit.pickImageFromCamera();
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildImageSourceOption(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Color(AppColor.primaryColor)),
      title: Text(title, style: TextStyle(fontFamily: "Tajawal", fontSize: 14.sp)),
      onTap: onTap,
    );
  }
}