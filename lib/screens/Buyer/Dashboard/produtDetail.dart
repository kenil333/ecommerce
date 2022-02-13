import 'package:ecommerce/modules/generalClasses.dart';
import 'package:flutter/material.dart';

import 'package:ecommerce/customizeCode.dart';
import 'package:ecommerce/widgets/Buyer/Dashboard/ProductDetail/secondBadge.dart';
import 'package:ecommerce/widgets/Buyer/Dashboard/ProductDetail/thiredBadge.dart';
import 'package:ecommerce/widgets/Buyer/Dashboard/ProductDetail/finalBadge.dart';

class ProductDetailScreen extends StatelessWidget {
  final Products prod;
  ProductDetailScreen(this.prod);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xFFFAFAFA),
      appBar: CustomizeCode().appBarOfScreens(),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  CustomizeCode().firstBadgeforMostOFScrren(
                    prod.name,
                    size,
                    context,
                  ),
                  SecondBadgeOfProductDetail(prod),
                  ThiredBadgeofProductDetail(prod),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              child: FinalBadgeOfProductDetail(prod.id, prod.price),
            ),
          ],
        ),
      ),
    );
  }
}
