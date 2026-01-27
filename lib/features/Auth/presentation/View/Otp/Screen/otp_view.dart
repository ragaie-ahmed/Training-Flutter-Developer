import 'package:flutter/material.dart';
import 'package:tharadtech/features/Auth/presentation/View/Otp/Widget/otp_body.dart';

class OtpView extends StatelessWidget {
  const OtpView({super.key, required this.email});
final String email;
  @override
  Widget build(BuildContext context) {
    print(email);
    return  OtpBody(email: email);
  }
}
