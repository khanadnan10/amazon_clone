import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/feature/auth/model/user.dart';
import 'package:flutter/material.dart';

class GreetUser extends StatelessWidget {
  const GreetUser({
    super.key,
    required this.user,
  });

  final User user;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: GlobalVariables.appBarGradient,
      ),
      padding: const EdgeInsets.all(10.0).copyWith(bottom: 10),
      child: RichText(
        text: TextSpan(
            text: 'Hello, ',
            style: const TextStyle(
              fontSize: 22.0,
              color: Colors.black,
            ),
            children: [
              TextSpan(
                text: user.name,
                style: const TextStyle(
                  fontSize: 22.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              )
            ]),
      ),
    );
  }
}
