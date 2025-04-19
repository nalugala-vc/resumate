import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resumate_flutter/core/fonts/sf_pro_display.dart';
import 'package:resumate_flutter/core/spacers/spacers.dart';
import 'package:resumate_flutter/core/theme/app_pallette.dart';
import 'package:resumate_flutter/core/widgets/auth_field.dart';
import 'package:resumate_flutter/core/widgets/rounded_button.dart';
import 'package:resumate_flutter/features/auth/view/widgets/sign_up_option.dart';
import 'package:resumate_flutter/features/auth/view/widgets/social_icons.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

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
                          text: 'Welcome Back',
                          fontSize: 32,
                          textColor: AppPallete.black,
                          fontWeight: FontWeight.w700,
                        ),
                        spaceH40,
                        AuthField(
                          controller: emailController,
                          hintText: 'Email',
                        ),
                        spaceH40,
                        AuthField(
                          controller: passwordController,
                          isObscureText: true,

                          hintText: 'Password',
                        ),

                        spaceH50,
                        RoundedButton(label: 'Sign In', onTap: () {}),
                        spaceH50,
                        const SignUpOptions(text: 'or sign in with'),
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
                              text: "Don't have an account?",
                              style: TextStyle(
                                color: AppPallete.greyColor,
                                fontFamily: 'SFPRO',
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                              ),
                              children: [
                                TextSpan(
                                  text: ' Sign up here',
                                  style: TextStyle(
                                    color: AppPallete.primary400,
                                    fontFamily: 'SFPRO',
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  recognizer:
                                      TapGestureRecognizer()
                                        ..onTap = () {
                                          Get.offAllNamed('/sign-in');
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
