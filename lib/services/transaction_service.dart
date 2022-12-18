// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:nutech_app/common/constant.dart';
import 'package:nutech_app/models/api_return_value.dart';
import 'package:nutech_app/models/transaction.dart';
import 'package:http/http.dart' as http;
import 'package:nutech_app/models/user.dart';

class TransactionService {
  static Future<ApiReturnValue<List<Transaction>>> getHistoryTransactions(
      {http.Client? client}) async {
    client = http.Client();

    String url = '${baseUrl}transactionHistory';

    var response = await client.get(
      Uri.parse(url),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${User.token}",
      },
    );

    if (response.statusCode != 200) {
      return ApiReturnValue(message: 'Please try again');
    }
    print('Get History => ${response.statusCode}');

    var data = jsonDecode(response.body);

    List<Transaction> transactions =
        (data['data'] as Iterable).map((e) => Transaction.fromJson(e)).toList();

    return ApiReturnValue(value: transactions);
  }
}
