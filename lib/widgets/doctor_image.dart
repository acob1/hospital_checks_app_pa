import 'package:flutter/material.dart';
import '../constants/colors.dart';

class DoctorImage extends StatelessWidget {
  final String imagePath;
  final double size;
  final double borderRadius;

  const DoctorImage({
    super.key,
    required this.imagePath,
    this.size = 80,
    this.borderRadius = 12,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: AppColors.lightGrey,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      clipBehavior: Clip.antiAlias,
      child: Image.asset(
        imagePath,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            color: AppColors.lightGrey,
            child: const Icon(
              Icons.person,
              color: AppColors.grey,
              size: 40,
            ),
          );
        },
      ),
    );
  }
}
