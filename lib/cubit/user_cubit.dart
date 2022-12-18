import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nutech_app/models/api_return_value.dart';
import 'package:nutech_app/models/user.dart';
import 'package:nutech_app/services/profil_service.dart';
import 'package:nutech_app/services/user_service.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());

  Future<void> signIn(String email, String password) async {
    ApiReturnValue<User> result = await UserService.signIn(email, password);

    if (result.value != null) {
      emit(UserLoaded(result.value));
    } else {
      emit(const UserLoadingFailed('Gagal masuk akun'));
    }
  }

  Future<void> signUp(User user, String password) async {
    ApiReturnValue<User> result = await UserService.signUp(user, password);

    if (result.value != null) {
      emit(UserLoaded(result.value));
    } else {
      emit(const UserLoadingFailed('Gagal daftar akun'));
    }
  }

  Future<void> getUser() async {
    ApiReturnValue<User> result = await ProfilService.getUser();

    if (result.value != null) {
      emit(UserLoaded(result.value));
    } else {
      emit(const UserLoadingFailed('Gagal ambil data user'));
    }
    // return result.value!;
  }

  Future<void> updateUser(String firstName, String lastName) async {
    ApiReturnValue<User> result =
        await ProfilService.updateUser(firstName, lastName);

    if (result.value != null) {
      emit(UserLoaded(result.value));
    } else {
      emit(const UserLoadingFailed('Gagal perbarui data profil'));
    }
  }

  // Future<void> logout(BuildContext context) async {
  //   ApiReturnValue<User> result = await UserService.logOut();

  //   if (result.value != null) {
  //     emit(UserLoaded(result.value));
  //   } else {
  //     emit(UserLoadingFailed(result.message));
  //   }
  // }
}
