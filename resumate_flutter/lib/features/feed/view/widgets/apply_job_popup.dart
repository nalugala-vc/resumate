import 'package:flutter/material.dart';
import 'package:resumate_flutter/core/utils/fonts/sf_pro_display.dart';
import 'package:resumate_flutter/core/utils/spacers/spacers.dart';
import 'package:resumate_flutter/core/utils/theme/app_pallette.dart';

class ApplyJobPopup extends StatelessWidget {
  final String email;
  final String phoneNo;
  const ApplyJobPopup({super.key, required this.email, required this.phoneNo});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      insetPadding: const EdgeInsets.all(24),
      child: Container(
        padding: EdgeInsets.all(20),
        color: AppPallete.primary100,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: InkWell(
                onTap: () => Navigator.of(context).pop(),
                child: const Icon(Icons.close, size: 20, color: Colors.black),
              ),
            ),
            spaceH10,
            SfProDisplay(
              text:
                  'Apply by sending us your resume and cover letter to the following email',
              shouldTruncate: false,
              fontWeight: FontWeight.normal,
              fontSize: 13,
              textColor: AppPallete.greyColor,
            ),

            SfProDisplay(
              text: email,
              shouldTruncate: false,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
            spaceH20,
            SfProDisplay(
              text: 'Need more info? Give us a call',
              shouldTruncate: false,
              fontWeight: FontWeight.normal,
              fontSize: 13,
              textColor: AppPallete.greyColor,
            ),
            SfProDisplay(
              text: phoneNo,
              shouldTruncate: false,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ],
        ),
      ),
    );
  }
}
