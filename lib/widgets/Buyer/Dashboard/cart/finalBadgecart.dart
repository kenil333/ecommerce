import 'package:ecommerce/modules/generalClasses.dart';
import 'package:ecommerce/provider/BackCode.dart';
import 'package:flutter/material.dart';

import 'package:ecommerce/screens/Buyer/child/checkout.dart';
import 'package:provider/provider.dart';

class FinalBadgeofCartWidget extends StatefulWidget {
  final List<CartC> cart;
  FinalBadgeofCartWidget(this.cart);

  @override
  _FinalBadgeofCartWidgetState createState() => _FinalBadgeofCartWidgetState();
}

class _FinalBadgeofCartWidgetState extends State<FinalBadgeofCartWidget> {
  bool _queryrun = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    double tot() {
      double _tot = 0;
      for (int i = 0; i < widget.cart.length; i++) {
        _tot += widget.cart[i].price;
      }
      return _tot;
    }

    return Container(
      width: size.width,
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
              Container(
                margin: EdgeInsets.only(top: 30, left: 25),
                child: Row(
                  children: [
                    Text(
                      'Total Iteam :',
                      style: TextStyle(
                        color: Color(0xFF305F72),
                        fontSize: size.width * 0.04,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      '${widget.cart.length}',
                      style: TextStyle(
                        color: Color(0xFF305F72),
                        fontSize: size.width * 0.05,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 30, right: 25),
                child: Row(
                  children: [
                    Text(
                      'Total :',
                      style: TextStyle(
                        color: Color(0xFF305F72),
                        fontSize: size.width * 0.04,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      '₹ ${tot().toStringAsFixed(2)}',
                      style: TextStyle(
                        color: Color(0xFF305F72),
                        fontSize: size.width * 0.05,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          _queryrun
              ? Align(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(),
                )
              : InkWell(
                  onTap: () {
                    setState(() {
                      _queryrun = true;
                    });
                    List<OrderProd> _orderprod = [];
                    for (int i = 0; i < widget.cart.length; i++) {
                      Products _dummy =
                          Provider.of<BackCode>(context, listen: false)
                              .returnprod(widget.cart[i].id);
                      _orderprod.add(
                        OrderProd(
                          id: _dummy.id,
                          name: _dummy.name,
                          image: _dummy.image,
                          price: _dummy.price,
                          dcharge: _dummy.dcharge,
                          count: widget.cart[i].count,
                          total: widget.cart[i].price,
                        ),
                      );
                    }
                    setState(() {
                      _queryrun = false;
                    });
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) => CheckOutScreen(_orderprod),
                      ),
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(
                      bottom: 15,
                      top: 25,
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
                      'Checkout',
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
