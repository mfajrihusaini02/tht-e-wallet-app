import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nutech_app/models/api_return_value.dart';
import 'package:nutech_app/models/transaction.dart';
import 'package:nutech_app/services/transaction_service.dart';

part 'transaction_state.dart';

class TransactionCubit extends Cubit<TransactionState> {
  TransactionCubit() : super(TransactionInitial());

  Future<void> getHistoryTransactions() async {
    ApiReturnValue<List<Transaction>> result =
        await TransactionService.getHistoryTransactions();

    if (result.value != null) {
      emit(TransactionLoaded(result.value!));
    } else {
      emit(const TransactionLoadingFailed('Gagal ambil data transaksi'));
    }
  }
}
