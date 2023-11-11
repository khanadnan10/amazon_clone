// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:amazon_clone/common/widgets/custom_button.dart';
import 'package:amazon_clone/feature/auth/services/auth_service.dart';
import 'package:flutter/material.dart';

import 'package:amazon_clone/constants/enums.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/common/widgets/custom_text_field.dart';

class AuthScreen extends StatefulWidget {
  static const String routeName = '/auth-screen';

  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _signupFormKey = GlobalKey<FormState>();
  final _signinFormKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  AuthService authService = AuthService();

  void signUpUser() {
    authService.signUpUser(
      name: _nameController.text,
      email: _emailController.text,
      context: context,
      password: _passwordController.text,
    );
  }

  void signInUser() {
    authService.signInUser(
      email: _emailController.text,
      context: context,
      password: _passwordController.text,
    );
  }

  // ignore: unused_field
  AuthType _authType = AuthType.login;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: GlobalVariables.greyBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Welcome',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                DefaultTabController(
                  length: 2,
                  child: Column(
                    children: [
                      Container(
                        color: Colors.white,
                        child: TabBar(
                          indicatorColor: Colors.amber,
                          labelColor: Colors.amber,
                          unselectedLabelColor: Colors.grey,
                          // indicatorSize: TabBarIndicatorSize.tab,
                          onTap: (val) {
                            setState(() {
                              _authType =
                                  val == 0 ? AuthType.login : AuthType.signup;
                            });
                          },
                          tabs: const [
                            Tab(text: 'Log in'),
                            Tab(text: 'Sign up'),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: screenSize.height * 0.5,
                        child: TabBarView(
                          physics: const NeverScrollableScrollPhysics(),
                          children: [
                            _login(),
                            _signup(),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _signup() {
    return Form(
      key: _signupFormKey,
      child: Container(
        color: GlobalVariables.backgroundColor,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              CustomTextField(
                hintText: 'Name',
                controller: _nameController,
              ),
              const SizedBox(
                height: 16.0,
              ),
              CustomTextField(
                hintText: 'Email',
                controller: _emailController,
              ),
              const SizedBox(
                height: 16.0,
              ),
              CustomTextField(
                hintText: 'Password',
                controller: _passwordController,
              ),
              const SizedBox(
                height: 16.0,
              ),
              CustomButton(
                text: 'Sign up',
                onPressed: () {
                  if (_signupFormKey.currentState!.validate()) {
                    signUpUser();
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _login() {
    return Form(
      key: _signinFormKey,
      child: Container(
        color: GlobalVariables.backgroundColor,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              CustomTextField(
                hintText: 'Email',
                controller: _emailController,
              ),
              const SizedBox(
                height: 16.0,
              ),
              CustomTextField(
                hintText: 'Password',
                controller: _passwordController,
              ),
              const SizedBox(
                height: 16.0,
              ),
              CustomButton(
                text: 'Log in',
                onPressed: () {
                  if (_signinFormKey.currentState!.validate()) {
                    signInUser();
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
