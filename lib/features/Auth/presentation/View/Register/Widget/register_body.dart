import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tharadtech/core/api/service_locator.dart';
import 'package:tharadtech/core/errors/show_app_snack_bar.dart';
import 'package:tharadtech/core/helper/app_locclization.dart';
import 'package:tharadtech/core/helper/on_generate_routes.dart';
import 'package:tharadtech/features/Auth/domain/usecase/register_use_case.dart';
import 'package:tharadtech/features/Auth/presentation/View/Register/Widget/auth_footer.dart';
import 'package:tharadtech/features/Auth/presentation/View/Register/Widget/auth_header.dart';
import 'package:tharadtech/features/Auth/presentation/View/Register/Widget/build_image.dart';
import 'package:tharadtech/features/Auth/presentation/View/Register/Widget/custom_button.dart';
import 'package:tharadtech/features/Auth/presentation/View/Register/Widget/custom_text_field.dart';
import 'package:tharadtech/features/Auth/presentation/manage/register/register_cubit.dart';
import 'package:tharadtech/generated/assets.dart';

class RegisterBody extends StatelessWidget {
  const RegisterBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(getit.get<RegisterUseCase>()),
      child: const _RegisterForm(),
    );
  }
}

class _RegisterForm extends StatefulWidget {
  const _RegisterForm();

  @override
  State<_RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<_RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);

    return Scaffold(
      body: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state is RegisterLoaded) {
            showAppSnackBar(
              context: context,
              message: "Success register",
              isError: false,
            );
            context.push(AppRoutes.otpView,extra: _emailController.text);
          } else if (state is RegisterError) {
            showAppSnackBar(
              context: context,
              message: state.error,
              isError: true,
            );
          }
        },
        builder: (builderContext, state) {
          final cubit = builderContext.read<RegisterCubit>();

          return SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 20.h),
                    AuthHeader(
                      title: loc.translate('register_title'),
                      logoAsset: Assets.logo,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            const BuildImage(),
                            SizedBox(height: 24.h),
                            CustomTextField(
                              title: loc.translate('username_label'),
                              hintText: loc.translate('username_hint'),
                              controller: _nameController,
                            ),
                            SizedBox(height: 20.h),
                            CustomTextField(
                              title: loc.translate('email_label'),
                              hintText: loc.translate('email_hint'),
                              keyboardType: TextInputType.emailAddress,
                              controller: _emailController,
                            ),
                            SizedBox(height: 20.h),
                            CustomTextField(
                              title: loc.translate('password_label'),
                              hintText: "**********",
                              suffixIcon: cubit.isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              obscureText: !cubit.isPasswordVisible,
                              controller: _passwordController,
                              onSuffixIconTap: () =>
                                  cubit.togglePasswordVisibility(),
                            ),
                            SizedBox(height: 20.h),
                            CustomTextField(
                              title: loc.translate('confirm_password_label'),
                              hintText: "**********",
                              suffixIcon: cubit.isConfirmPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              obscureText: !cubit.isConfirmPasswordVisible,
                              controller: _confirmPasswordController,
                              onSuffixIconTap: () =>
                                  cubit.toggleConfirmPasswordVisibility(),
                            ),
                            SizedBox(height: 30.h),
                            CustomButton(
                              isLoading: state is RegisterLoading,
                              text: loc.translate('sign_up_btn'),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  cubit.register(
                                    name: _nameController.text,
                                    email: _emailController.text,
                                    passWord: _passwordController.text,
                                    confirmPassWord:
                                        _confirmPasswordController.text,
                                  );
                                }
                              },
                            ),
                            SizedBox(height: 20.h),
                            AuthFooter(
                              questionText: loc.translate(
                                'already_have_account',
                              ),
                              actionText: loc.translate('sign_in_action'),
                              onActionTap: () {
                                context.pop();
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
