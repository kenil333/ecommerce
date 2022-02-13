import 'package:ecommerce/modules/generalClasses.dart';
import 'package:ecommerce/provider/BackCode.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../login.dart';

class ProfileInDeliveryScreen extends StatelessWidget {
  final Me me;
  final String tot;
  ProfileInDeliveryScreen(this.me, this.tot);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    _singleDetail(String title, String value) {
      return Container(
        margin: EdgeInsets.only(left: 20, right: 20, bottom: 40),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: size.width * 0.05,
                color: Color(0xFF305F72),
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 5),
            Text(
              value,
              style: TextStyle(
                fontSize: value == '20' ? size.width * 0.1 : size.width * 0.06,
                color: value == '20' ? Colors.red : Color(0xFF305F72),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      );
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(
              top: 50,
              bottom: 50,
              left: 20,
              right: 20,
            ),
            width: size.width,
            alignment: Alignment.center,
            child: Column(
              children: [
                me.sex
                    ? Image.asset(
                        'assets/images/male.png',
                        height: size.height * 0.2,
                        fit: BoxFit.fitHeight,
                      )
                    : Image.asset(
                        'assets/images/female.png',
                        height: size.height * 0.2,
                        fit: BoxFit.fitHeight,
                      ),
                SizedBox(height: 15),
                Text(
                  me.name,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF305F72),
                    fontSize: size.width * 0.06,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  '+91 ${me.phone}',
                  style: TextStyle(
                    color: Color(0xFF305F72),
                    fontSize: size.width * 0.05,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          _singleDetail('Email-ID :', me.email),
          _singleDetail(
            'Address :',
            '${me.email} ${me.postcode}',
          ),
          _singleDetail('Total Deliveries :', tot),
          InkWell(
            onTap: () {
              Provider.of<BackCode>(context, listen: false).logout(() {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ),
                );
              });
            },
            child: Container(
              width: double.infinity,
              alignment: Alignment.center,
              margin: EdgeInsets.only(
                bottom: 50,
                top: 0,
                left: 40,
                right: 40,
              ),
              padding: EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF3383CD),
                    Color(0xFF11249F),
                  ],
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                ),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 10),
                    blurRadius: 20,
                    color: Color(0xFF305F72).withOpacity(0.3),
                  ),
                ],
              ),
              child: Text(
                'Logout',
                style: TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontSize: size.width * 0.055,
                  letterSpacing: 1.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
