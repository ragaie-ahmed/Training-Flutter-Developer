import 'package:flutter/material.dart';

void showAppSnackBar({
  required BuildContext context,
  required String message,
  required bool isError,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: isError ? Colors.red : Colors.green,
      duration: const Duration(seconds: 2),
    ),
  );
}
