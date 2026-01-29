import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tharadtech/core/helper/app_locclization.dart';
import 'package:tharadtech/core/helper/on_generate_routes.dart';
import 'package:tharadtech/features/Auth/presentation/View/LogIn/Widget/login_form.dart';
import 'package:tharadtech/features/Auth/presentation/View/LogIn/Widget/login_header.dart';
import 'package:tharadtech/features/Auth/presentation/View/Register/Widget/auth_footer.dart';
import 'package:tharadtech/features/Profile/Presentation/View/Widget/language_selector.dart';

class LoginBody extends StatelessWidget {
  const LoginBody({super.key});

  @override
  Widget build(BuildContext context) {
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    final localization = AppLocalizations.of(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20.h),

                
                Align(
                  alignment: AlignmentDirectional.topEnd,
                  child: GestureDetector(
                    onTap: () => showModalBottomSheet(
                      context: context,
                      builder: (context) => LanguageBottomSheet(
                        localization: localization,
                      ),
                    ),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 8.h,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.r),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Text(
                        isArabic ? "🌐 اللغة العربية" : "🌐 English",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13.sp,
                          fontFamily: 'Tajawal',
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 40.h),
                const LoginHeader(),
                SizedBox(height: 50.h),
                const LoginForm(),
                SizedBox(height: 40.h),

                
                AuthFooter(
                  questionText: localization.translate('not_have_account'),
                  actionText: localization.translate('sign_up_action'),
                  onActionTap: () {
                    print('Navigating to register...'); 

                    context.push(AppRoutes.register);
                  },
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