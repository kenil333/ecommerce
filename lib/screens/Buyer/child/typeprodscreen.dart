import 'package:ecommerce/modules/generalClasses.dart';
import 'package:ecommerce/screens/Buyer/Dashboard/produtDetail.dart';
import 'package:flutter/material.dart';

import '../../../customizeCode.dart';

class TypeProdScreen extends StatelessWidget {
  final String title;
  final List<Products> product;
  TypeProdScreen(this.title, this.product);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xFFFAFAFA),
      appBar: CustomizeCode().appBarOfScreens(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomizeCode().firstBadgeforMostOFScrren(
                title,
                size,
                context,
              ),
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.all(20),
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200.0,
                  childAspectRatio: 3 / 4,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                ),
                itemCount: product.length,
                itemBuilder: (ctx, i) {
                  return CustomizeCode().singleproductStemp(
                    () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) => ProductDetailScreen(product[i]),
                        ),
                      );
                    },
                    product[i].image,
                    product[i].name,
                    product[i].price,
                    size,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
