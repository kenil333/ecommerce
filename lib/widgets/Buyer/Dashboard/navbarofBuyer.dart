import 'package:flutter/material.dart';

import 'package:ecommerce/screens/Buyer/Dashboard/cart.dart';
import 'package:ecommerce/screens/Buyer/Dashboard/favorite.dart';

class NavbarOfBuyerDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(
                'assets/images/logo.png',
                width: size.width * 0.1,
                height: size.width * 0.1,
                fit: BoxFit.contain,
              ),
              SizedBox(width: size.width * 0.02),
              Text(
                'Welcome',
                style: TextStyle(
                  color: Color(0xFF305F72),
                  fontSize: size.width * 0.06,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.0,
                ),
              ),
            ],
          ),
          Row(
            children: [
              IconButton(
                icon: Icon(
                  Icons.shopping_bag_outlined,
                  size: 30,
                  color: Color(0xFF305F72),
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => CartScreen(),
                    ),
                  );
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.favorite_border,
                  size: 30,
                  color: Color(0xFF305F72),
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => FavoriteScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
