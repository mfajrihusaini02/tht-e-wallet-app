// ignore_for_file: deprecated_member_use, use_build_context_synchronously, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nutech_app/common/constant.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutech_app/cubit/user_cubit.dart';
import 'package:nutech_app/models/user.dart';
import 'package:nutech_app/screen/done_screen.dart';
import 'package:nutech_app/screen/signin_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);
  static const routeName = '/signup';

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 26),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.fromLTRB(
                    defaultMargin,
                    0,
                    defaultMargin,
                    6,
                  ),
                  child: IconButton(
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        SigninScreen.routeName,
                        (route) => false,
                      );
                    },
                    icon: const Icon(Icons.arrow_back_ios),
                  ),
                ),
                Container(
                  margin:
                      EdgeInsets.fromLTRB(defaultMargin, 0, defaultMargin, 6),
                  width: double.infinity,
                  height: 60,
                  child: Text('Register Account', style: kHeading5),
                ),
                Container(
                  width: double.infinity,
                  margin:
                      EdgeInsets.fromLTRB(defaultMargin, 0, defaultMargin, 6),
                  child: const Text('First Name'),
                ),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: defaultMargin),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.black),
                  ),
                  child: TextField(
                    controller: firstNameController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Your first name',
                    ),
                    style: kSubtitle,
                  ),
                ),
                Container(
                  width: double.infinity,
                  margin:
                      EdgeInsets.fromLTRB(defaultMargin, 16, defaultMargin, 6),
                  child: const Text('Last Name'),
                ),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: defaultMargin),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.black),
                  ),
                  child: TextField(
                    controller: lastNameController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Your last name',
                    ),
                    style: kSubtitle,
                  ),
                ),
                Container(
                  width: double.infinity,
                  margin:
                      EdgeInsets.fromLTRB(defaultMargin, 12, defaultMargin, 6),
                  child: const Text('Email address'),
                ),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: defaultMargin),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.black)),
                  child: TextField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Your email',
                    ),
                    style: kSubtitle,
                  ),
                ),
                Container(
                  width: double.infinity,
                  margin:
                      EdgeInsets.fromLTRB(defaultMargin, 12, defaultMargin, 6),
                  child: const Text('Password'),
                ),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: defaultMargin),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.black),
                  ),
                  child: TextField(
                    obscureText: true,
                    controller: passwordController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Your password',
                    ),
                    style: kSubtitle,
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 45,
                  margin: const EdgeInsets.only(top: 24),
                  padding: EdgeInsets.symmetric(horizontal: defaultMargin),
                  child: (isLoading == true)
                      ? const Center(
                          child: SpinKitFadingCircle(
                            size: 45,
                            color: Colors.blue,
                          ),
                        )
                      : RaisedButton(
                          onPressed: () async {
                            User user = User(
                              email: emailController.text.trim(),
                              firstName: firstNameController.text.trim(),
                              lastName: lastNameController.text.trim(),
                            );
                            setState(() => isLoading = true);

                            await context.read<UserCubit>().signUp(
                                  user,
                                  passwordController.text,
                                );

                            UserState state = context.read<UserCubit>().state;
                            print(state);

                            if (state is UserLoaded) {
                              Navigator.pushReplacementNamed(
                                  context, DoneScreen.routeName);
                            } else {
                              Get.snackbar(
                                '',
                                '',
                                backgroundColor: Colors.red,
                                icon: const Icon(
                                  Icons.sms_failed,
                                  color: Colors.white,
                                ),
                                titleText: Text(
                                  "Sign In Failed",
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                messageText: Text(
                                  (state as UserLoadingFailed)
                                      .message!
                                      .toString()
                                      .trim(),
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                  ),
                                ),
                              );
                              setState(() {
                                isLoading = false;
                              });
                            }
                          },
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          color: Colors.blue,
                          child: Text(
                            'Sign Up Now',
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
      ),
    );
  }
}
