import 'package:codebase_assignment/core/utils/constants/app_constants.dart';
import 'package:codebase_assignment/core/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';

final GlobalKey _alertKey = GlobalKey();

class CustomLoading {
  static bool isDialogOpen(BuildContext context) {
    return _alertKey.currentContext != null;
  }

  static void showLoader(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          key: _alertKey,
          contentPadding: EdgeInsets.all(20),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          content: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircularProgressIndicator(color: AppColors.primary),
              SizedBox(width: 26),
              Text(AppConstants.loading),
            ],
          ),
        );
      },
    );
  }

  static void hideLoader(BuildContext context) {
    if (Navigator.canPop(context)) {
      Navigator.of(context).pop();
    }
  }
}
