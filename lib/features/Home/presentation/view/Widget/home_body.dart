import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tharadtech/core/helper/app_locclization.dart';
import 'package:tharadtech/core/utils/app_color.dart';
import 'package:tharadtech/features/Home/presentation/manage/home_screen/home_screen_cubit.dart';
import 'package:tharadtech/features/Home/presentation/view/Widget/custom_app_bar.dart';
import 'package:tharadtech/generated/assets.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeScreenCubit, HomeScreenState>(
      builder: (context, state) {
        var cubit = HomeScreenCubit.get(context);
        final localization = AppLocalizations.of(context)!;
        String currentTitle = cubit.currentIndex == 0
            ? (localization.translate('welcome_msg') ?? "مرحبا ثراء تك !")
            : (localization.translate('profile_title') ?? "الملف الشخصي");
        return Scaffold(
          appBar: CustomHomeAppBar(title: currentTitle,profile: currentTitle!=0?true:false,),
          body: cubit.screens[cubit.currentIndex],

          bottomNavigationBar: Container(
            height: 73.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25.r),
                topRight: Radius.circular(25.r),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 15.r,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildBottomNavItem(
                    context: context,
                    imagePath: Assets.home,
                    label: localization.translate('home') ?? 'الرئيسية',
                    index: 0,
                  ),
                  _buildBottomNavItem(
                    context: context,
                    imagePath: Assets.profile, 
                    label: localization.translate('my_account') ?? 'حسابي',
                    index: 1, 
                  ),

                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildBottomNavItem({
    required BuildContext context,
    required String imagePath,
    required String label,
    required int index,
  }) {
    final isSelected = HomeScreenCubit.get(context).currentIndex == index;
    final themeColor = const Color(0xFF1B523D); 

    return Expanded(
      child: GestureDetector(
        onTap: () => HomeScreenCubit.get(context).changeBottomNavigationItem(index),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
              width: 24.w,
              height: 24.h,
              fit: BoxFit.contain,
              color: isSelected ? Color(AppColor.primaryColor) : Colors.grey[400],
              colorBlendMode: BlendMode.srcIn,
            ),
            SizedBox(height: 2.h),
            Text(
              label,
              style: TextStyle(
                fontSize: 11.sp,
                fontFamily: 'Tajawal',
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                color: isSelected ? themeColor : Colors.grey[500],
              ),
            ),
          ],
        ),
      ),
    );
  }
}