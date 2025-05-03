import 'package:flutter/material.dart';
import 'package:resumate_flutter/core/utils/spacers/spacers.dart';
import 'package:resumate_flutter/core/utils/theme/app_pallette.dart';

class ChatInputField extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSend;

  const ChatInputField({
    super.key,
    required this.controller,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border(top: BorderSide(color: Colors.grey, width: 0.2)),
        color: Colors.grey.shade100,
      ),
      child: Row(
        children: [
          const Icon(Icons.add, color: AppPallete.primary400),
          spaceW12,
          Expanded(
            child: TextField(
              controller: controller,
              decoration: const InputDecoration(
                hintText: "Type Something",
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                hintStyle: TextStyle(
                  color: AppPallete.greyColor,
                  fontFamily: 'SFPRO',
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),

              onSubmitted: (_) => onSend(),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send, color: AppPallete.primary400),
            onPressed: onSend,
          ),
        ],
      ),
    );
  }
}
