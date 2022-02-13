import 'package:ecommerce/modules/generalClasses.dart';
import 'package:flutter/material.dart';

class ThiredBadgeofProductDetail extends StatelessWidget {
  final Products prod;
  ThiredBadgeofProductDetail(this.prod);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(bottom: size.height * 0.15),
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            alignment: Alignment.centerLeft,
            child: Text(
              'Description',
              style: TextStyle(
                fontSize: size.width * 0.05,
                color: Color(0xFF305F72),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: double.infinity,
            alignment: Alignment.centerLeft,
            child: Text(
              prod.description,
              style: TextStyle(
                fontSize: size.width * 0.04,
                color: Color(0xFF305F72),
              ),
              textAlign: TextAlign.justify,
            ),
          ),
          SizedBox(height: 20),
          Container(
            width: double.infinity,
            alignment: Alignment.centerLeft,
            child: Text(
              'Shiping Charg :',
              style: TextStyle(
                fontSize: size.width * 0.05,
                color: Color(0xFF305F72),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: double.infinity,
            alignment: Alignment.centerLeft,
            child: Text(
              '₹ ${prod.dcharge.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: size.width * 0.05,
                color: Color(0xFF305F72),
              ),
              textAlign: TextAlign.justify,
            ),
          ),
        ],
      ),
    );
  }
}
