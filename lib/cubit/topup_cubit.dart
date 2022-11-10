import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nutech_app/models/api_return_value.dart';
import 'package:nutech_app/models/topup.dart';
import 'package:nutech_app/services/topup_service.dart';

part 'topup_state.dart';

class TopupCubit extends Cubit<TopupState> {
  TopupCubit() : super(TopupInitial());

  Future<void> amountTopup(String amount) async {
    ApiReturnValue<Topup> result = await TopupService.submitTopup(amount);

    if (result.value != null) {
      emit(TopupLoaded(result.value));
    } else {
      emit(const TopupLoadingFailed('Gagal top up'));
    }
  }
}
