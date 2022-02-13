import 'package:flutter/material.dart';

class ShippingToInCheckOut extends StatelessWidget {
  final String address;
  ShippingToInCheckOut(this.address);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(
        bottom: 20,
        left: 30,
        right: 30,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Shipping To :',
            style: TextStyle(
              color: Color(0xFF305F72),
              fontSize: size.width * 0.05,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            address,
            style: TextStyle(
              color: Color(0xFF305F72),
              fontSize: size.width * 0.04,
            ),
          ),
        ],
      ),
    );
  }
}
