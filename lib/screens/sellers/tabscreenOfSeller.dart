import 'package:ecommerce/screens/sellers/appSettings.dart';
import 'package:flutter/material.dart';

import 'package:ecommerce/screens/sellers/sellersDashboard.dart';
import 'package:ecommerce/screens/sellers/searchSeller.dart';
import 'package:ecommerce/screens/sellers/deliverySellers.dart';
import 'package:flutter/services.dart';

class TabBottomScreenOfSeller extends StatefulWidget {
  @override
  _TabBottomScreenOfSellerState createState() =>
      _TabBottomScreenOfSellerState();
}

class _TabBottomScreenOfSellerState extends State<TabBottomScreenOfSeller> {
  int _selectedIndex = 0;
  List _page;

  @override
  void initState() {
    _page = [
      SellersDashboardScreen(),
      SearchForSellerScreen(),
      DeliveryManagementForSellersScrren(),
      AppSettingsScreen(),
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
              _iteam(Icons.delivery_dining, 'Delivery'),
              _iteam(Icons.analytics_outlined, 'AppSettings'),
            ],
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
          ),
        ),
      ),
    );
  }
}
