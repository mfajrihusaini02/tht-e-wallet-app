// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:nutech_app/common/constant.dart';
import 'package:nutech_app/models/api_return_value.dart';
import 'package:http/http.dart' as http;
import 'package:nutech_app/models/balance.dart';
import 'package:nutech_app/models/user.dart';

class BalanceService {
  static Future<ApiReturnValue<Balance>> getBalances(
      {http.Client? client}) async {
    client = http.Client();

    String url = '${baseUrl}balance';

    var response = await client.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${User.token}',
      },
    );

    if (response.statusCode != 200) {
      return ApiReturnValue(message: 'Please try again');
    }
    print('Get Balance => ${response.statusCode}');

    var data = jsonDecode(response.body);

    Balance balance = Balance.fromJson(data['data']);

    return ApiReturnValue(value: balance);
  }
}
