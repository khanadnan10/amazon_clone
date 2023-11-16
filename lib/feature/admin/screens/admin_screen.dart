import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/feature/admin/screens/product_screen.dart';
import 'package:flutter/material.dart';

class AdminScreen extends StatefulWidget {
  static const String routeName = '/admin-screen';
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  int _page = 0;
  double bottomNavBarWidth = 42.0;
  double bottomBarBottomWidth = 5;

  void onTap(value) {
    setState(() {
      _page = value;
    });
  }

  final List<Widget> _screens = const [
    ProductScreen(),
    Center(child: Text('Analytics page')),
    Center(child: Text('Cart page')),
  ];

  @override
  Widget build(BuildContext context) {
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
              const Text(
                'Admin',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
      ),
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
                Icons.analytics_outlined,
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
              child: const Icon(
                Icons.category_outlined,
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
