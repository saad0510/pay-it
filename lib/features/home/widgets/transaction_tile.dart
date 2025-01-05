import 'package:flutter/material.dart';

import '../../../core/extensions/theme_ext.dart';
import '../entities/transaction_data.dart';

class TransactionTile extends StatelessWidget {
  const TransactionTile({
    super.key,
    required this.transaction,
  });

  final TransactionData transaction;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        radius: 25,
        backgroundImage: NetworkImage(transaction.imageUrl),
      ),
      title: Text(
        transaction.title,
        style: context.typography.titleLarge,
      ),
      subtitle: Text(
        transaction.category,
        style: context.typography.bodySmall,
      ),
      trailing: Text(
        '\$${transaction.price.toStringAsFixed(2)}',
        style: context.typography.titleLarge,
      ),
    );
  }
}
