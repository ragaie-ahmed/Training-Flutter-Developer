import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tharadtech/core/helper/app_locclization.dart'; 
import 'package:tharadtech/generated/assets.dart';

class HomeBannerCard extends StatelessWidget {
  const HomeBannerCard({super.key});

  @override
  Widget build(BuildContext context) {
    
    final localization = AppLocalizations.of(context);

    return Container(
      width: 350.w,
      height: 120.h,
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        gradient: const LinearGradient(
          colors: [Color(0xFF4EB0AD), Color(0xFF1B523D)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        children: [
          SizedBox(height: 10.h),
          Image.asset(
            Assets.homePage,
            fit: BoxFit.fill,
          ),
          SizedBox(height: 2.h),
          Text(
            
            localization.translate('home_banner_text') ,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 15.sp,
              fontWeight: FontWeight.w700,
              fontFamily: 'Tajawal',
            ),
          ),
        ],
      ),
    );
  }
}