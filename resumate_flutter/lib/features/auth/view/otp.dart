import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:resumate_flutter/core/fonts/sf_pro_display.dart';
import 'package:resumate_flutter/core/spacers/spacers.dart';
import 'package:resumate_flutter/core/theme/app_pallette.dart';
import 'package:resumate_flutter/core/widgets/rounded_button.dart';

class OTP extends StatefulWidget {
  const OTP({super.key});

  @override
  State<OTP> createState() => _OTPState();
}

class _OTPState extends State<OTP> {
  var otp;
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min, // 👈 ensures vertical centering
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SfProDisplay(
                  text: 'Check your phone',
                  fontSize: 32,
                  fontWeight: FontWeight.w800,
                  textAlignment: TextAlign.center,
                ),
                spaceH10,
                SfProDisplay(
                  text: 'We\'ve sent an OTP code to your phone',
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                  textColor: AppPallete.greyColor,
                  textAlignment: TextAlign.center,
                ),
                spaceH50,
                OtpTextField(
                  numberOfFields: 4,
                  enabledBorderColor: AppPallete.primary200,
                  fieldWidth: 60,
                  fieldHeight: 60,
                  focusedBorderColor: AppPallete.primary400,
                  borderColor: AppPallete.primary400,
                  showFieldAsBox: true,
                  onCodeChanged: (String code) {
                    otp = code;
                  },
                  onSubmit: (String verificationCode) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text("Verification Code"),
                          content: Text('Code entered is $verificationCode'),
                        );
                      },
                    );
                  },
                ),
                spaceH50,
                RoundedButton(label: 'Verify', onTap: () {}),
                spaceH25,
                RoundedButton(
                  label: 'Send again',
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  textColor: AppPallete.primary400,
                  onTap: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
