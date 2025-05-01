import 'package:flutter/material.dart';
import 'package:resumate_flutter/core/utils/fonts/sf_pro_display.dart';
import 'package:resumate_flutter/core/utils/theme/app_pallette.dart';
import 'package:resumate_flutter/features/mentorship/model/Mentor.dart';

class MentorCard extends StatelessWidget {
  final Mentor mentor;
  const MentorCard({super.key, required this.mentor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(mentor.image),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // ✅ Dark overlay
          Container(color: Colors.black.withOpacity(0.4)),

          Positioned(
            top: 10,
            right: 10,
            child: GestureDetector(
              child: Icon(Icons.favorite_border, color: Colors.white),
            ),
          ),
          Positioned(
            bottom: 10,
            left: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SfProDisplay(
                  text: mentor.name,
                  fontSize: 14,
                  textColor: AppPallete.whiteColor,
                  fontWeight: FontWeight.w500,
                  lineheight: 0,
                ),
                SfProDisplay(
                  text: mentor.jobRole,
                  fontSize: 14,
                  textColor: AppPallete.primary400,
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
