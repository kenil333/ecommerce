import 'package:ecommerce/modules/generalClasses.dart';
import 'package:ecommerce/provider/BackCode.dart';
import 'package:flutter/material.dart';

import 'package:ecommerce/customizeCode.dart';
import 'package:ecommerce/widgets/Buyer/Dashboard/child/finalBageCheckout.dart';
import 'package:ecommerce/widgets/Buyer/Dashboard/child/shippingCheckout.dart';
import 'package:ecommerce/widgets/Buyer/Dashboard/child/paymentCheckout.dart';
import 'package:provider/provider.dart';

class CheckOutScreen extends StatefulWidget {
  final List<OrderProd> order;
  CheckOutScreen(this.order);

  @override
  _CheckOutScreenState createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  double _subtot = 0;
  double _shiping = 0;
  bool _loading = true;
  String _choose = 'CD';

  @override
  void initState() {
    double sub = 0;
    double charge = 0;
    for (int i = 0; i < widget.order.length; i++) {
      sub += widget.order[i].total;
      charge += widget.order[i].dcharge;
    }
    _subtot = sub;
    _shiping = charge;
    _loading = false;
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final String address =
        Provider.of<BackCode>(context, listen: false).me.address;
    final String pincode =
        Provider.of<BackCode>(context, listen: false).me.postcode;
    return Scaffold(
      backgroundColor: Color(0xFFFAFAFA),
      appBar: CustomizeCode().appBarOfScreens(),
      body: SafeArea(
        child: _loading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Stack(
                children: [
                  Container(
                    padding: EdgeInsets.only(bottom: size.height * 0.2),
                    width: double.infinity,
                    height: size.height - MediaQuery.of(context).padding.top,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          CustomizeCode().firstBadgeforMostOFScrren(
                            'Checkout',
                            size,
                            context,
                          ),
                          ShippingToInCheckOut('$address - $pincode'),
                          Divider(
                            color: Colors.grey[700],
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          PaymentChooseCheckOut(
                            _choose,
                            (String choose) {
                              setState(() {
                                _choose = choose;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: FinalBadgeofCheckOutWidget(
                      widget.order,
                      _shiping,
                      _subtot,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
