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
        // Logo
        Image.asset(
          Assets.logo,
          width: 120.w,
          height: 120.h,
        ),
        
        SizedBox(height: 40.h),
        
        // Title
        Text(
          "Welcome Back",
          style: TextStyle(
            fontFamily: "Tajawal",
            fontSize: 28.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        
        SizedBox(height: 12.h),
        
        // Subtitle
        Text(
          "Sign in to continue to your account",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: "Tajawal",
            fontSize: 16.sp,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
}
