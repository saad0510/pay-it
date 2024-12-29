import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../theme/app_colors.dart';

extension CopyToClipboardExt on BuildContext {
  Future<void> copyToClipboard(String text, {String? title}) async {
    await Clipboard.setData(ClipboardData(text: text));
    if (mounted && title != null) showSnackBar(message: title);
  }
}

extension SnackbarsExtOnContext on BuildContext {
  void showSnackBar({
    required String message,
    Color backgroundColor = AppColors.primary,
    Color foregroundColor = AppColors.white,
    bool allowCopy = false,
  }) {
    ScaffoldMessenger.of(this)
      ..removeCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            message,
            style: TextStyle(color: foregroundColor),
            maxLines: 10,
          ),
          duration: const Duration(seconds: 4),
          behavior: SnackBarBehavior.floating,
          backgroundColor: backgroundColor,
          closeIconColor: foregroundColor,
          action: allowCopy
              ? SnackBarAction(
                  label: 'Copy',
                  textColor: foregroundColor,
                  onPressed: () => copyToClipboard(message),
                )
              : null,
        ),
      );
  }
}
