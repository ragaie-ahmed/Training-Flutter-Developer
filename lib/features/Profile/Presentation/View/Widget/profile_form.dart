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
    final localization = AppLocalizations.of(context);

    return BlocListener<ProfileCubit, ProfileState>(
      listener: _handleProfileStateChanges,
      child: BlocBuilder<ProfileCubit, ProfileState>(
        buildWhen: _shouldRebuild,
        builder: (context, state) {
          final cubit = context.read<ProfileCubit>();

          return Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildBasicInfoSection(localization),
                SizedBox(height: 24.h),
                _buildImageSection(cubit, localization),
                SizedBox(height: 24.h),
                _buildPasswordSection(localization, cubit),
                SizedBox(height: 32.h),
                _buildSubmitButton(localization, cubit, state),
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
      children: [
        CustomTextField(
          title: localization.translate('username_label'),
          hintText: localization.translate('username_hint'),
          controller: _nameController,
          validator: (v) => _validateUsername(v, localization),
        ),
        SizedBox(height: 12.h),
        CustomTextField(
          title: localization.translate('email_label'),
          hintText: localization.translate('email_hint'),
          controller: _emailController,
          validator: (v) => _validateEmail(v, localization),
          keyboardType: TextInputType.emailAddress,
        ),
      ],
    );
  }

  Widget _buildImageSection(ProfileCubit cubit, AppLocalizations localization) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              localization.translate('profile_image_label'),
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                fontFamily: 'Tajawal',
                color: Colors.grey.shade800,
              ),
            ),
            SizedBox(width: 20.w),
            _buildImagePickerButton(),
          ],
        ),
        SizedBox(height: 16.h),
        _buildImagePreview(cubit),
      ],
    );
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
            localization.translate('change_password_title'),
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, fontFamily: 'Tajawal'),
          ),
          SizedBox(height: 16.h),
          _buildPasswordField(
            localization.translate('old_password_label'),
            _oldPasswordController,
            cubit.oldPassWord,
            cubit.changeOldPassWord,
                (v) => _validateOldPassword(v, localization),
          ),
          SizedBox(height: 12.h),
          _buildPasswordField(
            localization.translate('new_password_label'),
            _newPasswordController,
            cubit.passWord,
            cubit.changePassWord,
                (v) => _validateNewPassword(v, localization),
          ),
          SizedBox(height: 12.h),
          _buildPasswordField(
            localization.translate('confirm_new_password_label'),
            _confirmPasswordController,
            cubit.confirm,
            cubit.changeConfirmPassWord,
                (v) => _validateConfirmPassword(v, localization),
          ),
        ],
      ),
    );
  }

  

  Widget _buildPasswordField(String? title, TextEditingController controller, bool isVisible, VoidCallback onToggle, String? Function(String?) validator) {
    return CustomTextField(
      title: title!,
      hintText: "********",
      controller: controller,
      obscureText: !isVisible,
      suffixIcon: isVisible ? Icons.visibility : Icons.visibility_off,
      onSuffixIconTap: onToggle,
      validator: validator,
    );
  }

  Widget _buildImagePickerButton() {
    return InkWell(
      onTap: () => _showImageSourceDialog(context),
      borderRadius: BorderRadius.circular(12.r),
      child: CircleAvatar(
        radius: 18.r,
        backgroundColor: Color(AppColor.primaryColor),
        child: Image.asset(Assets.camera, width: 20.w, height: 20.h, color: Colors.white),
      ),
    );
  }

  Widget _buildImagePreview(ProfileCubit cubit) {
    if (cubit.selectedImage != null) {
      return _buildImageFrame(
        Stack(
          children: [
            Image.file(cubit.selectedImage!, width: 170.w, height: 100.h, fit: BoxFit.cover),
            Positioned(top: 4, right: 4, child: _buildRemoveImageButton(cubit.removeImage)),
          ],
        ),
      );
    }
    if (widget.profileUserModel.image?.isNotEmpty ?? false) {
      return _buildImageFrame(
        Image.network(
          widget.profileUserModel.image!,
          width: 170.w,
          height: 100.h,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => _buildPlaceholderIcon(),
        ),
      );
    }
    return _buildPlaceholderIcon();
  }

  Widget _buildImageFrame(Widget child) => Container(clipBehavior: Clip.antiAlias, decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.r), border: Border.all(color: Colors.grey.shade300, width: 1.5)), child: child);

  Widget _buildRemoveImageButton(VoidCallback onRemove) => GestureDetector(onTap: onRemove, child: Container(padding: EdgeInsets.all(4.w), decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle), child: Icon(Icons.close_rounded, color: Colors.white, size: 16.sp)));

  Widget _buildPlaceholderIcon() => Container(width: 170.w, height: 100.h, decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(12.r), border: Border.all(color: Colors.grey.shade300)), child: Icon(Icons.person_rounded, size: 40.sp, color: Colors.grey.shade400));

  Widget _buildSubmitButton(AppLocalizations localization, ProfileCubit cubit, ProfileState state) {
    return CustomButton(
      isLoading: state is ProfileUpdateLoading,
      text: localization.translate('save_changes_btn'),
      onPressed: () => _handleSubmit(cubit),
    );
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

  

  String? _validateUsername(String? v, AppLocalizations loc) => (v == null || v.trim().isEmpty) ? loc.translate('error_name_required') : (v.trim().length < 3 ? loc.translate('error_name_short') : null);

  String? _validateEmail(String? v, AppLocalizations loc) => (v == null || v.trim().isEmpty) ? loc.translate('error_email_required') : (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(v) ? loc.translate('error_email_invalid') : null);

  String? _validateOldPassword(String? v, AppLocalizations loc) => (_newPasswordController.text.isNotEmpty && (v == null || v.isEmpty)) ? loc.translate('error_old_pass_required') : null;

  String? _validateNewPassword(String? v, AppLocalizations loc) {
    if (_oldPasswordController.text.isNotEmpty && (v == null || v.isEmpty)) return loc.translate('error_new_pass_required');
    if (v != null && v.isNotEmpty && !AppValidator.isPasswordStrong(v)) return loc.translate('error_pass_weak');
    return null;
  }

  String? _validateConfirmPassword(String? v, AppLocalizations loc) => (v != _newPasswordController.text) ? loc.translate('error_pass_mismatch') : null;

  void _showImageSourceDialog(BuildContext context) {
    final cubit = context.read<ProfileCubit>();
    final loc = AppLocalizations.of(context);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        title: Text(loc.translate('choose_image_source'), style: TextStyle(fontFamily: "Tajawal", fontSize: 16.sp, fontWeight: FontWeight.bold)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildImageSourceOption(Icons.photo_library, loc.translate('gallery'), () { Navigator.pop(ctx); cubit.pickImageFromGallery(); }),
            _buildImageSourceOption(Icons.camera_alt, loc.translate('camera'), () { Navigator.pop(ctx); cubit.pickImageFromCamera(); }),
          ],
        ),
      ),
    );
  }

  Widget _buildImageSourceOption(IconData icon, String title, VoidCallback onTap) => ListTile(leading: Icon(icon, color: Color(AppColor.primaryColor)), title: Text(title, style: TextStyle(fontFamily: "Tajawal", fontSize: 14.sp)), onTap: onTap);
}