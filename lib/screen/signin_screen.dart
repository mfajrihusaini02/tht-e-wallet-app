// ignore_for_file: use_build_context_synchronously, deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nutech_app/common/constant.dart';
import 'package:nutech_app/cubit/balance_cubit.dart';
import 'package:nutech_app/cubit/transaction_cubit.dart';
import 'package:nutech_app/cubit/user_cubit.dart';
import 'package:nutech_app/screen/main_screen.dart';
import 'package:nutech_app/screen/signup_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({Key? key}) : super(key: key);
  static const routeName = '/signin';

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.blue,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 26),
            child: Column(
              children: [
                Container(
                  margin:
                      EdgeInsets.fromLTRB(defaultMargin, 0, defaultMargin, 6),
                  width: double.infinity,
                  height: 80,
                  child: Text(
                    'Login Account',
                    style: kHeading5,
                  ),
                ),
                Container(
                  width: double.infinity,
                  margin:
                      EdgeInsets.fromLTRB(defaultMargin, 0, defaultMargin, 6),
                  child: Text(
                    'Email address',
                    style: kSubtitle,
                  ),
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
                      EdgeInsets.fromLTRB(defaultMargin, 26, defaultMargin, 6),
                  child: Text(
                    'Password',
                    style: kSubtitle,
                  ),
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
                  child: isLoading
                      ? const SpinKitFadingCircle(
                          size: 45,
                          color: Colors.blue,
                        )
                      : RaisedButton(
                          onPressed: () async {
                            setState(() => isLoading = true);
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            prefs.setString('email', emailController.text);

                            await context.read<UserCubit>().signIn(
                                emailController.text, passwordController.text);

                            UserState state = context.read<UserCubit>().state;
                            await context.read<BalanceCubit>().getBalances();
                            await context
                                .read<TransactionCubit>()
                                .getHistoryTransactions();

                            if (state is UserLoaded) {
                              Navigator.pushReplacementNamed(
                                  context, MainScreen.routeName);
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
                              setState(() => isLoading = false);
                            }
                          },
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          color: Colors.blue,
                          child: Text(
                            'Login',
                            style: GoogleFonts.poppins().copyWith(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 1,
                      width: 50,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 15),
                    Text('OR', style: kSubtitle.copyWith(color: Colors.grey)),
                    const SizedBox(width: 15),
                    Container(
                      height: 1,
                      width: 50,
                      color: Colors.grey,
                    ),
                  ],
                ),
                Container(
                  width: double.infinity,
                  height: 45,
                  margin: const EdgeInsets.only(top: 10),
                  padding: EdgeInsets.symmetric(horizontal: defaultMargin),
                  child: isLoading
                      ? const SpinKitFadingCircle(
                          size: 45,
                          color: Colors.blue,
                        )
                      : RaisedButton(
                          onPressed: () => Navigator.pushNamed(
                            context,
                            SignupScreen.routeName,
                          ),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: const BorderSide(
                              width: 1,
                              color: Colors.blue,
                            ),
                          ),
                          color: kWhite,
                          child: Text(
                            'Create new Account',
                            style: GoogleFonts.poppins().copyWith(
                              color: Colors.blue,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
