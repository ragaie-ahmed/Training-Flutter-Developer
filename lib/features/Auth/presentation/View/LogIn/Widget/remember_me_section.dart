import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tharadtech/core/helper/app_locclization.dart';

class RememberMeSection extends StatefulWidget {
  const RememberMeSection({super.key});

  @override
  State<RememberMeSection> createState() => _RememberMeSectionState();
}

class _RememberMeSectionState extends State<RememberMeSection> {
  bool _isRemembered = false; 

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        
        Row(
          children: [
            SizedBox(
              width: 20.w,
              height: 20.h,
              child: Checkbox(
                value: _isRemembered,
                activeColor: const Color(0xFF4EB0AD), 
                onChanged: (value) {
                  setState(() {
                    _isRemembered = value ?? false;
                  });
                },
                side: BorderSide(color: Colors.grey.shade400, width: 1.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.r),
                ),
              ),
            ),
            SizedBox(width: 8.w),
            GestureDetector(
              onTap: () {
                setState(() {
                  _isRemembered = !_isRemembered;
                });
              },
              child: Text(
                localization.translate('remember_me') ,
                style: TextStyle(
                  fontFamily: "Tajawal",
                  fontSize: 14.sp,
                  color: Colors.grey[700],
                ),
              ),
            ),
          ],
        ),

        
        GestureDetector(
          onTap: () {
            
          },
          child: Text(
            localization.translate('forgot_password'),
            style: TextStyle(
              fontFamily: "Tajawal",
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF1B523D), 
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }
}