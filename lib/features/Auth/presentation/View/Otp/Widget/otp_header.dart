import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tharadtech/core/helper/app_locclization.dart';
import 'package:tharadtech/generated/assets.dart';

class OtpHeader extends StatelessWidget {
  const OtpHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    return Column(
      children: [
        Center(child: Image.asset(Assets.logo, width: 150.w)),
        SizedBox(height: 50.h),
        Text(
          localization.translate('otp_title') ,
          style: TextStyle(
            fontFamily: "Tajawal",
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF2D140D),
          ),
        ),
        SizedBox(height: 10.h),
        Text(
          localization.translate('otp_subtitle'),
          textAlign: TextAlign.center,
          style: TextStyle(fontFamily: "Tajawal", fontSize: 14.sp, color: Colors.grey),
        ),
      ],
    );
  }
}