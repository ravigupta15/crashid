
import 'package:crashid/core/theme/app_theme_extensions.dart';
import 'package:crashid/res/app_colors.dart';
import 'package:flutter/material.dart';

class HomeActionWidget extends StatelessWidget {
  const HomeActionWidget({super.key, 
    required this.iconAsset,
    required this.label,
    required this.onTap,
  });

  final String iconAsset;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: CustomPaint(
        painter: HalfBorderPainter(),
        child: Container(
          height: 140,
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(iconAsset, fit: BoxFit.contain),
             if (label.isNotEmpty)...[
              const SizedBox(height: 10),
              Text(
                label,
                textAlign: TextAlign.center,
                maxLines: 2,
                style: context.labelLarge.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  color: AppColors.primaryColor,
                ),
              ),
             ]
            ],
          ),
        ),
      ),
    );
  }
}
class HalfBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final rrect = RRect.fromRectAndRadius(rect, const Radius.circular(20));

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2 // Thinner stroke usually looks more "premium"
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xff999999), 
          Color(0xff999999).withValues(alpha: 0.4), 
          Colors.transparent,
        ],
        stops: const [0.0, 0.5, 0.7], 
      ).createShader(rect);

    canvas.drawRRect(rrect, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}