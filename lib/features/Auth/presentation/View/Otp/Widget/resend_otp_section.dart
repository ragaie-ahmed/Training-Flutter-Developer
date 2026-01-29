import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tharadtech/core/helper/app_locclization.dart';

class ResendOtpSection extends StatefulWidget {
  const ResendOtpSection({super.key});

  @override
  State<ResendOtpSection> createState() => _ResendOtpSectionState();
}

class _ResendOtpSectionState extends State<ResendOtpSection> {
  int _remainingSeconds = 60;
  bool _canResend = false;

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  void _startCountdown() {
    if (!mounted) return;
    setState(() {
      _canResend = false;
      _remainingSeconds = 60;
    });
    _updateCountdown();
  }

  void _updateCountdown() {
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        if (_remainingSeconds > 0) {
          setState(() {
            _remainingSeconds--;
          });
          _updateCountdown();
        } else {
          setState(() {
            _canResend = true;
          });
        }
      }
    });
  }

  void _resendOtp() {
    if (_canResend) {
      
      debugPrint('Resend OTP Triggered');
      _startCountdown();
    }
  }

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);

    return Padding(
      padding: EdgeInsets.only(top: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          Text(
            _formatTime(_remainingSeconds),
            style: TextStyle(
              fontFamily: "Tajawal",
              fontSize: 14.sp,
              color: Colors.grey,
            ),
          ),
          Row(
            children: [
              Text(
                "${localization.translate('resend_question') } ",
                style: TextStyle(
                  fontFamily: "Tajawal",
                  fontSize: 14.sp,
                  color: Colors.grey[700],
                ),
              ),
              
              GestureDetector(
                onTap: _canResend ? _resendOtp : null,
                child: Text(
                  localization.translate('resend_action'),
                  style: TextStyle(
                    fontFamily: "Tajawal",
                    fontSize: 14.sp,
                    color: _canResend ? const Color(0xFF4EB0AD) : Colors.grey,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),

        ],
      ),
    );
  }
}