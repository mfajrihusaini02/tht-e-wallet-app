import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nutech_app/models/api_return_value.dart';
import 'package:nutech_app/models/transfer.dart';
import 'package:nutech_app/services/transfer_service.dart';

part 'transfer_state.dart';

class TransferCubit extends Cubit<TransferState> {
  TransferCubit() : super(TransferInitial());

  Future<void> amountTransfer(String amount) async {
    ApiReturnValue<Transfer> result = await TransferService.submitTransfer(amount);

    if (result.value != null) {
      emit(TransferLoaded(result.value));
    } else {
      emit(const TransferLoadingFailed('Gagal top up'));
    }
  }
}
