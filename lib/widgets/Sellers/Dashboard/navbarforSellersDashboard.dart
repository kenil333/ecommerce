import 'package:flutter/material.dart';

import 'package:ecommerce/screens/sellers/child/addNewAdvertise.dart';

class NavbarOfSellerDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Advertisment',
            style: TextStyle(
              color: Color(0xFF305F72),
              fontSize: size.width * 0.06,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.0,
            ),
          ),
          Row(
            children: [
              IconButton(
                icon: Icon(
                  Icons.add_circle_outline_rounded,
                  size: 28,
                  color: Color(0xFF305F72),
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => AddNewAdvertiseScreen(),
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
