import 'package:crashid/res/app_colors.dart';
import 'package:flutter/material.dart';

/// Two side-by-side document previews with FRONT / BACK corner labels.
class ProfileDocumentPair extends StatelessWidget {
  final String? assetPath;

  const ProfileDocumentPair({
    super.key,
    this.assetPath,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _DocumentThumb(
            label: 'FRONT',
            assetPath: assetPath ?? '',
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _DocumentThumb(
            label: 'BACK',
            assetPath: assetPath ?? '',
          ),
        ),
      ],
    );
  }
}

class _DocumentThumb extends StatelessWidget {
  final String label;
  final String assetPath;

  const _DocumentThumb({
    required this.label,
    required this.assetPath,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.45,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            // BoxShadow(
            //   color: AppColors.blackColor.withValues(alpha: 0.12),
            //   blurRadius: 6,
            //   offset: const Offset(0, 4),
            // ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                assetPath,
                fit: BoxFit.cover,
              ),
              Positioned(
                left: 8,
                bottom: 8,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: AppColors.whiteColor.withValues(alpha: .3))
                  ),
                  child: Text(
                    label,
                    style: const TextStyle(
                      color: AppColors.whiteColor,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.3,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
