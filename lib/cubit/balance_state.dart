part of 'balance_cubit.dart';

abstract class BalanceState extends Equatable {
  const BalanceState();

  @override
  List<Object> get props => [];
}

class BalanceInitial extends BalanceState {}

class BalanceLoaded extends BalanceState {
  final Balance? balance;

  const BalanceLoaded(this.balance);

  @override
  List<Object> get props => [balance!];
}

class BalanceLoadingFailed extends BalanceState {
  final String? message;

  const BalanceLoadingFailed(this.message);

  @override
  List<Object> get props => [message!];
}
