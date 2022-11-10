import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nutech_app/models/api_return_value.dart';
import 'package:nutech_app/models/balance.dart';
import 'package:nutech_app/services/balance_service.dart';

part 'balance_state.dart';

class BalanceCubit extends Cubit<BalanceState> {
  BalanceCubit() : super(BalanceInitial());

  Future<void> getBalances() async {
    ApiReturnValue<Balance> result = await BalanceService.getBalances();

    if (result.value != null) {
      emit(BalanceLoaded(result.value));
    } else {
      emit(const BalanceLoadingFailed('Gagal ambil data balance'));
    }
  }
}
