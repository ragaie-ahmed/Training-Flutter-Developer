import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tharadtech/core/helper/app_locclization.dart';
import 'package:tharadtech/features/Profile/Presentation/View/Widget/profile_form.dart';
import 'package:tharadtech/features/Profile/Presentation/View/Widget/language_selector.dart';
import 'package:tharadtech/features/Profile/Presentation/manage/profile_cubit.dart';

class ProfileBody extends StatelessWidget {
  const ProfileBody({super.key});

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    final themeColor = const Color(0xFF1B523D);

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: BlocConsumer<ProfileCubit, ProfileState>(
        listenWhen: (prev, curr) =>
        curr is ProfileUpdateLoaded || curr is ProfileUpdateError || curr is ProfileGetError,
        listener: (context, state) {
          if (state is ProfileUpdateLoaded) {
            _showSnackBar(context, localization.translate('profile_updated_success'), Colors.green, Icons.check_circle);
            // إعادة جلب البيانات لتحديث الـ UI بالبيانات الجديدة
            ProfileCubit.get(context).getProfile();
          } else if (state is ProfileUpdateError) {
            _showSnackBar(context, state.error, Colors.red, Icons.error);
          }
        },
        buildWhen: (prev, curr) =>
        curr is ProfileGetLoaded || curr is ProfileGetLoading || curr is ProfileGetError || curr is ProfileUpdateLoaded,
        builder: (context, state) {
          return RefreshIndicator(
            onRefresh: () => ProfileCubit.get(context).getProfile(),
            color: themeColor,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildLanguageButton(context, localization),
                  SizedBox(height: 20.h),

                  if (state is ProfileGetLoaded)
                    ProfileForm(profileUserModel: state.profileUserModel)
                  else if (state is ProfileGetLoading)
                      _buildLoadingState(themeColor)
                    else if (state is ProfileGetError)
                        _buildErrorState(state.error, themeColor, context)
                      else
                        const SizedBox.shrink(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildLanguageButton(BuildContext context, AppLocalizations localization) {
    return GestureDetector(
      onTap: () => showModalBottomSheet(
        context: context,
        builder: (context) => LanguageBottomSheet(localization: localization),
      ),
      child: const Text("English  🌐  ", style: TextStyle(fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildLoadingState(Color color) {
    return Container(
      height: 200.h,
      alignment: Alignment.center,
      child: CircularProgressIndicator(color: color),
    );
  }

  Widget _buildErrorState(String error, Color color, BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(error, style: const TextStyle(color: Colors.red)),
          TextButton(onPressed: () => ProfileCubit.get(context).getProfile(), child: const Text("إعادة المحاولة")),
        ],
      ),
    );
  }

  void _showSnackBar(BuildContext context, String msg, Color color, IconData icon) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(children: [Icon(icon, color: Colors.white), SizedBox(width: 10.w), Text(msg)]),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}