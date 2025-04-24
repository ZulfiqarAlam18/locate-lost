import 'package:flutter/material.dart';

class CustomAlertBox {
  static void show({
    required BuildContext context,
    required String title,
    required String content,
    String confirmText = "OK",
    VoidCallback? onConfirm,
    String cancelText = "Cancel",
    VoidCallback? onCancel,
    bool showCancelButton = false,
  }) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        content: Text(content),
        actions: [
          if (showCancelButton)
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                if (onCancel != null) onCancel();
              },
              child: Text(
                cancelText,
                style: const TextStyle(color: Colors.red),
              ),
            ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              if (onConfirm != null) onConfirm();
            },
            child: Text(
              confirmText,
              style: const TextStyle(color: Colors.blue),
            ),
          ),
        ],
      ),
    );
  }
}
