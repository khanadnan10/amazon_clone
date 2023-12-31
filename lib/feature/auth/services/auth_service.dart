// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:amazon_clone/common/widgets/bottom_bar.dart';
import 'package:amazon_clone/constants/enums.dart';
import 'package:amazon_clone/constants/error_handling.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/feature/admin/screens/admin_screen.dart';
import 'package:amazon_clone/feature/auth/model/user.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  void signUpUser({
    required String name,
    required String email,
    required BuildContext context,
    required String password,
    UserType type = UserType.user,
  }) async {
    try {
      User user = User(
        id: 'id',
        name: name,
        password: password,
        email: email,
        address: 'address',
        type: type.name,
        token: 'token',
      );

      http.Response res = await http.post(
        Uri.parse('$uri/api/signup'),
        body: user.toJson(),
        headers: GlobalVariables.headers,
      );

      httpErrorHandling(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(context, 'Account has been created');
        },
      );
    } catch (e) {
      showSnackBar(
        context,
        e.toString(),
      );
    }
  }

  // Signin user state persistent ----------------------------------------------
  void getUserData({
    required BuildContext context,
  }) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String? token = pref.getString('x-auth-token');

      if (token == null) {
        pref.setString('x-auth-token', '');
      }

      http.Response tokenResponse = await http.post(
        Uri.parse('$uri/isValidToken'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token!,
        },
      );
      // print(" token response: ${tokenResponse.body}");

      var responce = jsonDecode(tokenResponse.body);

      // check if the response is true or false
      if (responce == true) {
        http.Response userRes = await http.get(
          Uri.parse('$uri/'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token,
          },
        );
        Provider.of<UserProvider>(context, listen: false).setUser(userRes.body);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  // Sign in user -------------------------------------------------------------
  void signInUser({
    required String email,
    required BuildContext context,
    required String password,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/signin'),
        body: jsonEncode({
          "email": email,
          "password": password,
        }),
        headers: GlobalVariables.headers,
      );

      httpErrorHandling(
        response: res,
        context: context,
        onSuccess: () async {
          showSnackBar(context, 'Welcome back!');
          SharedPreferences pref = await SharedPreferences.getInstance();
          Provider.of<UserProvider>(context, listen: false).setUser(res.body);
          pref.setString('x-auth-token', jsonDecode(res.body)['token']);
          jsonDecode(res.body)['type'] == UserType.user.name
              ? Navigator.pushNamedAndRemoveUntil(
                  context,
                  Bottombar.routeName,
                  (route) => false,
                )
              : Navigator.pushNamedAndRemoveUntil(
                  context,
                  AdminScreen.routeName,
                  (route) => false,
                );
        },
      );
    } catch (e) {
      showSnackBar(
        context,
        e.toString(),
      );
    }
  }
}
