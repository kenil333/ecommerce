import 'package:flutter/material.dart';

import 'package:ecommerce/customizeCode.dart';
import 'package:ecommerce/screens/sellers/Dashboard/producteditScreen.dart';
import 'package:ecommerce/modules/generalClasses.dart';

class AllProductSellersWidget extends StatelessWidget {
  final List<Products> iteams;
  AllProductSellersWidget(this.iteams);
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.all(20),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200.0,
          childAspectRatio: 3 / 4,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        itemCount: iteams.length,
        itemBuilder: (ctx, i) {
          return CustomizeCode().singleproductStemp(
            () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => ProductEditScreen(iteams[i]),
                ),
              );
            },
            iteams[i].image,
            iteams[i].name,
            iteams[i].price,
            size,
          );
        },
      ),
    );
  }
}
