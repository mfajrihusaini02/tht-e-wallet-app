import 'dart:convert';

import 'package:nutech_app/common/constant.dart';
import 'package:nutech_app/models/api_return_value.dart';
import 'package:nutech_app/models/topup.dart';
import 'package:http/http.dart' as http;
import 'package:nutech_app/models/user.dart';

class TopupService {
  static Future<ApiReturnValue<Topup>> submitTopup(String amount,
      {http.Client? client}) async {
    client = http.Client();

    String url = '${baseUrl}topup';

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

    var data = jsonDecode(response.body);

    Topup value = Topup.fromJson(data['data']);
    print(value.toString());

    return ApiReturnValue(value: value);
  }
}
