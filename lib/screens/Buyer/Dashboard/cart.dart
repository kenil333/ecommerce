import 'package:ecommerce/modules/generalClasses.dart';
import 'package:ecommerce/provider/BackCode.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'package:ecommerce/customizeCode.dart';
import 'package:ecommerce/widgets/Buyer/Dashboard/cart/finalBadgecart.dart';
import 'package:ecommerce/widgets/Buyer/Dashboard/cart/listofcartiteam.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final _phone = Provider.of<BackCode>(context, listen: false).me.phone;
    final api = FirebaseDatabase.instance
        .reference()
        .child('Cart')
        .child(_phone)
        .onValue;
    return Scaffold(
      backgroundColor: Color(0xFFFAFAFA),
      appBar: CustomizeCode().appBarOfScreens(),
      body: SafeArea(
        child: StreamBuilder(
          stream: api,
          builder: (context, snap) {
            if (snap.connectionState == ConnectionState.waiting) {
              return Column(
                children: [
                  CustomizeCode().firstBadgeforMostOFScrren(
                    'Cart',
                    size,
                    context,
                  ),
                  Expanded(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ],
              );
            } else {
              if (snap.hasData &&
                  !snap.hasError &&
                  snap.data.snapshot.value != null) {
                List<CartC> _cart = [];
                snap.data.snapshot.value.forEach(
                  (key, value) {
                    _cart.add(
                      CartC(
                        id: key,
                        count: value['Count'],
                        price: double.parse(value['Price']),
                      ),
                    );
                  },
                );
                return Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: size.height - MediaQuery.of(context).padding.top,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            CustomizeCode().firstBadgeforMostOFScrren(
                              'Cart',
                              size,
                              context,
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.zero,
                              itemCount: _cart.length,
                              itemBuilder: (ctx, i) {
                                return ListOfCartIteamsWidget(
                                  _cart[i],
                                  i,
                                  _cart.length - 1,
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      child: FinalBadgeofCartWidget(_cart),
                    ),
                  ],
                );
              } else {
                return Column(
                  children: [
                    CustomizeCode().firstBadgeforMostOFScrren(
                      'Cart',
                      size,
                      context,
                    ),
                    Expanded(
                      child: CustomizeCode().datanot(
                        size,
                        'Please Enter the Products in the Cart !',
                      ),
                    ),
                  ],
                );
              }
            }
          },
        ),
      ),
    );
  }
}
