import 'package:equatable/equatable.dart';
import 'package:nutech_app/models/user.dart';

enum TransactionType { topup, transfer }

class Transaction extends Equatable {
  final String? id;
  final User? user;
  final String? time;
  final TransactionType? type;
  final int? amount;

  Transaction({
    this.id,
    this.user,
    this.time,
    this.type,
    this.amount,
  });

  factory Transaction.fromJson(Map<String, dynamic> data) => Transaction(
        id: data['transaction_id'],
        time: data['transaction_time'],
        type: (data['transaction_type'] == 'topup')
            ? TransactionType.topup
            : TransactionType.transfer,
        amount: data['amount'],
      );

  Transaction copyWith({
    String? id,
    User? user,
    String? time,
    TransactionType? type,
    int? amount,
  }) {
    return Transaction(
      id: id ?? this.id,
      user: user ?? this.user,
      time: time ?? this.time,
      type: type ?? this.type,
      amount: amount ?? this.amount,
    );
  }

  @override
  List<Object?> get props => [id, time, type, amount, user];
}
