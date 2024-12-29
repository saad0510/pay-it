import 'package:flutter/material.dart';
import '../extensions/nav_ext.dart';

import '../../theme/app_colors.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({
    super.key,
    this.title,
    required this.error,
    this.stackTrace,
  });

  final String? title;
  final Object? error;
  final StackTrace? stackTrace;

  void showSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return ClipRRect(
          borderRadius: const BorderRadiusDirectional.all(Radius.circular(12)),
          child: this,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => copyToClipboard(context),
          tooltip: 'Copy',
          icon: const Icon(Icons.copy_rounded),
        ),
        actions: const [
          CloseButton(),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Center(
              child: Icon(
                Icons.error,
                size: 60,
                color: AppColors.error,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              title ?? 'Error',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
            if (stackTrace != null) ...[
              const SizedBox(height: 40),
              Text(
                stackTrace.toString(),
                style: const TextStyle(
                  color: AppColors.error,
                  fontSize: 13,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  String get message {
    return error?.toString() ?? 'Unknown';
  }

  void copyToClipboard(BuildContext context) {
    String text = 'Title: $title\n';
    text += 'Message: $message\n';
    if (stackTrace != null) text += 'Stacktrace:\n\n$stackTrace\n';
    text = text.trim();

    context.copyToClipboard(
      text,
      title: 'Error has been copied',
    );
  }
}
