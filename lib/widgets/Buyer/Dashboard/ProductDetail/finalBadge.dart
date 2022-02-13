import 'package:ecommerce/provider/BackCode.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FinalBadgeOfProductDetail extends StatelessWidget {
  final String id;
  final double prodprice;
  FinalBadgeOfProductDetail(this.id, this.prodprice);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final _phone = Provider.of<BackCode>(context, listen: false).me.phone;
    final api = FirebaseDatabase.instance
        .reference()
        .child('Cart')
        .child(_phone)
        .child(id)
        .onValue;
    return StreamBuilder(
      stream: api,
      builder: (context, snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return Container(
            padding: EdgeInsets.only(
              top: size.height * 0.02,
              bottom: size.height * 0.02,
              right: size.width * 0.05,
              left: size.width * 0.01,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              boxShadow: [
                BoxShadow(
                  color: Color(0xFF305F72),
                  blurRadius: 20,
                ),
              ],
            ),
          );
        } else {
          if (snap.hasData &&
              !snap.hasError &&
              snap.data.snapshot.value != null) {
            int count = snap.data.snapshot.value['Count'];
            double price = double.parse(snap.data.snapshot.value['Price']);
            return Container(
              width: size.width,
              padding: EdgeInsets.only(
                top: size.height * 0.02,
                bottom: size.height * 0.02,
                right: size.width * 0.05,
                left: size.width * 0.01,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFF305F72),
                    blurRadius: 20,
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.remove_circle_outline,
                              color: Color(0xFF305F72),
                              size: size.width * 0.07,
                            ),
                            onPressed: () {
                              Provider.of<BackCode>(context, listen: false)
                                  .addorremovecart(
                                id,
                                count,
                                prodprice,
                                false,
                              );
                            },
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            '$count',
                            style: TextStyle(
                              color: Color(0xFF305F72),
                              fontSize: size.width * 0.06,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.add_circle_outline,
                              color: Color(0xFF305F72),
                              size: size.width * 0.07,
                            ),
                            onPressed: () {
                              Provider.of<BackCode>(context, listen: false)
                                  .addorremovecart(
                                id,
                                count,
                                prodprice,
                                true,
                              );
                            },
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Total :',
                            style: TextStyle(
                              color: Color(0xFF305F72),
                              fontSize: size.width * 0.045,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            '₹ ${price.toStringAsFixed(2)}',
                            style: TextStyle(
                              color: Color(0xFF305F72),
                              fontSize: size.width * 0.055,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            );
          } else {
            return Container(
              width: size.width,
              padding: EdgeInsets.only(
                top: size.height * 0.02,
                bottom: size.height * 0.02,
                right: size.width * 0.05,
                left: size.width * 0.01,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFF305F72),
                    blurRadius: 20,
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.remove_circle_outline,
                              color: Color(0xFF305F72),
                              size: size.width * 0.07,
                            ),
                            onPressed: () {},
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            '0',
                            style: TextStyle(
                              color: Color(0xFF305F72),
                              fontSize: size.width * 0.06,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.add_circle_outline,
                              color: Color(0xFF305F72),
                              size: size.width * 0.07,
                            ),
                            onPressed: () {
                              Provider.of<BackCode>(context, listen: false)
                                  .addorremovecart(
                                id,
                                0,
                                prodprice,
                                true,
                              );
                            },
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Total :',
                            style: TextStyle(
                              color: Color(0xFF305F72),
                              fontSize: size.width * 0.045,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            '₹ 00.00',
                            style: TextStyle(
                              color: Color(0xFF305F72),
                              fontSize: size.width * 0.055,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            );
          }
        }
      },
    );
  }
}
