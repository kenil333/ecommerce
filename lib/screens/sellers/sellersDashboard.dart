import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:ecommerce/customizeCode.dart';
import 'package:ecommerce/widgets/Sellers/Dashboard/navbarforSellersDashboard.dart';
import 'package:ecommerce/widgets/Sellers/Dashboard/allProductSeller.dart';
import 'package:ecommerce/modules/generalClasses.dart';
import 'package:ecommerce/screens/sellers/Dashboard/productaddscreen.dart';
import 'package:ecommerce/screens/sellers/child/changePhoto.dart';

class SellersDashboardScreen extends StatefulWidget {
  @override
  _SellersDashboardScreenState createState() => _SellersDashboardScreenState();
}

class _SellersDashboardScreenState extends State<SellersDashboardScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final api = FirebaseDatabase.instance.reference().child('Product').onValue;
    final advertiseAPI =
        FirebaseDatabase.instance.reference().child('Advertise').onValue;
    return Scaffold(
      backgroundColor: Color(0xFFFAFAFA),
      appBar: CustomizeCode().appBarOfScreens(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              NavbarOfSellerDashboard(),
              StreamBuilder(
                stream: advertiseAPI,
                builder: (context, snap) {
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
                      return Container(
                        margin: EdgeInsets.only(top: 10, bottom: 40),
                        width: double.infinity,
                        alignment: Alignment.center,
                        child: CarouselSlider(
                          items: _advertise
                              .map(
                                (i) => InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ChangePhotoScreen(i),
                                      ),
                                    );
                                  },
                                  child: CachedNetworkImage(
                                    imageUrl: i.imageURL,
                                    placeholder: (context, url) => Container(
                                      color: Colors.black12,
                                      alignment: Alignment.center,
                                      child: CircularProgressIndicator(),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              )
                              .toList(),
                          options: CarouselOptions(
                            height: size.height * 0.25,
                            enlargeCenterPage: true,
                            autoPlay: true,
                            autoPlayCurve: Curves.fastOutSlowIn,
                            enableInfiniteScroll: true,
                            autoPlayAnimationDuration:
                                Duration(milliseconds: 800),
                            viewportFraction: 0.8,
                          ),
                        ),
                      );
                    } else {
                      return Container(
                        margin: EdgeInsets.only(top: 10, bottom: 40),
                        width: double.infinity,
                        height: size.height * 0.25,
                        alignment: Alignment.center,
                        child: Text(
                          "Please Enter The Advertisement !",
                          style: TextStyle(
                            fontSize: size.width * 0.045,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                      );
                    }
                  }
                },
              ),
              Row(
                children: [
                  SizedBox(
                    width: 30,
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Products',
                          style: TextStyle(
                            fontSize: size.width * 0.06,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF305F72),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (ctx) => ProductAddScreen(),
                              ),
                            );
                          },
                          child: Icon(
                            Icons.add_circle_outline_rounded,
                            color: Color(0xFF305F72),
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                ],
              ),
              StreamBuilder(
                stream: api,
                builder: (context, snap) {
                  if (snap.connectionState == ConnectionState.waiting) {
                    return Container(
                      alignment: Alignment.center,
                      width: size.width,
                      margin: EdgeInsets.only(top: size.height * 0.1),
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    List<Products> _iteam = [];
                    if (snap.hasData &&
                        !snap.hasError &&
                        snap.data.snapshot.value != null) {
                      Map data = snap.data.snapshot.value;
                      data.forEach(
                        (key, value) {
                          _iteam.add(
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
                      return AllProductSellersWidget(_iteam);
                    } else {
                      return Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: size.width * 0.04,
                          vertical: size.height * 0.1,
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'No Any Product Added By You Please Enter the Products !!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: size.width * 0.045,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                      );
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
