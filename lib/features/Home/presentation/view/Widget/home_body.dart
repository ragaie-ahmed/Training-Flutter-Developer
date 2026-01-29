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
        final localization = AppLocalizations.of(context);

        bool isProfilePage = cubit.currentIndex == 1;
        String currentTitle = isProfilePage
            ? (localization.translate('profile_title') )
            : (localization.translate('welcome_msg') );

        return Scaffold(
          
          backgroundColor: Colors.white,

          appBar: CustomHomeAppBar(title: currentTitle, isProfile: isProfilePage==true?false:true),
          bottomNavigationBar: _buildBottomBar(context, cubit, localization),

          body: Stack(
            children: [
              
              Container(
                height: 30.h,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF4EB0AD), Color(0xFF1B523D)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
              ),

              
              Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[50], 
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
                  child: cubit.screens[cubit.currentIndex],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

}  Widget _buildBottomBar(BuildContext context, HomeScreenCubit cubit, AppLocalizations localization) {
    return Container(
      height: 73.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.r)),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 15.r, offset: const Offset(0, -5))],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(context, Assets.home, localization.translate('home') , 0),
          _buildNavItem(context, Assets.profile, localization.translate('my_account'), 1),
        ],
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, String icon, String label, int index) {
    final isSelected = HomeScreenCubit.get(context).currentIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => HomeScreenCubit.get(context).changeBottomNavigationItem(index),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(icon, width: 24.w, color: isSelected ? Color(AppColor.primaryColor) : Colors.grey[400]),
            Text(label, style: TextStyle(fontSize: 11.sp, fontWeight: isSelected ? FontWeight.bold : FontWeight.w500, color: isSelected ? const Color(0xFF1B523D) : Colors.grey)),
          ],
        ),
      ),
    );
  }

