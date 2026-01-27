import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tharadtech/core/helper/app_locclization.dart';
import 'package:tharadtech/features/Auth/presentation/View/LogIn/Widget/remember_me_section.dart';
import 'package:tharadtech/features/Auth/presentation/View/Register/Widget/custom_button.dart';
import 'package:tharadtech/features/Auth/presentation/View/Register/Widget/custom_text_field.dart';
import 'package:tharadtech/features/Auth/presentation/manage/login/login_cubit.dart';


class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() {
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please enter your email',
            style: TextStyle(fontFamily: "Tajawal"),
          ),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please enter your password',
            style: TextStyle(fontFamily: "Tajawal"),
          ),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Call login cubit
    context.read<LoginCubit>().logIn(email: email, passWord: password);
  }

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.error,
                style: TextStyle(fontFamily: "Tajawal"),
              ),
              backgroundColor: Colors.red,
            ),
          );
        } else if (state is LoginLoaded) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "Login successful",
                style: TextStyle(fontFamily: "Tajawal"),
              ),
              backgroundColor: Colors.green,
            ),
          );
        }
      },
      builder: (context, state) {
        return Column(
          children: [
            // Email Field
            CustomTextField(
              title:AppLocalizations.of(context).translate('email_label'),
              hintText:AppLocalizations.of(context).translate('email_hint'),
              keyboardType: TextInputType.emailAddress,
              controller: _emailController,
            ),
            
            SizedBox(height: 20.h),
            
            // Password Field
            CustomTextField(
              title: AppLocalizations.of(context).translate('confirm_password_label'),
              hintText: "**********",
              suffixIcon: LoginCubit.get(context).isPassWord
                  ? Icons.visibility
                  : Icons.visibility_off,
              obscureText: !LoginCubit.get(context).isPassWord,
              controller: _passwordController,
              onSuffixIconTap: () =>
                  LoginCubit.get(context).togglePassWord(),
            ),
            
            SizedBox(height: 20.h),
            
            // Remember Me & Forgot Password
            const RememberMeSection(),
            
            SizedBox(height: 30.h),
            
            // Login Button
            CustomButton(
              text: "Sign In",
              onPressed: _login,
              isLoading: state is LoginLoading,
            ),
          ],
        );
      },
    );
  }
}
