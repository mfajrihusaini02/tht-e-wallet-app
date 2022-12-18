// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:nutech_app/common/constant.dart';
import 'package:nutech_app/models/api_return_value.dart';
import 'package:nutech_app/models/user.dart';
import 'package:http/http.dart' as http;

class ProfilService {
  static Future<ApiReturnValue<User>> getUser({
    http.Client? client,
  }) async {
    String url = '${baseUrl}getProfile';

    var response = await client!.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${User.token}',
      },
    );

    if (response.statusCode != 200) {
      return ApiReturnValue(message: 'Please try again');
    }
    print('Get User => ${response.statusCode}');

    var data = json.decode(response.body);
    User.token = data['data']['token'];
    print(User.token);

    User value = User.fromJson(data['data']);

    return ApiReturnValue(value: value);
  }

  static Future<ApiReturnValue<User>> updateUser(
      String editFirstName, String editLastName,
      {http.Client? client}) async {
    String url = '${baseUrl}updateProfile';

    var response = await client!.put(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${User.token}',
      },
      body: jsonEncode(<String, String>{
        'first_name': editFirstName,
        'last_name': editLastName,
      }),
    );

    if (response.statusCode != 200) {
      return ApiReturnValue(message: 'Please try again');
    }
    print('Post UpdateUser => ${response.statusCode}');

    var data = json.decode(response.body);

    User value = User.fromJson(data['data']);

    return ApiReturnValue(value: value);
  }
}