import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:resumate_flutter/core/utils/theme/app_pallette.dart';
import 'package:resumate_flutter/features/feed/view/pages/homepage.dart';
import 'package:resumate_flutter/features/feed/view/pages/roadmap.dart';
import 'package:resumate_flutter/features/mentorship/view/pages/explore_mentors_page.dart';
import 'package:resumate_flutter/features/profile/view/pages/user_profile.dart';

class CustomBottomNavBar extends StatefulWidget {
  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    Homepage(),
    Roadmap(),
    ExploreMentorsPage(),
    UserProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: _pages[_currentIndex]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: AppPallete.primary400,
        unselectedItemColor: AppPallete.greyColor,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(
            icon: HeroIcon(HeroIcons.home, style: HeroIconStyle.outline),
            activeIcon: HeroIcon(HeroIcons.home, style: HeroIconStyle.solid),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: HeroIcon(HeroIcons.map, style: HeroIconStyle.outline),
            activeIcon: HeroIcon(HeroIcons.map, style: HeroIconStyle.solid),
            label: 'Roadmap',
          ),
          BottomNavigationBarItem(
            icon: HeroIcon(HeroIcons.users, style: HeroIconStyle.outline),
            activeIcon: HeroIcon(HeroIcons.users, style: HeroIconStyle.solid),
            label: 'Mentorship',
          ),
          BottomNavigationBarItem(
            icon: HeroIcon(HeroIcons.user, style: HeroIconStyle.outline),
            activeIcon: HeroIcon(HeroIcons.user, style: HeroIconStyle.solid),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
