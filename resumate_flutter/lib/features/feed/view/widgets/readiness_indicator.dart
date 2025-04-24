import 'package:flutter/material.dart';
import 'package:resumate_flutter/core/utils/fonts/sf_pro_display.dart';
import 'package:resumate_flutter/core/utils/spacers/spacers.dart';
import 'package:resumate_flutter/core/utils/theme/app_pallette.dart';

class ReadinessIndicator extends StatefulWidget {
  const ReadinessIndicator({super.key});

  @override
  _ReadinessIndicatorState createState() => _ReadinessIndicatorState();
}

class _ReadinessIndicatorState extends State<ReadinessIndicator> {
  final Map<String, Map<String, dynamic>> data = {
    'Frontend Developer': {
      'percentage': 75,
      'aspects': {
        'Skills Mastered': 0.8,
        'Portfolio Strength': 0.7,
        'Certifications Completed': 0.6,
      },
    },
    'Backend Developer': {
      'percentage': 60,
      'aspects': {
        'Skills Mastered': 0.7,
        'Portfolio Strength': 0.5,
        'Certifications Completed': 0.4,
      },
    },
    'ML Engineer': {
      'percentage': 45,
      'aspects': {
        'Skills Mastered': 0.5,
        'Portfolio Strength': 0.4,
        'Certifications Completed': 0.3,
      },
    },
  };

  String selectedTrack = 'Frontend Developer';

  @override
  Widget build(BuildContext context) {
    final selectedData = data[selectedTrack]!;
    final int percentage = selectedData['percentage'];
    final aspects = selectedData['aspects'] as Map<String, double>;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SfProDisplay(
                text: selectedTrack,
                fontSize: 26,
                fontWeight: FontWeight.w700,
                textColor: AppPallete.black,
                lineheight: 0,
              ),
              SfProDisplay(
                text: 'You are $percentage% ready',
                fontSize: 14,
                fontWeight: FontWeight.w500,
                textColor: AppPallete.greyColor,
                lineheight: 0,
              ),
            ],
          ),
        ),
        spaceH30,
        Stack(
          clipBehavior: Clip.none, // ✨ This disables the default clipping

          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 180,
              height: 180,
              child: CircularProgressIndicator(
                value: percentage / 100,
                strokeWidth: 20,
                backgroundColor: AppPallete.primary100,
                color: AppPallete.primary400,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SfProDisplay(
                  text: '$percentage%',
                  fontSize: 36,
                  fontWeight: FontWeight.w700,
                  textColor: AppPallete.black,
                  lineheight: 0,
                ),

                SfProDisplay(
                  text: 'Ready',
                  fontSize: 16,
                  lineheight: 0,
                  fontWeight: FontWeight.w400,
                  textColor: AppPallete.greyColor,
                ),
              ],
            ),
            Positioned(
              top: 20,
              right: -100,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: AppPallete.primary100,
                  border: Border.all(color: AppPallete.primary400),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  decoration: BoxDecoration(color: AppPallete.transparentColor),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: selectedTrack,
                      isDense: true,
                      isExpanded: false,
                      style: const TextStyle(fontSize: 14),
                      dropdownColor: Colors.white,
                      icon: const Icon(Icons.arrow_drop_down),
                      items:
                          data.keys.map((track) {
                            return DropdownMenuItem(
                              value: track,
                              child: SfProDisplay(
                                text: track,
                                textColor: Colors.black,
                                fontSize: 14,
                                lineheight: 0,
                                fontWeight: FontWeight.w400,
                              ),
                            );
                          }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedTrack = value!;
                        });
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        spaceH30,
        Align(
          alignment: Alignment.centerLeft, // Aligns the text to the left
          child: SfProDisplay(
            text: 'Key Career Aspects',
            textColor: AppPallete.black,
            fontSize: 18,
            fontWeight: FontWeight.w700,
            textAlignment: TextAlign.left,
          ),
        ),

        ...aspects.entries.map((entry) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 6.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SfProDisplay(
                      text: entry.key,
                      fontSize: 15,
                      textColor: AppPallete.pink400,
                    ),
                    SfProDisplay(
                      text:
                          '${(entry.value * 100).toInt()}%', // Multiply by 100 and format as integer
                      fontSize: 15,
                      textColor: AppPallete.pink400,
                    ),
                  ],
                ),

                LinearProgressIndicator(
                  value: entry.value,
                  backgroundColor: AppPallete.pink100,
                  color: AppPallete.pink400,
                  minHeight: 10,
                ),
              ],
            ),
          );
        }).toList(),
      ],
    );
  }
}
