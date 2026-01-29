import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tharadtech/generated/assets.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        
        Image.asset(
          Assets.logo,
          width: 120.w,
          height: 120.h,
        ),
        
        SizedBox(height: 30.h),
        

        
        
        Text(
          "تسجيل الدخول",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: "Tajawal",
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
            color: Color(0xff0D1D1E),
          ),
        ),
      ],
    );
  }
}
