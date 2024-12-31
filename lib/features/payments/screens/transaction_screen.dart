import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/extensions/price_ext.dart';
import '../../../core/extensions/theme_ext.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_theme.dart';
import '../../../theme/sizes.dart';
import '../controller/transaction_provider.dart';
import '../widgets/mastercard_preview.dart';
import '../widgets/transaction_actions.dart';
import '../widgets/user_tile.dart';

class TransactionScreen extends ConsumerWidget {
  const TransactionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transaction = ref.watch(transactionProvider)!;

    return Scaffold(
      backgroundColor: context.colors.primary,
      appBar: AppBar(
        toolbarHeight: 0,
        systemOverlayStyle: AppTheme.darkOverlay,
      ),
      extendBody: true,
      bottomNavigationBar: const TransactionActions(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DefaultTextStyle(
            style: TextStyle(
              color: context.colors.onPrimary,
            ),
            child: Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Total Amount',
                      textAlign: TextAlign.center,
                    ),
                    Sizes.s24.spaceY,
                    Text(
                      transaction.amount.priceFromCents,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 50,
                        letterSpacing: -2,
                        height: 1,
                        fontWeight: FontWeight.bold,
                        fontFamilyFallback: ['Monospace'],
                      ),
                    ),
                    Sizes.s24.spaceY,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.lock,
                          size: Sizes.s16.value,
                          color: AppColors.success,
                        ),
                        Sizes.s6.spaceX,
                        const Text(
                          'Secure Payment',
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: SingleChildScrollView(
                padding: Sizes.padXY(x: Sizes.s24, y: Sizes.s32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    UserTile(
                      name: transaction.receiverName,
                      phone: transaction.receiverPhone,
                    ),
                    Sizes.s3.spaceY,
                    Sizes.s16.spaceY,
                    const MastercardPreview(),
                    Sizes.s3.spaceY,
                    Sizes.s16.spaceY,
                    TextFormField(
                      maxLines: 3,
                      initialValue: transaction.message,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
                      onEditingComplete: () => FocusManager.instance.primaryFocus?.nextFocus(),
                      validator: (x) => (x ?? '').trim().isEmpty ? '' : null,
                      decoration: const InputDecoration(
                        hintText: 'Type a message',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
