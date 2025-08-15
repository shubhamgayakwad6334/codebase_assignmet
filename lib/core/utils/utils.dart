import 'package:codebase_assignment/core/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';

class Utils {
  static void showSnackBar(BuildContext context, message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: isError ? AppColors.red : AppColors.green),
    );
  }
  static final RegExp emailRegex = RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");

  static String extractName(String email) {
    String firstName = email.split('@').first;
    if (firstName.isNotEmpty) {
      firstName = firstName[0].toUpperCase() + firstName.substring(1);
    }

    return firstName;
  }
}
