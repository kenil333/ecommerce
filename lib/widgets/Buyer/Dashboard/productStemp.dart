import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/modules/generalClasses.dart';
import 'package:flutter/material.dart';

import 'package:ecommerce/screens/Buyer/Dashboard/produtDetail.dart';

class ProductStempWidget extends StatelessWidget {
  final Products prod;
  final int i;
  ProductStempWidget(this.prod, this.i);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => ProductDetailScreen(prod),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(
          left: size.width * 0.045,
          right: i == 1000 ? size.width * 0.045 : size.width * 0.01,
          bottom: size.height * 0.03,
          top: size.height * 0.03,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 10),
              blurRadius: 20,
              color: Color(0xFF305F72).withOpacity(0.23),
            ),
          ],
        ),
        width: size.width * 0.4,
        alignment: Alignment.center,
        child: Column(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: size.height * 0.02,
                  horizontal: size.width * 0.02,
                ),
                alignment: Alignment.center,
                child: CachedNetworkImage(
                  imageUrl: prod.image,
                  placeholder: (context, url) => Container(
                    color: Colors.black12,
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                vertical: size.height * 0.01,
                horizontal: size.width * 0.04,
              ),
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    prod.name,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: size.width * 0.038,
                    ),
                  ),
                  Text(
                    '₹ ${prod.price.toStringAsFixed(2)}',
                    style: TextStyle(
                      color: Color(0xFF305F72),
                      fontSize: size.width * 0.042,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
