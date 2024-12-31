import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../theme/app_buttons_styles.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/sizes.dart';
import '../controller/transaction_provider.dart';
import '../entities/transaction_status.dart';

class TransactionActions extends ConsumerWidget {
  const TransactionActions({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transaction = ref.watch(transactionProvider);
    if (transaction == null) return const SizedBox.shrink();

    return Animate(
      key: ValueKey(transaction.status),
      effects: const [FadeEffect(), MoveEffect()],
      child: Padding(
        padding: Sizes.s16.pad,
        child: switch (transaction.status) {
          TransactionStatus.pending => const _TransactionPendingActions(),
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
      onPressed: () {
        final notifier = ref.read(transactionProvider.notifier);
        notifier.update(
          (t) => t?.copyWith(status: TransactionStatus.pending),
        );
      },
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
      onPressed: () {
        final notifier = ref.read(transactionProvider.notifier);
        notifier.update(
          (t) => t?.copyWith(status: TransactionStatus.pending),
        );
      },
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
  const _TransactionPendingActions();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ElevatedButton(
          onPressed: () {
            final notifier = ref.read(transactionProvider.notifier);
            notifier.update(
              (t) => t?.copyWith(status: TransactionStatus.approved),
            );
          },
          child: const Text('Send'),
        ),
        Sizes.s10.spaceY,
        ElevatedButton(
          onPressed: () {
            final notifier = ref.read(transactionProvider.notifier);
            notifier.update(
              (t) => t?.copyWith(status: TransactionStatus.declined),
            );
          },
          style: AppButtonsStyles.secondaryElevatedButton,
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}
