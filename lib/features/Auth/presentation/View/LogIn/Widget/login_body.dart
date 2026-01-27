import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tharadtech/core/helper/app_locclization.dart';
import 'package:tharadtech/features/Auth/presentation/View/LogIn/Widget/login_form.dart';
import 'package:tharadtech/features/Auth/presentation/View/LogIn/Widget/login_header.dart';
import 'package:tharadtech/features/Auth/presentation/View/Register/Widget/auth_footer.dart';

class LoginBody extends StatelessWidget {
  const LoginBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 60.h),
                const LoginHeader(),
                SizedBox(height: 50.h),
                const LoginForm(),
                SizedBox(height: 40.h),
                AuthFooter(
                  questionText:  AppLocalizations.of(context).translate(
                    'already_have_account',
                  ),
                  actionText:  AppLocalizations.of(context).translate('sign_in_action'),
                  onActionTap: () {},
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
