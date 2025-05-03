import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resumate_flutter/core/utils/fonts/sf_pro_display.dart';
import 'package:resumate_flutter/core/utils/spacers/spacers.dart';
import 'package:resumate_flutter/core/utils/widgets/back_button.dart';
import 'package:resumate_flutter/core/utils/widgets/notifications_icon.dart';
import 'package:resumate_flutter/features/ai/view/widgets/bot_message.dart';
import 'package:resumate_flutter/features/ai/view/widgets/chat_input_field.dart';
import 'package:resumate_flutter/features/ai/view/widgets/user_message.dart';
import 'package:resumate_flutter/features/ai/viewmodel/ai_controller.dart';

class AIChatPage extends StatefulWidget {
  const AIChatPage({super.key});

  @override
  State<AIChatPage> createState() => _AIChatPageState();
}

class _AIChatPageState extends State<AIChatPage> {
  final controller = Get.put(AiController());
  final TextEditingController messageController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  @override
  void dispose() {
    messageController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    if (scrollController.hasClients) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: buildBackButton(),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: NotificationsIcon(),
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 12),
          Container(
            width: 90,
            height: 120,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/resumate_helper.png'),
                fit: BoxFit.fill,
              ),
            ),
          ),
          spaceH5,
          SfProDisplay(
            text: 'Resumate Helper',
            fontSize: 18,
            fontWeight: FontWeight.w500,
            lineheight: 0,
          ),
          spaceH15,
          Expanded(
            child: Obx(() {
              final messages = controller.messages;

              // Trigger scroll after build
              WidgetsBinding.instance.addPostFrameCallback(
                (_) => _scrollToBottom(),
              );

              return ListView.builder(
                controller: scrollController,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: messages.length,
                itemBuilder: (_, index) {
                  final msg = messages[index];
                  return msg.isUser
                      ? UserMessage(message: msg.content)
                      : BotMessage(message: msg.content);
                },
              );
            }),
          ),
          ChatInputField(
            controller: messageController,
            onSend: () {
              if (messageController.text.trim().isNotEmpty) {
                controller.sendMessage(message: messageController.text.trim());
                messageController.clear();
              }
            },
          ),
        ],
      ),
    );
  }
}
