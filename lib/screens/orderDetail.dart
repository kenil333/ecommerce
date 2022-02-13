import 'package:ecommerce/modules/generalClasses.dart';
import 'package:ecommerce/provider/BackCode.dart';
import 'package:ecommerce/widgets/Deliver/bottomofconfirmed.dart';
import 'package:flutter/material.dart';

import 'package:ecommerce/customizeCode.dart';
import 'package:ecommerce/widgets/Sellers/Orders/listofdeliveryboy.dart';
import 'package:ecommerce/widgets/Sellers/Orders/packingConfirmwidget.dart';
import 'package:provider/provider.dart';

class OrderDetailScrren extends StatefulWidget {
  //final String from;
  final bool assignButton;
  final bool packButton;
  final bool orderCompleteButton;
  final bool show;
  final OrderData order;
  OrderDetailScrren(
    //this.from,
    this.assignButton,
    this.packButton,
    this.orderCompleteButton,
    this.show,
    this.order,
  );

  @override
  _OrderDetailScrrenState createState() => _OrderDetailScrrenState();
}

class _OrderDetailScrrenState extends State<OrderDetailScrren> {
  TextEditingController _code = TextEditingController();
  List<Deliverynamesex> _del = [];
  bool _loading = true;
  @override
  void initState() {
    Future.delayed(Duration(seconds: 0)).then((_) {
      Provider.of<BackCode>(context, listen: false).fetchdel(
        (List<Deliverynamesex> del) {
          _del = del;
          _loading = false;
          setState(() {});
        },
        (String error) {
          CustomizeCode().snak(error, context);
        },
      );
      if (widget.assignButton) {
      } else {
        _loading = false;
        setState(() {});
      }
    });
    super.initState();
  }

  void _completeorder(Size size, Function tr, Function fa) {
    tr();
    if (_code.text.isEmpty) {
      CustomizeCode().coustomeDiolog(
        'Please Enter the Code !',
        context,
        size,
      );
      fa();
    } else {
      Provider.of<BackCode>(context, listen: false).completorder(
        widget.order.fireid,
        _code.text.trim(),
        widget.order.safeword,
        () {
          fa();
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        },
        () {
          CustomizeCode().coustomeDiolog(
            'Code must be Wrong !',
            context,
            size,
          );
          fa();
        },
        (String error) {
          CustomizeCode().snak(error, context);
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    String _status() {
      String stat;
      if (widget.order.status == 'Panding') {
        stat = 'Delivery Assigning Panding...';
      } else if (widget.order.status == 'Assigned') {
        stat = 'Packing Panding...';
      } else if (widget.order.status == 'Packed') {
        stat = 'Delivering...';
      } else {
        stat = 'Completed';
      }
      return stat;
    }

    IconData _icondata() {
      IconData ico;
      if (widget.order.status == 'Completed') {
        ico = Icons.beenhere_rounded;
      } else if (widget.order.status == 'Packed') {
        ico = Icons.delivery_dining;
      } else {
        ico = Icons.access_time_outlined;
      }
      return ico;
    }

    return Scaffold(
      backgroundColor: Color(0xFFFAFAFA),
      appBar: CustomizeCode().appBarOfScreens(),
      body: SafeArea(
        child: _loading
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                  children: [
                    CustomizeCode().firstBadgeforMostOFScrren(
                      'Order Detail',
                      size,
                      context,
                    ),
                    CustomizeCode().orderStustusatTop(
                      _status(),
                      _icondata(),
                      widget.order.id,
                    ),
                    CustomizeCode().producDetailInOrder(
                      size,
                      widget.order.prod,
                      widget.order.status,
                      widget.order.date,
                      widget.order.assigndate,
                      widget.order.pakedate,
                      widget.order.deliverdate,
                    ),
                    widget.assignButton
                        ? CustomizeCode().buttonForOrderDetailScreen(
                            context,
                            ListOfDeliveryBoySheet(_del, widget.order.fireid),
                            'Assign Delivery',
                          )
                        : SizedBox(),
                    widget.packButton
                        ? CustomizeCode().buttonForOrderDetailScreen(
                            context,
                            PAckingConfirmWidget(widget.order.fireid),
                            'Packing Confirm',
                          )
                        : SizedBox(),
                    CustomizeCode().shippingDetailInOrder(
                      size,
                      widget.order.name,
                      widget.order.address,
                      widget.order.phone,
                    ),
                    CustomizeCode().priceDetailInOrder(
                      size,
                      widget.order.prod,
                      widget.order.shiping,
                      widget.order.total,
                    ),
                    widget.orderCompleteButton
                        ? CustomizeCode().buttonForOrderDetailScreen(
                            context,
                            BottumSheetOfConfirmed(_code, _completeorder),
                            'Order Delivered',
                          )
                        : SizedBox(),
                    widget.show
                        ? Container(
                            margin: EdgeInsets.only(bottom: 20),
                            padding: EdgeInsets.symmetric(
                              vertical: 20,
                              horizontal: size.width * 0.05,
                            ),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset(0, 10),
                                  blurRadius: 10,
                                  color: Color(0xFF305F72).withOpacity(0.23),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Text(
                                  'Delivery Code :     ',
                                  style: TextStyle(
                                    color: Color(0xFF305F72),
                                    fontSize: size.width * 0.04,
                                  ),
                                ),
                                Text(
                                  widget.order.safeword,
                                  style: TextStyle(
                                    fontSize: size.width * 0.07,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF305F72),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Container(),
                  ],
                ),
              ),
      ),
    );
  }
}
