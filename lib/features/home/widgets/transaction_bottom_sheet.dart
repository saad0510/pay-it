import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../core/extensions/theme_ext.dart';
import '../../../theme/sizes.dart';
import '../entities/transaction_data.dart';
import 'transaction_tile.dart';

class TransactionBottomSheet extends StatefulWidget {
  const TransactionBottomSheet({super.key});

  @override
  State<TransactionBottomSheet> createState() => _TransactionBottomSheetState();
}

class _TransactionBottomSheetState extends State<TransactionBottomSheet> {
  final controller = DraggableScrollableController();

  @override
  Widget build(BuildContext context) {
    const transactions = TransactionData.randomTransactions;

    return DraggableScrollableSheet(
      expand: true,
      snap: true,
      minChildSize: 0.3,
      initialChildSize: 0.5,
      maxChildSize: 1,
      controller: controller,
      builder: (_, controller) {
        return Container(
          decoration: BoxDecoration(
            color: context.colors.onPrimary,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: SingleChildScrollView(
            controller: controller,
            padding: Sizes.padXY(x: Sizes.s16, y: Sizes.s24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Transactions',
                  style: context.typography.headlineSmall,
                ),
                const SizedBox(height: 20),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: AnimateList(
                    delay: const Duration(milliseconds: 300),
                    interval: const Duration(milliseconds: 100),
                    effects: [const MoveEffect(), const FadeEffect()],
                    children: [
                      for (final transaction in transactions)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: TransactionTile(
                            transaction: transaction,
                          ),
                        ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    openSheet();
  }

  void openSheet() async {
    await Future.delayed(const Duration(milliseconds: 300));
    controller.animateTo(
      1,
      duration: const Duration(seconds: 1),
      curve: Curves.decelerate,
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
