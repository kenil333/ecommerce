import 'package:ecommerce/modules/generalClasses.dart';
import 'package:ecommerce/screens/Buyer/child/typeprodscreen.dart';
import 'package:flutter/material.dart';

import 'package:ecommerce/widgets/Buyer/Dashboard/productStemp.dart';

class ProductListWidget extends StatelessWidget {
  final String title;
  final List<Products> prod;
  ProductListWidget(this.title, this.prod);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 10),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 20, right: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: size.width * 0.05,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF305F72),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) => TypeProdScreen(
                          title,
                          prod,
                        ),
                      ),
                    );
                  },
                  child: Text(
                    'See All',
                    style: TextStyle(
                      fontSize: size.width * 0.035,
                      color: Color(0xFF2D2942),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: 280,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.zero,
              itemCount: prod.length,
              itemBuilder: (ctx, i) {
                return ProductStempWidget(
                  prod[i],
                  i == prod.length - 1 ? 1000 : i,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
