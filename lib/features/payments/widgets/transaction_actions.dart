import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/extensions/json_ext.dart';
import '../../../theme/app_buttons_styles.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/sizes.dart';
import '../entities/transaction_data.dart';
import '../entities/transaction_status.dart';

class TransactionActions extends ConsumerWidget {
  const TransactionActions({
    super.key,
    required this.transaction,
  });

  final TransactionData transaction;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Animate(
      key: ValueKey(transaction.status),
      effects: const [FadeEffect(), MoveEffect()],
      child: Padding(
        padding: Sizes.s16.pad,
        child: switch (transaction.status) {
          TransactionStatus.pending => _TransactionPendingActions(transactionId: transaction.id),
          TransactionStatus.approved => const _TransactionApprovedActions(),
          TransactionStatus.declined => const _TransactionDeclinedActions(),
          TransactionStatus.failed => const _TransactionFailedActions(),
        },
      ),
    );
  }
}

class _TransactionApprovedActions extends ConsumerWidget {
  const _TransactionApprovedActions();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.success,
      ),
      child: const Text('Success'),
    );
  }
}

class _TransactionDeclinedActions extends ConsumerWidget {
  const _TransactionDeclinedActions();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.error,
      ),
      child: const Text('Declined'),
    );
  }
}

class _TransactionFailedActions extends ConsumerWidget {
  const _TransactionFailedActions();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.error,
      ),
      child: const Text('Failed'),
    );
  }
}

class _TransactionPendingActions extends ConsumerWidget {
  const _TransactionPendingActions({
    required this.transactionId,
  });

  final String transactionId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void update(TransactionStatus status) async {
      final transactions = FirebaseFirestore.instance.collection('transactions');
      await transactions.doc(transactionId).update({
        'status': status.toMap(),
        'updatedAt': DateTime.now().toFirebaseTimestamp(),
      });
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ElevatedButton(
          onPressed: () => update(TransactionStatus.approved),
          child: const Text('Send'),
        ),
        Sizes.s10.spaceY,
        ElevatedButton(
          onPressed: () => update(TransactionStatus.declined),
          style: AppButtonsStyles.secondaryElevatedButton,
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}
