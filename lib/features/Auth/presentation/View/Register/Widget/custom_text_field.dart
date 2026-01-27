import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatelessWidget {
  final String title; // العنوان فوق الحقل
  final String hintText;
  final IconData? suffixIcon; // الأيقونة في اليسار
  final bool obscureText;
  final TextInputType keyboardType;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final VoidCallback? onSuffixIconTap;

  const CustomTextField({
    super.key,
    required this.title,
    required this.hintText,
    this.suffixIcon,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.controller,
    this.validator,
    this.onSuffixIconTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontFamily: "Tajawal",
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF0F172A),
          ),
        ),
        SizedBox(height: 8.h), // مسافة بسيطة بين العنوان والحقل
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          validator: validator,
          textAlign: TextAlign.start,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              fontFamily: "Tajawal",
              fontSize: 14.sp,
              color: const Color(0xFF64748B),
            ),
            suffixIcon: suffixIcon != null
                ? GestureDetector(
              onTap: onSuffixIconTap,
              child: Icon(suffixIcon, size: 22.w, color: const Color(0xFF1B523D)),
            )
                : null,
            filled: true,
            fillColor: const Color(0xFFF4F7F6),
            border: _buildBorder(const Color(0xFFF4F7F6)),
            enabledBorder: _buildBorder(const Color(0xFFF4F7F6)),
            focusedBorder: _buildBorder(const Color(0xFF1B523D), width: 1.2),
            errorBorder: _buildBorder(Colors.red),
            focusedErrorBorder: _buildBorder(Colors.red, width: 1.5),
            contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          ),
          style: TextStyle(
            fontFamily: "Tajawal",
            fontSize: 16.sp,
            color: const Color(0xFF0F172A),
          ),
        ),
      ],
    );
  }

  OutlineInputBorder _buildBorder(Color color, {double width = 1.0}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(16.r),
      borderSide: BorderSide(color: color, width: width),
    );
  }
}