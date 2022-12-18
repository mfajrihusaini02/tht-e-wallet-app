// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:nutech_app/common/constant.dart';
import 'package:nutech_app/models/api_return_value.dart';
import 'package:nutech_app/models/user.dart';
import 'package:http/http.dart' as http;

class UserService {
  // Sign In
  static Future<ApiReturnValue<User>> signIn(
    String email,
    String password, {
    http.Client? client,
  }) async {
    client ??= http.Client();

    String url = '${baseUrl}login';

    var response = await client.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode != 200) {
      return ApiReturnValue(message: 'Please try again');
    }
    print('Post Signin => ${response.statusCode}');

    var data = jsonDecode(response.body);

    User.token = data['data']['token'];
    User value = User.fromJson(data['data']);
    print(User.token);

    return ApiReturnValue(value: value);
  }

  // Sign Up
  static Future<ApiReturnValue<User>> signUp(
    User user,
    String password, {
    http.Client? client,
  }) async {
    client ??= http.Client();

    String url = '${baseUrl}registration';

    var response = await client.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(<String, String>{
        'email': user.email!,
        'password': password,
        'first_name': user.firstName!,
        'last_name': user.lastName!,
      }),
    );

    if (response.statusCode != 200) {
      return ApiReturnValue(message: 'Please try again');
    }
    print('Post Signup => ${response.statusCode}');

    var data = json.decode(response.body);

    User value = User.fromJson(data['data']);

    return ApiReturnValue(value: value);
  }

  // static Future<ApiReturnValue<User>> getUser({
  //   http.Client? client,
  // }) async {
  //   String url = '${baseUrl}getProfile';

  //   var response = await client!.get(
  //     Uri.parse(url),
  //     headers: {
  //       'Content-Type': 'application/json',
  //       'Authorization': 'Bearer ${User.token}',
  //     },
  //   );

  //   var data = json.decode(response.body);
  //   User.token = data['data']['token'];
  //   print(User.token);

  //   if (response.statusCode != 200) {
  //     return ApiReturnValue(message: 'Please try again');
  //   }
  //   print('Get User => ${response.statusCode}');

  //   User value = User.fromJson(data['data']);

  //   return ApiReturnValue(value: value);
  // }

  // static Future<ApiReturnValue<User>> updateUser(
  //     String editFirstName, String editLastName,
  //     {http.Client? client}) async {
  //   String url = '${baseUrl}updateProfile';

  //   var response = await client!.post(
  //     Uri.parse(url),
  //     headers: {
  //       'Content-Type': 'application/json',
  //       'Authorization': 'Bearer ${User.token}',
  //     },
  //     body: jsonEncode(<String, String>{
  //       'first_name': editFirstName,
  //       'last_name': editLastName,
  //     }),
  //   );

  //   if (response.statusCode != 200) {
  //     return ApiReturnValue(message: 'Please try again');
  //   }
  //   print('Post UpdateUser => ${response.statusCode}');

  //   var data = json.decode(response.body);

  //   User value = User.fromJson(data['data']);

  //   return ApiReturnValue(value: value);
  // }

  // Logout
  // static logOut() async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   pref.remove('email');

  //   Navigator.pushAndRemoveUntil(
  //     context,
  //     MaterialPageRoute(
  //       builder: (BuildContext context) => const SigninScreen(),
  //     ),
  //     (route) => false,
  //   );
  // }
}
