import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/feature/account/screens/account_screen.dart';
import 'package:amazon_clone/feature/home/screens/home_screen.dart';
import 'package:flutter/material.dart';

class Bottombar extends StatefulWidget {
  static const String routeName = '/bottom-bar';
  const Bottombar({super.key});

  @override
  State<Bottombar> createState() => _BottombarState();
}

class _BottombarState extends State<Bottombar> {
  int _page = 0;
  double bottomNavBarWidth = 42.0;
  double bottomBarBottomWidth = 5;

  void onTap(value) {
    setState(() {
      _page = value;
    });
  }

  final List<Widget> _screens = const [
    HomeScreen(),
    AccountScreen(),
    Center(child: Text('Shop page')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_page],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _page,
        selectedItemColor: GlobalVariables.selectedNavBarColor,
        unselectedItemColor: GlobalVariables.unselectedNavBarColor,
        backgroundColor: GlobalVariables.backgroundColor,
        iconSize: 28.0,
        onTap: onTap,
        elevation: 0,
        items: [
          BottomNavigationBarItem(
            label: '',
            icon: Container(
              width: bottomNavBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: _page == 0
                        ? GlobalVariables.selectedNavBarColor
                        : GlobalVariables.backgroundColor,
                    width: bottomBarBottomWidth,
                  ),
                ),
              ),
              child: const Icon(
                Icons.home_outlined,
              ),
            ),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Container(
              width: bottomNavBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: _page == 1
                        ? GlobalVariables.selectedNavBarColor
                        : GlobalVariables.backgroundColor,
                    width: bottomBarBottomWidth,
                  ),
                ),
              ),
              child: const Icon(
                Icons.person_outline_outlined,
              ),
            ),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Container(
              width: bottomNavBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: _page == 2
                        ? GlobalVariables.selectedNavBarColor
                        : GlobalVariables.backgroundColor,
                    width: bottomBarBottomWidth,
                  ),
                ),
              ),
              child: const Badge(
                label: Text('2'),
                child: Icon(
                  Icons.shopping_cart_outlined,
                ),
              ),
            ),
          ),
        ],
        showSelectedLabels: false,
        showUnselectedLabels: false,
      ),
    );
  }
}
