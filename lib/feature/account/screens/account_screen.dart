// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:amazon_clone/feature/account/widgets/single_product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/feature/account/widgets/greet_user.dart';
import 'package:amazon_clone/feature/account/widgets/top_button.dart';
import 'package:amazon_clone/providers/user_provider.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  List<String> list = [
    'https://images.unsplash.com/photo-1698782413216-0d5868fe95b3?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwyMHx8fGVufDB8fHx8fA%3D%3D'
  ];

  @override
  Widget build(BuildContext context) {
    final user = context.read<UserProvider>().user;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(
            decoration:
                const BoxDecoration(gradient: GlobalVariables.appBarGradient),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.topLeft,
                child: Image.asset(
                  GlobalVariables.amazon,
                  color: GlobalVariables.unselectedNavBarColor,
                  height: 40,
                ),
              ),
              const Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 12.0),
                    child: Icon(Icons.notifications_outlined),
                  ),
                  Icon(Icons.search),
                ],
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          GreetUser(user: user),
          const SizedBox(height: 12.0),
          const TopButtons(),
          const SizedBox(height: 12.0),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: const Text(
                      'Your Orders',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: Text(
                      'Your Orders',
                      style: TextStyle(
                        color: GlobalVariables.selectedNavBarColor,
                      ),
                    ),
                  ),
                ],
              ),
              // Order card
              Container(
                height: 170.0,
                padding: const EdgeInsets.all(12),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    return SingleProduct(
                      image: list[index],
                    );
                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
