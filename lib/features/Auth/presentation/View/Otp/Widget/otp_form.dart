import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tharadtech/core/helper/app_locclization.dart';
import 'package:tharadtech/core/helper/on_generate_routes.dart';
import 'package:tharadtech/features/Auth/presentation/View/Otp/Widget/otp_input_field.dart';
import 'package:tharadtech/features/Auth/presentation/View/Otp/Widget/resend_otp_section.dart';
import 'package:tharadtech/features/Auth/presentation/View/Register/Widget/custom_button.dart';
import 'package:tharadtech/features/Auth/presentation/manage/otp/otp_cubit.dart';

class OtpForm extends StatefulWidget {
  const OtpForm({super.key, required this.email});

  final String email;

  @override
  State<OtpForm> createState() => OtpFormState();
}

class OtpFormState extends State<OtpForm> {
  static const int _otpLength = 4;

  final List<TextEditingController> _controllers = List.generate(
    _otpLength,
    (index) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(
    _otpLength,
    (index) => FocusNode(),
  );

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  void _onChanged(String value, int index) {
    if (value.length == 1 && index < _otpLength - 1) {
      _focusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);

    return BlocConsumer<OtpCubit, OtpState>(
      listener: (context, state) {
        if (state is OtpLoaded) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("success"),
              backgroundColor: Colors.green,
            ),
          );
          context.go(AppRoutes.logIn);
        }
      },
      builder: (context, state) {
        return Column(
          children: [
            Directionality(
              textDirection: TextDirection.ltr,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  _otpLength,
                  (index) => OtpInputField(
                    controller: _controllers[index],
                    focusNode: _focusNodes[index],
                    onChanged: (value) => _onChanged(value, index),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.h),
            const ResendOtpSection(),
            SizedBox(height: 40.h),
            CustomButton(
              text: localization.translate('verify_otp_btn') ,
              isLoading: state is OtpLoading,
              onPressed: () {
                final otpCode = _controllers.map((e) => e.text).join();
                if (otpCode.length == _otpLength) {
                  context.read<OtpCubit>().otp(
                    email: widget.email,
                    otp: otpCode,
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        localization.translate('otp_error_msg')
                          ,
                      ),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
            ),
            if (state is OtpError) ...[
              SizedBox(height: 20.h),
              Text(
                state.error,
                style: TextStyle(
                  fontFamily: "Tajawal",
                  fontSize: 14.sp,
                  color: Colors.red,
                ),
              ),
            ],
          ],
        );
      },
    );
  }
}
