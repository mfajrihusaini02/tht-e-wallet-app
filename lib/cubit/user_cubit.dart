import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nutech_app/models/api_return_value.dart';
import 'package:nutech_app/models/user.dart';
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

  Future<User>? getUser() async {
    ApiReturnValue<User> result = await UserService.getUser();

    if (result.value != null) {
      emit(UserLoaded(result.value));
    } else {
      emit(const UserLoadingFailed('Gagal ambil data user'));
    }
    return result.value!;
  }

  Future<void> updateUser(String firstName, String lastName) async {
    ApiReturnValue<User> result =
        await UserService.updateUser(firstName, lastName);

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
