import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tharadtech/features/Auth/presentation/View/Otp/Widget/otp_form.dart';
import 'package:tharadtech/features/Auth/presentation/View/Otp/Widget/otp_header.dart';

class OtpBody extends StatelessWidget {
  const OtpBody({super.key, required this.email});
final String  email;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                SizedBox(height: 60.h),
                const OtpHeader(),
                SizedBox(height: 40.h),
                 OtpForm(email: email,),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}