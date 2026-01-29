import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome Back!",
              style: TextStyle(
                fontFamily: "Tajawal",
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              "Here's what's happening today",
              style: TextStyle(
                fontFamily: "Tajawal",
                fontSize: 14.sp,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
        
        
        Container(
          width: 50.w,
          height: 50.h,
          decoration: BoxDecoration(
            color: Colors.blue,
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.person,
            size: 24.w,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
