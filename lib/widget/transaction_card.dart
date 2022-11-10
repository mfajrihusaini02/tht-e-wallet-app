import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nutech_app/common/constant.dart';
import 'package:nutech_app/models/transaction.dart';

class TransactionCard extends StatelessWidget {
  final Transaction tr;
  const TransactionCard(this.tr, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 17),
      width: MediaQuery.of(context).size.width,
      // height: 150,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
          border: Border.all(
            width: 0.5,
            color: Colors.grey,
          ),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 20,
              spreadRadius: 10,
            )
          ]),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '#${tr.id!} ${(tr.type == TransactionType.topup) ? 'Top Up' : 'Transfer'}',
                style: kHeading6,
              ),
              Text(
                "${(tr.type == TransactionType.topup) ? '+' : '-'} \$ ${NumberFormat.currency(
                  symbol: '',
                  decimalDigits: 0,
                  locale: 'en-US',
                ).format(tr.amount)}",
                style: kSubtitle.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: (tr.type == TransactionType.topup)
                      ? Colors.green
                      : Colors.red,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Success',
                style: kSubtitle.copyWith(color: Colors.green),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                converDateTime(DateTime.parse(tr.time!)),
                style: kSubtitle,
              ),
            ],
          ),
        ],
      ),
    );
  }

  String converDateTime(DateTime dateTime) {
    String month;

    switch (dateTime.month) {
      case 1:
        month = 'January';
        break;
      case 2:
        month = 'February';
        break;
      case 3:
        month = 'March';
        break;
      case 4:
        month = 'April';
        break;
      case 5:
        month = 'May';
        break;
      case 6:
        month = 'June';
        break;
      case 7:
        month = 'July';
        break;
      case 8:
        month = 'Agustus';
        break;
      case 9:
        month = 'September';
        break;
      case 10:
        month = 'Oktober';
        break;
      case 11:
        month = 'November';
        break;
      default:
        month = 'December';
    }
    return '${dateTime.day} $month ${dateTime.year}';
  }
}
