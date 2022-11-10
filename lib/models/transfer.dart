import 'package:equatable/equatable.dart';

class Transfer extends Equatable {
  final int? amount;

  const Transfer({this.amount});

  factory Transfer.fromJson(Map<String, dynamic> data) => Transfer(
        amount: data['amount'],
      );

  @override
  List<Object?> get props => [amount];
}
