// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:nutech_app/common/constant.dart';
import 'package:nutech_app/cubit/balance_cubit.dart';
import 'package:nutech_app/cubit/user_cubit.dart';
import 'package:nutech_app/screen/account_edit_screen.dart';
import 'package:nutech_app/screen/signin_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);
  static const routeName = '/account';

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await context.read<UserCubit>().getUser();
        await context.read<BalanceCubit>().getBalances();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: defaultMargin),
                width: MediaQuery.of(context).size.width,
                height: 280,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50),
                  ),
                  color: Colors.blue,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: SafeArea(
                    child: Stack(
                      children: [
                        Column(
                          children: [
                            Text(
                              'My Profile',
                              style: kHeading5.copyWith(color: kWhite),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: defaultMargin * 2),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 150),
                          width: MediaQuery.of(context).size.width,
                          height: 240,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromARGB(66, 116, 110, 110),
                                spreadRadius: -10,
                                blurRadius: 50,
                              ),
                            ],
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: defaultMargin,
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    const Expanded(child: Text('')),
                                    const Expanded(child: Text('')),
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) =>
                                                      const AccountEditScreen()));
                                        },
                                        child: Container(
                                          alignment: Alignment.center,
                                          child: const Icon(
                                            Icons.edit,
                                            size: 25,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  width: 100,
                                  height: 100,
                                  margin: const EdgeInsets.only(bottom: 16),
                                  padding: const EdgeInsets.all(10),
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                        'assets/photo_border.png',
                                      ),
                                    ),
                                  ),
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        image: AssetImage('assets/person.png'),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      (context.read<UserCubit>().state
                                              as UserLoaded)
                                          .user!
                                          .firstName!,
                                      style: GoogleFonts.poppins(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const Text(' '),
                                    Text(
                                      (context.read<UserCubit>().state
                                              as UserLoaded)
                                          .user!
                                          .lastName!,
                                      style: GoogleFonts.poppins(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  (context.read<UserCubit>().state
                                          as UserLoaded)
                                      .user!
                                      .email!,
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: defaultMargin),
                      height: 70,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(66, 116, 110, 110),
                            spreadRadius: -10,
                            blurRadius: 50,
                          ),
                        ],
                        color: Colors.white,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'My balance',
                            style: kHeading6,
                          ),
                          const Text(' '),
                          Text(
                            NumberFormat.currency(
                              symbol: 'Rp ',
                              decimalDigits: 0,
                              locale: 'in-IDR',
                            ).format((context.read<BalanceCubit>().state
                                        as BalanceLoaded)
                                    .balance!
                                    .balance ??
                                '0'),
                            // "\$ ${(context.read<BalanceCubit>().state as BalanceLoaded).balance!.balance ?? '0'}",
                            style: kHeading6.copyWith(color: Colors.green),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.remove('email');
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          SigninScreen.routeName,
                          (route) => false,
                        );
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.center,
                        height: 50,
                        decoration: const BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                        child: Text(
                          'Logout',
                          style: kHeading6.copyWith(color: kWhite),
                        ),
                      ),
                    ),
                  ],
                ),
              )
              // Column(
              //   children: [
              //     Container(
              //       height: 200,
              //       decoration: BoxDecoration(
              //         borderRadius: BorderRadius.only(
              //           bottomLeft: Radius.circular(12),
              //           bottomRight: Radius.circular(12),
              //         ),
              //         color: Colors.blue,
              //       ),
              //     ),
              //     Row(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       children: [
              //         Text(
              //           (context.read<UserCubit>().state as UserLoaded)
              //               .user!
              //               .firstName!,
              //           style: GoogleFonts.poppins(
              //             fontSize: 18,
              //             fontWeight: FontWeight.w500,
              //           ),
              //         ),
              //         const Text(' '),
              //         Text(
              //           (context.read<UserCubit>().state as UserLoaded)
              //               .user!
              //               .lastName!,
              //           style: GoogleFonts.poppins(
              //             fontSize: 18,
              //             fontWeight: FontWeight.w500,
              //           ),
              //         ),
              //       ],
              //     ),
              //     Text(
              //       (context.read<UserCubit>().state as UserLoaded).user!.email!,
              //       style: GoogleFonts.poppins(
              //         fontSize: 18,
              //         color: Colors.grey,
              //       ),
              //     ),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
