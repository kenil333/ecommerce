import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'package:ecommerce/customizeCode.dart';
import 'package:ecommerce/screens/sellers/Dashboard/producteditScreen.dart';
import 'package:ecommerce/modules/generalClasses.dart';

class CategoryDifferentScreenInSellers extends StatelessWidget {
  final Category category;
  CategoryDifferentScreenInSellers(this.category);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final api = FirebaseDatabase.instance
        .reference()
        .child('Product')
        .orderByChild('Category')
        .equalTo(category.name)
        .onValue;
    return Scaffold(
      backgroundColor: Color(0xFFFAFAFA),
      appBar: CustomizeCode().appBarOfScreens(),
      body: SafeArea(
        child: StreamBuilder(
          stream: api,
          builder: (
            BuildContext context,
            AsyncSnapshot<dynamic> snap,
          ) {
            if (snap.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (snap.hasData &&
                  !snap.hasError &&
                  snap.data.snapshot.value != null) {
                List<Products> _products = [];
                snap.data.snapshot.value.forEach(
                  (key, value) {
                    _products.add(
                      Products(
                        id: key,
                        name: value['Name'],
                        image: value['Image'],
                        price: double.parse(value['Price']),
                        dcharge: double.parse(value['D-Charge']),
                        category: value['Category'],
                        ptype: value['P-Type'],
                        atype: value['A-Type'],
                        description: value['Description'],
                      ),
                    );
                  },
                );
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      CustomizeCode().firstBadgeforMostOFScrren(
                        category.name,
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
                        itemCount: _products.length,
                        itemBuilder: (ctx, i) {
                          return CustomizeCode().singleproductStemp(
                            () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ProductEditScreen(_products[i]),
                                ),
                              );
                            },
                            _products[i].image,
                            _products[i].name,
                            _products[i].price,
                            size,
                          );
                        },
                      ),
                    ],
                  ),
                );
              } else {
                return CustomizeCode().datanot(
                  size,
                  'There is No any Product of ${category.name} type !',
                );
              }
            }
          },
        ),
      ),
    );
  }
}
