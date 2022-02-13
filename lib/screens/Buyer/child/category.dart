import 'dart:async';

import 'package:ecommerce/provider/BackCode.dart';
import 'package:flutter/material.dart';

import 'package:ecommerce/customizeCode.dart';
import 'package:ecommerce/screens/Buyer/Dashboard/produtDetail.dart';
import 'package:ecommerce/modules/generalClasses.dart';
import 'package:provider/provider.dart';

class CategoryDifferentScreen extends StatefulWidget {
  final String title;
  final String wat;
  CategoryDifferentScreen(this.title, this.wat);

  @override
  _CategoryDifferentScreenState createState() =>
      _CategoryDifferentScreenState();
}

class _CategoryDifferentScreenState extends State<CategoryDifferentScreen> {
  bool _loading = true;
  List<Products> _products = [];

  @override
  void initState() {
    Future.delayed(Duration(seconds: 0)).then((_) {
      Provider.of<BackCode>(context, listen: false).adandcate(
        widget.title,
        widget.wat,
        (List<Products> prod) {
          _products = prod;
          setState(() {});
          Timer(
            Duration(seconds: 1),
            () {
              setState(() {
                _loading = false;
              });
            },
          );
        },
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
                    CustomizeCode().firstBadgeforMostOFScrren(
                      widget.title,
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
                                builder: (ctx) =>
                                    ProductDetailScreen(_products[i]),
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
              ),
      ),
    );
  }
}
