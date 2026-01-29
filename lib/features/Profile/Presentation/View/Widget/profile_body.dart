import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:tharadtech/core/api/service_locator.dart';
import 'package:tharadtech/core/errors/show_app_snack_bar.dart';
import 'package:tharadtech/core/helper/app_locclization.dart';
import 'package:tharadtech/core/helper/on_generate_routes.dart';
import 'package:tharadtech/core/utils/constant.dart';
import 'package:tharadtech/features/Auth/domain/usecase/log_out_use_case.dart';
import 'package:tharadtech/features/Auth/presentation/manage/logout/log_out_cubit.dart';
import 'package:tharadtech/features/Profile/Presentation/View/Widget/profile_form.dart';
import 'package:tharadtech/features/Profile/Presentation/View/Widget/language_selector.dart';
import 'package:tharadtech/features/Profile/Presentation/manage/profile_cubit.dart';
import 'package:tharadtech/features/Profile/data/model/profile_user_model.dart';

class ProfileBody extends StatelessWidget {
  const ProfileBody({super.key});

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    const themeColor = Color(0xFF1B523D);
    final cubit = context.read<ProfileCubit>();

    
    if (cubit.userInMemo == null && cubit.state is! ProfileGetLoading) {
      cubit.getProfile();
    }

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: BlocConsumer<ProfileCubit, ProfileState>(
        buildWhen: (prev, curr) =>
        curr is ProfileGetLoaded || curr is ProfileGetLoading || curr is ProfileGetError,
        listenWhen: (prev, curr) =>
        curr is ProfileUpdateLoaded || curr is ProfileUpdateError,
        listener: (context, state) => _onUpdateState(context, state, localization),
        builder: (context, state) {
          final user = cubit.userInMemo;

          return RefreshIndicator(
            onRefresh: () => cubit.getProfile(),
            color: themeColor,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTopBar(context, localization),
                  SizedBox(height: 20.h),
                  _buildMainContent(state, user, themeColor, context),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildMainContent(ProfileState state, ProfileUserModel? user, Color color, BuildContext context) {
    if (user != null) return ProfileForm(profileUserModel: user);
    if (state is ProfileGetLoading) return _buildLoadingState(color);
    if (state is ProfileGetError) return _buildErrorState(state.error, color, context);
    return const SizedBox.shrink();
  }

  Widget _buildTopBar(BuildContext context, AppLocalizations localization) {
    return Align(
      alignment: AlignmentDirectional.topEnd,
      child: _buildLanguageButton(context, localization),
    );
  }

  void _onUpdateState(BuildContext context, ProfileState state, AppLocalizations localization) {
    if (state is ProfileUpdateLoaded) {
      showAppSnackBar(context: context, message: localization.translate('profile_updated_success'), isError: false);
    } else if (state is ProfileUpdateError) {
      showAppSnackBar(context: context, message: state.error, isError: true);
    }
  }

  Widget _buildLanguageButton(BuildContext context, AppLocalizations loc) {
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    return BlocProvider(
      create: (context) => LogOutCubit(getit.get<LogOutUseCase>()),
      child: BlocConsumer<LogOutCubit, LogOutState>(
        listener: (context, state) async {
          if (state is LogOutLoaded) {
            
            context.read<ProfileCubit>().clearUserData();
            var box = Hive.box<ProfileUserModel>(Constant.kProfileBox);
            await box.delete(Constant.kProfileKey);
            context.go(AppRoutes.logIn);
          }
          if (state is LogOutError) showAppSnackBar(context: context, message: state.error, isError: true);
        },
        builder: (context, state) => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildActionButton(
              onTap: () => context.read<LogOutCubit>().logOut(),
              label: state is LogOutLoading ? "..." : (isAr ? "تسجيل الخروج" : "Logout"),
            ),
            _buildActionButton(
              onTap: () => showModalBottomSheet(
                context: context,
                builder: (context) => LanguageBottomSheet(localization: loc),
              ),
              label: isAr ? "🌐 العربية" : "English 🌐",
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton({required VoidCallback onTap, required String label}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Text(label, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.sp, fontFamily: 'Tajawal')),
      ),
    );
  }

  Widget _buildLoadingState(Color color) => Container(height: 300.h, alignment: Alignment.center, child: CircularProgressIndicator(color: color));

  Widget _buildErrorState(String error, Color color, BuildContext context) => Center(
    child: Column(
      children: [
        Text(error, style: const TextStyle(color: Colors.red)),
        TextButton(onPressed: () => context.read<ProfileCubit>().getProfile(), child: const Text("إعادة المحاولة")),
      ],
    ),
  );
}