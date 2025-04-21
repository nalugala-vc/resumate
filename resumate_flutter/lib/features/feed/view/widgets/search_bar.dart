import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:resumate_flutter/core/utils/theme/app_pallette.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          const HeroIcon(
            HeroIcons.magnifyingGlass,
            style: HeroIconStyle.outline,
            color: Colors.grey,
            size: 20,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppPallete.transparentColor),
                  borderRadius: BorderRadius.circular(7),
                ),
                hintText: 'Search jobs...',
                hintStyle: TextStyle(color: Colors.grey, fontSize: 16),
                border: InputBorder.none,
              ),
              style: const TextStyle(color: Colors.grey, fontSize: 16),
              cursorColor: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
