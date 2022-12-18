// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:nutech_app/common/constant.dart';
import 'package:nutech_app/cubit/balance_cubit.dart';
import 'package:nutech_app/cubit/transaction_cubit.dart';
import 'package:nutech_app/cubit/transfer_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutech_app/screen/main_screen.dart';

class TransferScreen extends StatefulWidget {
  const TransferScreen({Key? key}) : super(key: key);
  static const routeName = '/transfer';

  @override
  State<TransferScreen> createState() => _TransferScreenState();
}

class _TransferScreenState extends State<TransferScreen> {
  TextEditingController transferController = TextEditingController();
  bool isLoading = false;

  // String _formatNumber(String s) =>
  //     NumberFormat.decimalPattern('en').format(int.parse(s));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transfer'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 40,
                alignment: Alignment.centerLeft,
                child: Text('Amount*', style: kSubtitle),
              ),
              SizedBox(
                width: double.infinity,
                child: TextField(
                  controller: transferController,
                  keyboardType: TextInputType.number,
                  // onChanged: (s) {
                  //   s = _formatNumber(s.replaceAll(',', ''));
                  //   transferController.value = TextEditingValue(
                  //     text: s,
                  //     selection: TextSelection.collapsed(offset: s.length),
                  //   );
                  // },
                  decoration: InputDecoration(
                    helperText: '*Minimal \$50',
                    helperStyle: kSubtitle.copyWith(color: Colors.grey),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    hintText: 'Transfer amount',
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() => transferController.text = '');
                      },
                      icon: const Icon(Icons.cancel),
                    ),
                  ),
                  style: kSubtitle,
                ),
              ),
              const SizedBox(height: 30),
              Wrap(
                children: [
                  _card('\$100'),
                  _card('\$200'),
                  _card('\$500'),
                  _card('\$1000'),
                  _card('\$1500'),
                  _card('\$2000'),
                  _card('\$3000'),
                  _card('\$4000'),
                  _card('\$5000'),
                ],
              ),
              Container(
                width: double.infinity,
                height: 45,
                margin: const EdgeInsets.only(top: 24),
                child: isLoading
                    ? const SpinKitFadingCircle(
                        size: 45,
                        color: Colors.blue,
                      )
                    : RaisedButton(
                        onPressed: (transferController.text.isEmpty) ? null : () async {
                          setState(() => isLoading = true);

                          await context
                              .read<TransferCubit>()
                              .amountTransfer(transferController.text);

                          TransferState state =
                              context.read<TransferCubit>().state;
                          await context.read<BalanceCubit>().getBalances();
                          await context
                              .read<TransactionCubit>()
                              .getHistoryTransactions();

                          if (state is TransferLoaded) {
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
                                "Transfer Failed",
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              messageText: Text(
                                (state as TransferLoadingFailed)
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
                          'Transfer',
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

  Widget _card(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
      margin: const EdgeInsets.only(right: 15, bottom: 15),
      // height: 50,
      width: MediaQuery.of(context).size.width / 3 - 30,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(width: 1),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: kSubtitle.copyWith(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
