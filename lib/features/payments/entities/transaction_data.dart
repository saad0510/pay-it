import '../../../core/extensions/json_ext.dart';
import 'transaction_status.dart';

class TransactionData {
  final String id;
  final int amount;
  final String receiverName;
  final String receiverPhone;
  final String? message;
  final TransactionStatus status;
  final DateTime createdAt;
  final DateTime updatedAt;

  const TransactionData({
    required this.id,
    required this.amount,
    required this.receiverName,
    required this.receiverPhone,
    required this.message,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'amount': amount,
      'receiverName': receiverName,
      'receiverPhone': receiverPhone,
      'message': message,
      'status': status.toMap(),
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory TransactionData.fromMap(dynamic data) {
    final map = Map.from(data ?? {});

    return TransactionData(
      id: map.decodeStr('id'),
      amount: map.decodeInt('amount'),
      receiverName: map.decodeStr('receiverName'),
      receiverPhone: map.decodeStr('receiverPhone'),
      message: map.decodeMaybeStr('message'),
      status: TransactionStatus.fromMap(map['status']),
      createdAt: map.decodeTimestamp('createdAt'),
      updatedAt: map.decodeTimestamp('updatedAt'),
    );
  }

  TransactionData copyWith({
    String? id,
    int? amount,
    String? receiverName,
    String? receiverPhone,
    String? message,
    TransactionStatus? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return TransactionData(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      receiverName: receiverName ?? this.receiverName,
      receiverPhone: receiverPhone ?? this.receiverPhone,
      message: message ?? this.message,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
