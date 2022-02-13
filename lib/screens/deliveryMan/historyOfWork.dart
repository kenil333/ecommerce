import 'package:ecommerce/modules/generalClasses.dart';
import 'package:flutter/material.dart';

import 'package:ecommerce/customizeCode.dart';
import 'package:ecommerce/screens/orderDetail.dart';
import 'package:intl/intl.dart';

class HistoryOfWorkScreen extends StatelessWidget {
  final List<OrderData> orders;
  HistoryOfWorkScreen(this.orders);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          CustomizeCode().tagLineforDeliveryMan('Your Work History', size),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            itemCount: orders.length,
            itemBuilder: (context, i) => CustomizeCode().orderList(
              () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => OrderDetailScrren(
                      false,
                      false,
                      false,
                      false,
                      orders[i],
                    ),
                  ),
                );
              },
              size,
              orders[i].status,
              orders[i].total.toStringAsFixed(2),
              '${DateFormat('MMMM dd, yyyy').format(orders[i].date)}',
              orders[i].address,
            ),
          ),
        ],
      ),
    );
  }
}
