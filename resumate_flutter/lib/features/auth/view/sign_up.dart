import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resumate_flutter/core/utils/fonts/sf_pro_display.dart';
import 'package:resumate_flutter/core/utils/spacers/spacers.dart';
import 'package:resumate_flutter/core/utils/theme/app_pallette.dart';
import 'package:resumate_flutter/core/utils/widgets/auth_field.dart';
import 'package:resumate_flutter/core/utils/widgets/rounded_button.dart';
import 'package:resumate_flutter/features/auth/view/sign_in.dart';
import 'package:resumate_flutter/features/auth/view/widgets/sign_up_option.dart';
import 'package:resumate_flutter/features/auth/view/widgets/social_icons.dart';
import 'package:resumate_flutter/features/auth/viewmodel/auth_controller.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final controller = Get.put(SignUpController());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SfProDisplay(
                          text: 'Sign Up',
                          fontSize: 32,
                          textColor: AppPallete.black,
                          fontWeight: FontWeight.w700,
                        ),
                        spaceH40,
                        AuthField(
                          controller: controller.email,
                          hintText: 'Email',
                          validator:
                              (value) => controller.validateEmail(value ?? ''),
                        ),
                        spaceH40,
                        AuthField(
                          controller: controller.password,
                          isObscureText: true,
                          validator:
                              (value) =>
                                  controller.validatePassword(value ?? ''),
                          hintText: 'Password',
                        ),
                        spaceH40,
                        AuthField(
                          controller: controller.confirmPassword,
                          isObscureText: true,
                          validator:
                              (value) => controller.validateConfirmPassword(
                                controller.password.text,
                                value ?? '',
                              ),
                          hintText: 'Confirm Password',
                        ),
                        spaceH50,
                        RoundedButton(
                          isLoading: controller.isLoading.value,
                          label: 'Sign Up',
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              controller.signUp(
                                email: controller.email.text,
                                password: controller.password.text,
                              );
                            }
                          },
                        ),
                        spaceH50,
                        const SignUpOptions(text: 'or sign up with'),
                        spaceH50,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SocialIcons(
                              onTap: () {},
                              socialLogo: "assets/facebook.png",
                              logoheight: 38,
                              logowidth: 38,
                            ),
                            const SizedBox(width: 20),
                            SocialIcons(
                              onTap: () {},
                              socialLogo: "assets/google.png",
                              logoheight: 25,
                              logowidth: 25,
                            ),
                            const SizedBox(width: 20),
                            SocialIcons(
                              onTap: () {},
                              socialLogo: "assets/apple.png",
                              logoheight: 35,
                              logowidth: 35,
                            ),
                          ],
                        ),
                        spaceH50,
                        Center(
                          child: RichText(
                            text: TextSpan(
                              text: "Already have an account?",
                              style: TextStyle(
                                color: AppPallete.greyColor,
                                fontFamily: 'SFPRO',
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                              ),
                              children: [
                                TextSpan(
                                  text: ' Sign in here!',
                                  style: TextStyle(
                                    color: AppPallete.primary400,
                                    fontFamily: 'SFPRO',
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  recognizer:
                                      TapGestureRecognizer()
                                        ..onTap = () {
                                          Get.to(() => SignIn());
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
