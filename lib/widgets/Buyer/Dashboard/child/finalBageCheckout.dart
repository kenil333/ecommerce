import 'package:ecommerce/customizeCode.dart';
import 'package:ecommerce/modules/generalClasses.dart';
import 'package:ecommerce/provider/BackCode.dart';
import 'package:ecommerce/screens/Buyer/Dashboard/orderpromp.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FinalBadgeofCheckOutWidget extends StatefulWidget {
  final List<OrderProd> order;
  final double ship;
  final double sub;
  FinalBadgeofCheckOutWidget(this.order, this.ship, this.sub);

  @override
  _FinalBadgeofCheckOutWidgetState createState() =>
      _FinalBadgeofCheckOutWidgetState();
}

class _FinalBadgeofCheckOutWidgetState
    extends State<FinalBadgeofCheckOutWidget> {
  bool _queryrun = false;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    _everyContainer(Size size, String title, String value) {
      return Container(
        margin: EdgeInsets.only(bottom: 5, left: 20, right: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                color: Color(0xFF305F72),
                fontSize:
                    title == 'Total' ? size.width * 0.05 : size.width * 0.04,
              ),
            ),
            Text(
              value,
              style: TextStyle(
                fontSize:
                    title == 'Total' ? size.width * 0.06 : size.width * 0.05,
                fontWeight: FontWeight.bold,
                color: Color(0xFF305F72),
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      padding: EdgeInsets.only(top: 25),
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
          _everyContainer(
              size, 'Shipping Charge', '₹ ${widget.ship.toStringAsFixed(2)}'),
          _everyContainer(
              size, 'Sub Total', '₹ ${widget.sub.toStringAsFixed(2)}'),
          _everyContainer(size, 'Total',
              '₹ ${(widget.ship + widget.sub).toStringAsFixed(2)}'),
          Container(
            margin: EdgeInsets.only(
              top: 15,
              bottom: 25,
              left: 40,
              right: 40,
            ),
            child: _queryrun
                ? Align(
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(),
                  )
                : InkWell(
                    onTap: () {
                      setState(() {
                        _queryrun = true;
                      });
                      Provider.of<BackCode>(context, listen: false).order(
                        widget.order,
                        widget.ship.toStringAsFixed(2),
                        widget.sub.toStringAsFixed(2),
                        (widget.ship + widget.sub).toStringAsFixed(2),
                        (String count) {
                          setState(() {
                            _queryrun = false;
                          });
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => OrderPromptScreen(count),
                            ),
                          );
                        },
                        (String error) {
                          CustomizeCode().snak(error, context);
                        },
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color(0xFF3383CD),
                            Color(0xFF11249F),
                          ],
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                        ),
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 10),
                            blurRadius: 20,
                            color: Color(0xFF305F72).withOpacity(0.3),
                          ),
                        ],
                      ),
                      child: Text(
                        'Payment',
                        style: TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontSize: size.width * 0.055,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
