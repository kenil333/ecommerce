import 'package:ecommerce/modules/generalClasses.dart';
import 'package:flutter/material.dart';

import 'package:ecommerce/customizeCode.dart';
import 'package:ecommerce/screens/orderDetail.dart';
import 'package:intl/intl.dart';

class DeliveryWorkScreen extends StatelessWidget {
  final List<OrderData> orders;
  DeliveryWorkScreen(this.orders);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          CustomizeCode().tagLineforDeliveryMan('Your Work', size),
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
                      orders[i].status == 'Assigned' ? true : false,
                      orders[i].status == 'Packed' ? true : false,
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
