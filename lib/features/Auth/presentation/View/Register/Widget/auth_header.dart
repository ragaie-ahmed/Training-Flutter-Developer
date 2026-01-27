import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthHeader extends StatelessWidget {
  final String title;
  final String? logoAsset;

  const AuthHeader({
    super.key,
    required this.title,
    this.logoAsset,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (logoAsset != null) ...[
          Image.asset(
            logoAsset!,
            width: 120.w,
            height: 120.h,
          ),
        ],
        Text(
          title,
          style: TextStyle(
            fontFamily: "Tajawal",
            fontSize: 28.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 8.h),

      ],
    );
  }
}
