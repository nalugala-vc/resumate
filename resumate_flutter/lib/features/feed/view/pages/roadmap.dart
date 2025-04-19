import 'package:flutter/material.dart';

class Roadmap extends StatelessWidget {
  const Roadmap({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFFFFC), // soft pastel background
      body: SafeArea(
        child: Stack(
          children: [
            // Wavy roadmap line
            Positioned.fill(child: CustomPaint(painter: RoadmapPainter())),

            // Scrollable milestones
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 50,
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 60),
                    _milestone(
                      icon: "⭐️",
                      label: "Started Learning",
                      positionOffset: Offset(-50, 0),
                      color: Colors.amber,
                    ),
                    const SizedBox(height: 120),
                    _milestone(
                      icon: "🚀",
                      label: "Built First Project",
                      positionOffset: Offset(50, 0),
                      color: Colors.blueAccent,
                    ),
                    const SizedBox(height: 120),
                    _milestone(
                      icon: "👩‍💻",
                      label: "Junior Developer",
                      positionOffset: Offset(-50, 0),
                      color: Colors.purpleAccent,
                      current: true,
                    ),
                    const SizedBox(height: 120),
                    _milestone(
                      icon: "💼",
                      label: "Senior Developer",
                      positionOffset: Offset(50, 0),
                      color: Colors.greenAccent,
                    ),
                    const SizedBox(height: 150),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _milestone({
    required String icon,
    required String label,
    required Offset positionOffset,
    required Color color,
    bool current = false,
  }) {
    return Align(
      alignment: Alignment(positionOffset.dx / 100, 0),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.4),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            padding: const EdgeInsets.all(18),
            child: Text(icon, style: const TextStyle(fontSize: 30)),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              color: current ? color.withOpacity(0.8) : Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Text(
              current ? "You're here: $label" : label,
              style: TextStyle(
                color: current ? Colors.white : Colors.black87,
                fontWeight: current ? FontWeight.bold : FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RoadmapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();
    final paint =
        Paint()
          ..color = const Color(0xFFB2EBF2)
          ..strokeWidth = 10
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round;

    // Wavy path logic
    double y = 100;
    bool left = true;

    path.moveTo(size.width / 2, 0);
    while (y < size.height) {
      double dx = left ? 0 : size.width;
      path.quadraticBezierTo(dx, y + 60, size.width / 2, y + 120);
      y += 120;
      left = !left;
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
