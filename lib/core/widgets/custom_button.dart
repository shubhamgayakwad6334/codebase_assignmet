import 'package:codebase_assignment/core/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final bool isLoading;
  final VoidCallback onPressed;

  const CustomButton({super.key, required this.title, required this.onPressed, this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        minimumSize: const Size(double.infinity, 58),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.primary,
        disabledBackgroundColor: AppColors.primary,
      ),
      child: isLoading
          ? const CircularProgressIndicator(color: Colors.white, strokeWidth: 2)
          : Text(
              title,
              style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
            ),
    );
  }
}
