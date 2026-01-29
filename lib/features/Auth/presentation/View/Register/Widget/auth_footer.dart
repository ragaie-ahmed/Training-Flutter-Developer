import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tharadtech/core/utils/app_color.dart';

class AuthFooter extends StatelessWidget {
  final String questionText;
  final String actionText;
  final VoidCallback? onActionTap; 

  const AuthFooter({ 
    super.key,
    required this.questionText,
    required this.actionText,
    required this.onActionTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          questionText,
          style: TextStyle(
            fontFamily: "Tajawal",
            fontSize: 14.sp,
            color: Colors.grey[600],
          ),
        ),
        SizedBox(width: 4.w), 
        GestureDetector(
          onTap: onActionTap,
          child: Text(
            actionText,
            style: TextStyle(
              fontFamily: "Tajawal",
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: Color(AppColor.primaryColor),
              decoration: TextDecoration.underline, 
            ),
          ),
        ),
      ],
    );
  }
}