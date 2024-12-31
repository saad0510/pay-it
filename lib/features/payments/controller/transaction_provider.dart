import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../entities/transaction_data.dart';
import '../entities/transaction_status.dart';

final transactionProvider = StateProvider<TransactionData?>(
  (ref) => TransactionData(
    id: '123',
    amount: 15034,
    receiverName: 'Saad Bin Khalid',
    receiverPhone: '+923133094567',
    message: null,
    status: TransactionStatus.pending,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
);
