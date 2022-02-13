import 'package:ecommerce/provider/BackCode.dart';
import 'package:ecommerce/screens/login.dart';
import 'package:ecommerce/screens/sellers/appSettings/categoryList.dart';
import 'package:ecommerce/widgets/Sellers/Orders/deliveryManManagement.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../customizeCode.dart';

class AppSettingsScreen extends StatefulWidget {
  @override
  _AppSettingsScreenState createState() => _AppSettingsScreenState();
}

class _AppSettingsScreenState extends State<AppSettingsScreen> {
  Widget _stemp(Size size, String title, Function func) {
    return InkWell(
      onTap: () {
        func();
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.06,
          vertical: size.height * 0.028,
        ),
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Color(0xFF305F72),
              width: 1.5,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: size.width * 0.06,
                color: Color(0xFF305F72),
                fontWeight: FontWeight.bold,
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: size.width * 0.05,
              color: Color(0xFF305F72),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xFFFAFAFA),
      appBar: CustomizeCode().appBarOfScreens(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _stemp(
                size,
                "Delivery Man",
                () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => DeliveryManManagement(),
                    ),
                  );
                },
              ),
              _stemp(
                size,
                "Category",
                () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => CategoryListInSettings(),
                    ),
                  );
                },
              ),
              _stemp(
                size,
                "Logout",
                () {
                  Provider.of<BackCode>(context, listen: false).logout(() {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ),
                    );
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
