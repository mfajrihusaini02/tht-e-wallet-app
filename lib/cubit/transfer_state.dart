part of 'transfer_cubit.dart';

abstract class TransferState extends Equatable {
  const TransferState();

  @override
  List<Object> get props => [];
}

class TransferInitial extends TransferState {}

class TransferLoaded extends TransferState {
  final Transfer? transfer;

  const TransferLoaded(this.transfer);

  @override
  List<Object> get props => [transfer!];
}

class TransferLoadingFailed extends TransferState {
  final String? message;

  const TransferLoadingFailed(this.message);

  @override
  List<Object> get props => [message!];
}
