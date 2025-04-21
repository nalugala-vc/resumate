import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resumate_flutter/core/utils/fonts/sf_pro_display.dart';
import 'package:resumate_flutter/core/utils/theme/app_pallette.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> onboardingData = [
    {
      'image': 'assets/onboarding1.png',
      'title': 'Your Career, Your Future',
      'desc':
          'Tell us your skills and goals—our AI will craft a personalized career roadmap just for you.',
    },
    {
      'image': 'assets/onboarding2.png',
      'title': 'Nail Your Resume & Interviews',
      'desc':
          'Get AI-powered resume reviews and practice real interview questions with instant feedback.',
    },
    {
      'image': 'assets/onboarding3.png',
      'title': 'Find the Right Job & Level Up',
      'desc':
          'Tell us your skills and goals—our AI will craft a personalized career roadmap just for you.',
    },
  ];

  void _nextPage() {
    if (_currentPage == onboardingData.length - 1) {
      _goToSignUp();
    } else {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _goToSignUp() {
    Get.toNamed('/signup');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: onboardingData.length,
                onPageChanged: (index) {
                  setState(() => _currentPage = index);
                },
                itemBuilder: (context, index) {
                  final item = onboardingData[index];

                  return AnimatedBuilder(
                    animation: _pageController,
                    builder: (context, child) {
                      double value = 1.0;
                      if (_pageController.position.haveDimensions) {
                        value = _pageController.page! - index;
                        value = (1 - (value.abs() * 0.5)).clamp(0.0, 1.0);
                      }

                      return Opacity(
                        opacity: value,
                        child: Transform.translate(
                          offset: Offset(
                            50 * (1 - value),
                            0,
                          ), // slide in from right
                          child: Column(
                            children: [
                              const SizedBox(height: 40),
                              Image.asset(
                                item['image']!,
                                height: 500,
                                width: double.infinity,
                                fit: BoxFit.fill,
                              ),
                              const SizedBox(height: 30),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(
                                  onboardingData.length,
                                  (dotIndex) => AnimatedContainer(
                                    duration: const Duration(milliseconds: 300),
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 5,
                                    ),
                                    height: 8,
                                    width: _currentPage == dotIndex ? 16 : 8,
                                    decoration: BoxDecoration(
                                      color:
                                          _currentPage == dotIndex
                                              ? AppPallete.primary400
                                              : Colors.grey[300],
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              SfProDisplay(
                                text: item['title']!,
                                fontWeight: FontWeight.w700,
                                textColor: AppPallete.black,
                                fontSize: 24,
                                textAlignment: TextAlign.center,
                              ),
                              const SizedBox(height: 10),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 70,
                                ),
                                child: SfProDisplay(
                                  text: item['desc']!,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  textColor: AppPallete.greyColor,
                                  shouldTruncate: false,
                                  textAlignment: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: _goToSignUp,
                    child: SfProDisplay(
                      text: 'SKIP',
                      fontSize: 15,
                      textColor: AppPallete.greyColor,
                    ),
                  ),
                  InkWell(
                    onTap: _nextPage,
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppPallete.primary400,
                      ),
                      child: const Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
