// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:nutech_app/common/constant.dart';
import 'package:nutech_app/models/api_return_value.dart';
import 'package:nutech_app/models/transfer.dart';

import 'package:http/http.dart' as http;
import 'package:nutech_app/models/user.dart';

class TransferService {
  static Future<ApiReturnValue<Transfer>> submitTransfer(String amount,
      {http.Client? client}) async {
    client = http.Client();

    String url = '${baseUrl}transfer';

    var response = await client.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${User.token}',
      },
      body: jsonEncode(<String, dynamic>{
        'amount': amount,
      }),
    );

    if (response.statusCode != 200) {
      return ApiReturnValue(message: 'Please try again');
    }
    print('Post Transfer => ${response.statusCode}');

    var data = jsonDecode(response.body);

    Transfer value = Transfer.fromJson(data);

    return ApiReturnValue(value: value);
  }
}
