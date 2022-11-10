import 'package:equatable/equatable.dart';

class Topup extends Equatable {
  final int? amount;

  const Topup({this.amount});

  factory Topup.fromJson(Map<String, dynamic> data) => Topup(
        amount: data['amount'],
      );

  @override
  List<Object?> get props => [amount];
}
