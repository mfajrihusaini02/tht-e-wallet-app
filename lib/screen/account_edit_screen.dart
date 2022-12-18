// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nutech_app/common/constant.dart';
import 'package:nutech_app/cubit/user_cubit.dart';
import 'package:nutech_app/screen/account_screen.dart';

class AccountEditScreen extends StatefulWidget {
  const AccountEditScreen({Key? key}) : super(key: key);
  static const routeName = '/editAccount';

  @override
  State<AccountEditScreen> createState() => _AccountEditScreenState();
}

class _AccountEditScreenState extends State<AccountEditScreen> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    TextEditingController editEmailController = TextEditingController(
        text: (context.read<UserCubit>().state as UserLoaded).user!.email!);
    TextEditingController editFirstNameController = TextEditingController(
        text: (context.read<UserCubit>().state as UserLoaded).user!.firstName!);
    TextEditingController editLastNameController = TextEditingController(
        text: (context.read<UserCubit>().state as UserLoaded).user!.lastName!);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Account'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 26),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                margin: EdgeInsets.fromLTRB(defaultMargin, 0, defaultMargin, 6),
                child: const Text('Email address'),
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: defaultMargin),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey),
                ),
                child: TextField(
                  controller: editEmailController,
                  readOnly: true,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Masukkan nama awal',
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                margin: EdgeInsets.fromLTRB(defaultMargin, 0, defaultMargin, 6),
                child: const Text('First name'),
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: defaultMargin),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey),
                ),
                child: TextField(
                  controller: editFirstNameController,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Your first name',
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                margin: EdgeInsets.fromLTRB(defaultMargin, 0, defaultMargin, 6),
                child: const Text('Last name'),
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: defaultMargin),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey),
                ),
                child: TextField(
                  controller: editLastNameController,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Your last name',
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                height: 45,
                margin: const EdgeInsets.only(top: 24),
                padding: EdgeInsets.symmetric(horizontal: defaultMargin),
                child: isLoading
                    ? const SpinKitFadingCircle(
                        size: 45,
                        color: Colors.blue,
                      )
                    : RaisedButton(
                        onPressed: () async {
                          setState(() => isLoading = true);

                          await context.read<UserCubit>().updateUser(
                              editFirstNameController.text,
                              editLastNameController.text);

                          UserState state = context.read<UserCubit>().state;
                          await context.read<UserCubit>().getUser();

                          if (state is UserLoaded) {
                            Navigator.pushReplacementNamed(
                                context, AccountScreen.routeName);
                          } else {
                            Get.snackbar(
                              "",
                              "",
                              backgroundColor: Colors.green,
                              icon: const Icon(
                                Icons.sms_failed,
                                color: Colors.white,
                              ),
                              titleText: Text(
                                "Edit Account Failed",
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              messageText: Text(
                                (state as UserLoadingFailed)
                                    .message!
                                    .toString(),
                                style: GoogleFonts.poppins(color: Colors.white),
                              ),
                            );

                            setState(() => isLoading = false);
                          }
                        },
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        color: Colors.blue,
                        child: Text(
                          'Update Profile',
                          style: GoogleFonts.poppins().copyWith(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
