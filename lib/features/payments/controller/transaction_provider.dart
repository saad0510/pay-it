import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../entities/transaction_data.dart';

final transactionProvider = StreamProvider.family<TransactionData, String>(
  (ref, id) {
    final transactions = FirebaseFirestore.instance.collection('transactions');
    final stream = transactions.doc(id).snapshots();
    return stream.map((s) => TransactionData.fromMap(s.data()));
  },
);
