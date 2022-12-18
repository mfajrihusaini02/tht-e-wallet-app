import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:nutech_app/common/constant.dart';
import 'package:nutech_app/cubit/transaction_cubit.dart';
import 'package:nutech_app/models/transaction.dart';
import 'package:nutech_app/widget/custom_tabbar.dart';
import 'package:nutech_app/widget/order_list_item.dart';
import 'package:nutech_app/widget/transaction_card.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({Key? key}) : super(key: key);

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<TransactionCubit>().getHistoryTransactions();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Stack(
            children: [
              SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Container(
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
                                'History transaction',
                                style: kHeading5.copyWith(color: kWhite),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Column(
                children: [
                  Container(height: 120),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height - 180,
                    child: BlocBuilder<TransactionCubit, TransactionState>(
                      builder: (_, state) {
                        if (state is TransactionLoaded) {
                          return ListView(
                            scrollDirection: Axis.vertical,
                            children: [
                              Column(
                                children: state.transactions
                                    .map(
                                      (e) => Padding(
                                        padding: EdgeInsets.only(
                                          left: defaultMargin,
                                          right: defaultMargin,
                                          bottom: defaultMargin,
                                        ),
                                        child: GestureDetector(
                                          onTap: () {},
                                          child: TransactionCard(e),
                                        ),
                                      ),
                                    )
                                    .toList(),
                              )
                            ],
                          );
                        } else {
                          return const Center(
                            child: Text('Empty'),
                          );
                        }
                      },
                    ),
                  ),
                  Container(height: 120),
                ],
              ),
              // SizedBox(height: 200)
            ],
          ),
        ),
      ),
    );
  }
}
