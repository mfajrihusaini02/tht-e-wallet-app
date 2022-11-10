import 'package:flutter/material.dart';
import 'package:nutech_app/screen/account_screen.dart';
import 'package:nutech_app/screen/home_screen.dart';
import 'package:nutech_app/screen/transaction_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);
  static const routeName = '/main';

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _bottomNavIndex = 0;

  @override
  Widget build(BuildContext context) {
    return _buildAndroid(context);
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      body: _listWidget[_bottomNavIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _bottomNavIndex,
        items: _bottomNavBarItems,
        onTap: _onBottomNavTapped,
      ),
    );
  }

  void _onBottomNavTapped(int index) {
    setState(() {
      _bottomNavIndex = index;
    });
  }

  final List<Widget> _listWidget = [
    const HomeScreen(),
    const TransactionScreen(),
    const AccountScreen(),
  ];

  final List<BottomNavigationBarItem> _bottomNavBarItems = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.other_houses_outlined),
      label: 'Home',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.account_balance_wallet_outlined),
      label: 'Transaction',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.person_outline_outlined),
      label: 'Account',
    ),
  ];
}
