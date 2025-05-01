import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:resumate_flutter/core/utils/fonts/sf_pro_display.dart';
import 'package:resumate_flutter/core/utils/spacers/spacers.dart';
import 'package:resumate_flutter/core/utils/theme/app_pallette.dart';
import 'package:resumate_flutter/core/utils/widgets/rounded_button.dart';
import 'package:resumate_flutter/features/mentorship/model/Mentor.dart';
import 'package:resumate_flutter/features/mentorship/view/widgets/skill_chip.dart';
import 'package:resumate_flutter/features/mentorship/viewmodel/mentorship_controller.dart';
import 'package:intl/intl.dart';

class MentorAboutPage extends StatelessWidget {
  final Mentor mentor;
  const MentorAboutPage({super.key, required this.mentor});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MentorshipController>();

    return Scaffold(
      backgroundColor: const Color(0xFFFFF8F8),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(
              bottom: 40,
              top: 80,
              left: 24,
              right: 24,
            ),
            decoration: BoxDecoration(
              color: AppPallete.primary400,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                spaceH15,
                SfProDisplay(
                  text: 'Hi, I’m',

                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  textColor: AppPallete.whiteColor,
                  lineheight: 0,
                ),
                SfProDisplay(
                  text: mentor.name,
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                  textColor: AppPallete.whiteColor,
                  lineheight: 0,
                ),
                spaceH10,
                const Divider(color: Colors.white70, height: 32),
                spaceH10,
                SfProDisplay(
                  text: "${mentor.jobRole} at",
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  textColor: AppPallete.whiteColor,
                  lineheight: 0,
                ),

                SfProDisplay(
                  text: mentor.company,
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                  textColor: AppPallete.whiteColor,
                ),

                const Divider(color: Colors.white70, height: 32),
                spaceH10,

                SfProDisplay(
                  text: 'About Me',
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  textColor: AppPallete.whiteColor,
                ),

                spaceH10,
                SfProDisplay(
                  text: mentor.about,
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                  textColor: AppPallete.whiteColor,
                  shouldTruncate: false,
                  textAlignment: TextAlign.left,
                  lineheight: 1.3,
                ),
              ],
            ),
          ),
          spaceH40,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: SfProDisplay(
                text: 'My skills are but not limited to',
                fontSize: 17,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          spaceH20,
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children:
                mentor.skills.map((skill) => SkillChip(label: skill)).toList(),
          ),
          spaceH25,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: SfProDisplay(
                text: 'Feel Free to reach out',
                fontSize: 17,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          spaceH25,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: RoundedButton(
              label: 'Book Session',
              onTap: () async {
                final ThemeData pickerTheme = Theme.of(context).copyWith(
                  colorScheme: ColorScheme.light(
                    primary: AppPallete.pink400,
                    onPrimary: Colors.white,
                  ),
                  dialogBackgroundColor: Colors.white,
                  textButtonTheme: TextButtonThemeData(
                    style: TextButton.styleFrom(
                      foregroundColor: AppPallete.pink400, // Button text color
                    ),
                  ),
                );

                final DateTime? selectedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2100),
                  builder: (context, child) {
                    return Theme(data: pickerTheme, child: child!);
                  },
                );

                if (selectedDate != null) {
                  final TimeOfDay? selectedTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                    builder: (context, child) {
                      return Theme(data: pickerTheme, child: child!);
                    },
                  );

                  if (selectedTime != null) {
                    final DateTime finalDateTime = DateTime(
                      selectedDate.year,
                      selectedDate.month,
                      selectedDate.day,
                      selectedTime.hour,
                      selectedTime.minute,
                    );

                    final dateStr = DateFormat(
                      'yyyy-MM-dd',
                    ).format(finalDateTime);
                    final timeStr = DateFormat('HH:mm').format(finalDateTime);

                    await controller.bookMentorSession(
                      mentorId: mentor.id,
                      date: dateStr,
                      time: timeStr,
                    );
                  }
                }
              },
              borderColor: AppPallete.pink400,
              backgroundColor: AppPallete.pink400,
            ),
          ),
        ],
      ),
    );
  }
}
