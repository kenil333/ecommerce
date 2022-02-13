import 'dart:async';

import 'package:ecommerce/modules/generalClasses.dart';
import 'package:ecommerce/provider/BackCode.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'package:ecommerce/customizeCode.dart';
import 'package:ecommerce/widgets/Buyer/Dashboard/navbarofBuyer.dart';
import 'package:ecommerce/widgets/Buyer/Dashboard/productListwidget.dart';
import 'package:provider/provider.dart';

class BuyerDashboardScreen extends StatefulWidget {
  @override
  _BuyerDashboardScreenState createState() => _BuyerDashboardScreenState();
}

class _BuyerDashboardScreenState extends State<BuyerDashboardScreen> {
  bool _loading = true;
  List<Products> _reco = [];
  List<Products> _sale = [];
  List<Products> _brand = [];

  @override
  void initState() {
    Future.delayed(Duration(seconds: 0)).then((_) {
      Provider.of<BackCode>(context, listen: false).productsfetch(
        (
          List<Products> reco,
          List<Products> onsale,
          List<Products> brand,
        ) {
          _reco = reco;
          _sale = onsale;
          _brand = brand;
          setState(() {});
          Timer(Duration(seconds: 1), () {
            setState(() {
              _loading = false;
            });
          });
        },
        (String error) {
          CustomizeCode().snak(error, context);
        },
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final slidapi =
        FirebaseDatabase.instance.reference().child('Advertise').onValue;
    return Scaffold(
      backgroundColor: Color(0xFFFAFAFA),
      appBar: CustomizeCode().appBarOfScreens(),
      body: SafeArea(
        child: _loading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    NavbarOfBuyerDashboard(),
                    StreamBuilder(
                      stream: slidapi,
                      builder: (
                        BuildContext context,
                        AsyncSnapshot<dynamic> snap,
                      ) {
                        if (snap.connectionState == ConnectionState.waiting) {
                          return Container(
                            margin: EdgeInsets.only(top: 10, bottom: 40),
                            width: double.infinity,
                            height: size.height * 0.25,
                            alignment: Alignment.center,
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          if (snap.hasData &&
                              !snap.hasError &&
                              snap.data.snapshot.value != null) {
                            Map data = snap.data.snapshot.value;
                            List<AdvertiseMent> _advertise = [];
                            data.forEach((key, value) {
                              _advertise.add(
                                AdvertiseMent(
                                  id: key,
                                  imageURL: value['Image'],
                                  keyword: value['Keyword'],
                                  position: value['Position'],
                                ),
                              );
                            });
                            if (_advertise.length > 1) {
                              _advertise.sort((a, b) {
                                return a.position.compareTo(b.position);
                              });
                            }
                            return CustomizeCode().sliderForBoth(
                              _advertise,
                              size,
                              context,
                            );
                          } else {
                            return Container();
                          }
                        }
                      },
                    ),
                    ProductListWidget(
                      'Recomended Products',
                      _reco,
                    ),
                    ProductListWidget(
                      'On-Sale Products',
                      _sale,
                    ),
                    ProductListWidget(
                      'Branded Products',
                      _brand,
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
