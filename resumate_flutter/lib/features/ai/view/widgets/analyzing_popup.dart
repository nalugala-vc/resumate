import 'package:flutter/material.dart';
import 'package:resumate_flutter/core/utils/fonts/sf_pro_display.dart';
import 'package:resumate_flutter/core/utils/spacers/spacers.dart';

class AnalyzingPopup extends StatefulWidget {
  const AnalyzingPopup({super.key});

  @override
  State<AnalyzingPopup> createState() => _AnalyzingPopupState();
}

class _AnalyzingPopupState extends State<AnalyzingPopup>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: false);

    _animation = Tween<double>(
      begin: 0.0,
      end: 0.9,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      insetPadding: const EdgeInsets.all(24),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SfProDisplay(
                  text: 'Analyzing Your Resume',

                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                  textColor: Colors.black,
                ),
                spaceH10,

                const Text(
                  'Just reading through your resume.',

                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
                spaceH30,
                SizedBox(
                  height: 200,
                  width: 200,
                  child: AnimatedBuilder(
                    animation: _animation,
                    builder: (context, child) {
                      return Stack(
                        alignment: Alignment.center,
                        children: [
                          SizedBox(
                            height: 200,
                            width: 200,
                            child: CircularProgressIndicator(
                              value: _animation.value,
                              strokeWidth: 14, // Thicker circular stroke
                              valueColor: const AlwaysStoppedAnimation<Color>(
                                Color(0xFF9CE2E8),
                              ),
                              backgroundColor: const Color(0xFFE5F6F8),
                            ),
                          ),
                          const Text(
                            'ANALYZING',
                            style: TextStyle(
                              color: Color(0xFF67C8D3),
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 8,
            right: 8,
            child: InkWell(
              onTap: () => Navigator.of(context).pop(),
              child: const Icon(Icons.close, size: 20, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
