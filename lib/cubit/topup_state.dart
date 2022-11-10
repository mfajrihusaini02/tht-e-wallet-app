part of 'topup_cubit.dart';

abstract class TopupState extends Equatable {
  const TopupState();

  @override
  List<Object> get props => [];
}

class TopupInitial extends TopupState {}

class TopupLoaded extends TopupState {
  final Topup? topup;

  const TopupLoaded(this.topup);

  @override
  List<Object> get props => [topup!];
}

class TopupLoadingFailed extends TopupState {
  final String? message;

  const TopupLoadingFailed(this.message);

  @override
  List<Object> get props => [message!];
}
