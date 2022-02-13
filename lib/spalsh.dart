import 'package:ecommerce/customizeCode.dart';
import 'package:ecommerce/provider/BackCode.dart';
import 'package:ecommerce/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/Buyer/tabbotom.dart';
import 'screens/deliveryMan/tabscreenOfDeliveryMan.dart';
import 'screens/sellers/tabscreenOfSeller.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 1)).then((_) {
      Provider.of<BackCode>(context, listen: false).autologin(
        () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => LoginScreen(),
            ),
          );
        },
        (String who) {
          if (who == 'Customer') {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                settings: RouteSettings(
                  name: '/CD',
                ),
                builder: (context) => TabBottomScreen(),
              ),
            );
          } else if (who == 'Delivery') {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                settings: RouteSettings(
                  name: '/DD',
                ),
                builder: (context) => TabBottomScreenOfDeliveryMan(),
              ),
            );
          } else {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                settings: RouteSettings(
                  name: '/SD',
                ),
                builder: (context) => TabBottomScreenOfSeller(),
              ),
            );
          }
        },
        (String error) {
          CustomizeCode().snak(error, context);
        },
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.center,
            child: Image.asset(
              'assets/images/logo.png',
              width: size.width * 0.5,
              height: size.width * 0.5,
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(height: size.height * 0.15),
          Align(
            alignment: Alignment.center,
            child: CircularProgressIndicator(),
          ),
        ],
      ),
    );
  }
}
