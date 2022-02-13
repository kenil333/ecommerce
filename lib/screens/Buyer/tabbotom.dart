import 'package:flutter/material.dart';

import 'package:ecommerce/screens/Buyer/buyerDashboard.dart';
import 'package:ecommerce/screens/Buyer/search.dart';
import 'package:ecommerce/screens/Buyer/orderList.dart';
import 'package:ecommerce/screens/Buyer/profile.dart';
import 'package:flutter/services.dart';

class TabBottomScreen extends StatefulWidget {
  @override
  _TabBottomScreenState createState() => _TabBottomScreenState();
}

class _TabBottomScreenState extends State<TabBottomScreen> {
  int _selectedIndex = 0;
  List _page;

  void _taped() {
    setState(() {
      _selectedIndex = 2;
    });
  }

  @override
  void initState() {
    _page = [
      BuyerDashboardScreen(),
      SearchScreen(),
      OrderListScreen(),
      ProfileScreen(_taped),
    ];
    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  _iteam(IconData icon, String title) {
    return BottomNavigationBarItem(
      icon: Icon(
        icon,
        color: Colors.grey,
      ),
      label: title,
      activeIcon: Icon(
        icon,
        color: Color(0xFF305F72),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_selectedIndex == 0) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Are you sure ?'),
              content: Text('Do you want to exit ?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text(
                    'No',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
                TextButton(
                  onPressed: () => SystemNavigator.pop(),
                  child: Text(
                    'Yes',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ],
            ),
          );
        } else {
          setState(() {
            _selectedIndex = 0;
          });
        }
        return false;
      },
      child: Scaffold(
        body: _page[_selectedIndex],
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Color(0xFF305F72),
                blurRadius: 25,
              ),
            ],
          ),
          child: BottomNavigationBar(
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items: [
              _iteam(Icons.home_rounded, 'Home'),
              _iteam(Icons.search, 'Search'),
              _iteam(Icons.shop_outlined, 'Orders'),
              _iteam(Icons.account_circle_outlined, 'Profile'),
            ],
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
          ),
        ),
      ),
    );
  }
}
