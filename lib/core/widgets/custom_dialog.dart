import 'package:flutter/material.dart';

class CustomAlertDialog extends StatelessWidget {
  final String title;
  final String content;
  final VoidCallback onConfirm;
  final VoidCallback? onCancel;
  final Color titleColor;

  const CustomAlertDialog({
    super.key,
    required this.title,
    required this.content,
    required this.onConfirm,
    this.titleColor = Colors.black,
    this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      actionsPadding: EdgeInsets.symmetric(vertical: 8,horizontal: 8),
      title: Text(title, style: TextStyle(color: titleColor)),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            if (onCancel != null) onCancel!();
          },
          child: const Text('Cancel', style: TextStyle(fontSize: 16)),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            onConfirm();
          },
          child: const Text('OK', style: TextStyle(fontSize: 16)),
        ),
      ],
    );
  }
}
