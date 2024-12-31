import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../entities/transaction_data.dart';

final transactionProvider = StateProvider<TransactionData?>((ref) => null);
