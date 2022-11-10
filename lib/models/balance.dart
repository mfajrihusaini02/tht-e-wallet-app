import 'package:equatable/equatable.dart';

class Balance extends Equatable {
  final int? balance;

  const Balance({this.balance});

  factory Balance.fromJson(Map<String, dynamic> data) => Balance(
        balance: data['balance'],
      );

  @override
  List<Object?> get props => [balance];
}
